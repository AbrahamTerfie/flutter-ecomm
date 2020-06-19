
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hilu_flutter/models/app_state.dart';
import 'package:hilu_flutter/widgets/products_item.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.deepOrange[100],
      Colors.deepOrange[200],
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
    ]));

class ProductsPage extends StatefulWidget {
  final void Function() onInit;

  ProductsPage({this.onInit});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: SizedBox(
              child: state.user != null ? Text(state.user.username) : Text(''),
            ),
            leading: Icon(Icons.store),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: state.user != null
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () => print('pressed'))
                    : Text(''),
              ),
            ],
          );
        },
      ),
      preferredSize: Size.fromHeight(60.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(
          decoration: gradientBackground,
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) {
              return Column(children:[
                Expanded(
                    child: SafeArea(
                        top: false,
                        bottom: false,
                        child: GridView.builder(
                            itemCount: state.products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, i) =>
                               ProductItem(item : state.products[i])
                               
                               )))
              ]);
            },
          )),
    );
  }
}
