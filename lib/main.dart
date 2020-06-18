import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hilu_flutter/models/app_state.dart';
import 'package:hilu_flutter/pages/login_page.dart';
import 'package:hilu_flutter/pages/products_page.dart';
import 'package:hilu_flutter/pages/register_page.dart';
import 'package:hilu_flutter/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'redux/reducers.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.inital(),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Flutter E-comm',
            routes: {
              '/products': (BuildContext context) => ProductsPage(onInit: () {
                    StoreProvider.of<AppState>(context).dispatch(getUserAction);
                    //start (getuser action) inorder to get userdata
                  }),
              '/login': (BuildContext context) => LoginPage(),
              '/register': (BuildContext context) => RegisterPage(),
            },
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.blue[300],
              accentColor: Colors.yellow[500],
              textTheme: TextTheme(
                  headline1:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  headline6:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText2: TextStyle(fontSize: 18.0)),
            ),
            home: RegisterPage()
            //home: ProductsPage(),
            //  home: MyHomePage(title: ' second test app'),
            ));
  }
}
