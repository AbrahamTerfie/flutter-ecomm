import 'package:flutter/material.dart';
import 'package:hilu_flutter/pages/login_page.dart';
import 'package:hilu_flutter/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-comm',
      routes: {
       '/login' : (BuildContext context ) => LoginPage(),
       '/register': (BuildContext context) => RegisterPage(),
      },

      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[300],
        accentColor: Colors.yellow[500],
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 18.0)),
      ),
    home: RegisterPage()
    
    //  home: MyHomePage(title: ' second test app'),
    );
  }
}
