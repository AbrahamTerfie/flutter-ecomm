import 'package:hilu_flutter/models/product.dart';
import 'package:hilu_flutter/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final List<Product> products;

  AppState({@required this.user , @required this.products} );

  factory AppState.inital() {
    return AppState(user: null, products: []);
  }
}
