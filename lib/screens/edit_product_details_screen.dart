import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/utils/shop_theme.dart';

class EditProductDetailsScreen extends StatefulWidget {
  static const routeName = '/edit-product-details';

  const EditProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _EditProductDetailsScreenState createState() =>
      _EditProductDetailsScreenState();
}

class _EditProductDetailsScreenState extends State<EditProductDetailsScreen> {
  final FocusNode _priceNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final FocusNode _imageUrlNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _init = false;
  // final loadedProduct = ModalRoute.of(context)!.settings.arguments != null
  //     ? ModalRoute.of(context)!.settings.arguments as Product
  //     : null; // is the id!
  Product loadedProduct = Product(
    id: DateTime.now().toString(),
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  _updateImageUrl() {
    if (!_imageUrlNode.hasFocus) {
      var isValid = _validateImageUrl(_imageUrlController.text);
      if (isValid != null) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var arg = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Product
        : null;
    if (!_init && arg != null) {
      loadedProduct = Product(
          id: arg.id,
          title: arg.title,
          description: arg.description,
          price: arg.price,
          imageUrl: arg.imageUrl);
      _imageUrlController.text = arg.imageUrl;
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? _validateImageUrl(value) {
    if (value!.isEmpty) {
      return 'Enter image url';
    }
    if (!((value.toString().startsWith('https') ||
            value.toString().startsWith('http')) &&
        (value.toString().endsWith('.png') ||
            value.toString().endsWith('.jpeg') ||
            value.toString().endsWith('.jpg')))) {
      return 'Enter valid image url';
    }
    return null;
  }

  bool _isLoading = false;

  _submitForm() async {
    var isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      var arg = ModalRoute.of(context)!.settings.arguments != null
          ? ModalRoute.of(context)!.settings.arguments as Product
          : null;
      try {
        setState(() {
          _isLoading = true;
        });
        if (arg == null) {
          await Provider.of<ProductProvider>(
            context,
            listen: false,
          ).addProduct(
            loadedProduct,
          );
        } else {
          await Provider.of<ProductProvider>(
            context,
            listen: false,
          ).updateProduct(
            loadedProduct,
          );
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error while processing' + e.toString()),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct != null
              ? 'Edit : ' + loadedProduct.title
              : 'Add Product',
        ),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter title';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loadedProduct = Product(
                          id: loadedProduct.id,
                          title: value,
                          description: loadedProduct.description,
                          price: loadedProduct.price,
                          imageUrl: loadedProduct.imageUrl,
                        );
                      },
                      initialValue: loadedProduct.title,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Price'),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionNode);
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Enter price';
                        } else {
                          if (value.isEmpty) {
                            return 'Enter price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter valid price';
                          }
                          if (double.parse(value) < 0.0) {
                            return 'Enter valid price greter then zero';
                          }
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loadedProduct = Product(
                          id: loadedProduct.id,
                          title: loadedProduct.title,
                          description: loadedProduct.description,
                          price: double.parse(value),
                          imageUrl: loadedProduct.imageUrl,
                        );
                      },
                      initialValue: loadedProduct.price.toString(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Description'),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter description';
                        }
                        if (value.length < 10) {
                          return 'Description should be greater then 10 Characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loadedProduct = Product(
                          id: loadedProduct.id,
                          title: loadedProduct.title,
                          description: value,
                          price: loadedProduct.price,
                          imageUrl: loadedProduct.imageUrl,
                        );
                      },
                      initialValue: loadedProduct.description,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: ShopTheme.dynamicHeight(context, 500),
                            width: ShopTheme.dynamicWidth(context, 100),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text(
                                    'Input Image Url',
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text('Image Url'),
                              ),
                              controller: _imageUrlController,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: _updateImageUrl,
                              validator: _validateImageUrl,
                              focusNode: _imageUrlNode,
                              onFieldSubmitted: (_) {
                                _submitForm();
                              },
                              onChanged: (value) {
                                loadedProduct = Product(
                                  id: loadedProduct.id,
                                  title: loadedProduct.title,
                                  description: loadedProduct.description,
                                  price: loadedProduct.price,
                                  imageUrl: value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
