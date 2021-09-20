Map EndPoints = {
  ENDPOINTS.BaseUrl:
      'flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app',
  ENDPOINTS.Products: '/products.json',
  ENDPOINTS.GetProduct:
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
  ENDPOINTS.AddProduct:
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
  ENDPOINTS.UpdateProduct: (id) =>
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json',
  ENDPOINTS.DeleteProduct: (id) =>
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json',
  ENDPOINTS.GetOrders: (id) =>
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json',
  ENDPOINTS.AddOrder: (id) =>
      'https://flutter-shop-aec66-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json',
};

enum ENDPOINTS {
  BaseUrl,
  Products,
  GetProduct,
  AddProduct,
  UpdateProduct,
  DeleteProduct,
  GetOrders,
  AddOrder,
}
