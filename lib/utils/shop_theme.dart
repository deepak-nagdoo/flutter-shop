import 'package:flutter/material.dart';

class ShopTheme {
  static final primeC = Colors.purple;
  static main(BuildContext context) {
    return ThemeData(
      primaryColor: primeC,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          fontSize: 18,
        ),
      ),
      canvasColor: Colors.orange.shade50,
      appBarTheme: appBar(context),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.orange,
      ),
    );
  }

  static appBar(context) {
    return AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      color: primeC,
    );
  }

  static singleUnit(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width / 360;
  }

  static dynamicWidth(BuildContext ctx, width) {
    return singleUnit(ctx) * width;
  }

  static dynamicHeight(BuildContext ctx, height) {
    return MediaQuery.of(ctx).size.height - dynamicWidth(ctx, height);
  }
}
