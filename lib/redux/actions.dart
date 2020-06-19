import 'dart:convert';
import 'package:hilu_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:hilu_flutter/models/app_state.dart';
import 'package:hilu_flutter/models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// for user actions
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();

  final String storedUser = prefs.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;

  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  //get user action

  final User _user;

  User get user => this._user;
  GetUserAction(this._user);
}

// products actions

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http.get('http://10.0.2.2:1337/products');
  final responseData = json.decode(response.body);

  List<Product> products = [];

  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });

  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<Product> _products;
  List<Product> get products => this._products;

  GetProductsAction(this._products);
}
