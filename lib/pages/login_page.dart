import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  bool _isSubmitting, _obscureText = true;

  String _email, _password;

  Widget _showTitle() {
    return Text('Login', style: Theme.of(context).textTheme.headline1);
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _email = val,
        validator: (val) => !val.contains('@') ? 'invalid email' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'email',
            hintText: 'enter a valid email ',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _password = val,
        validator: (val) => val.length < 8 ? 'password too short ' : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() => _obscureText = !_obscureText);
              },
              child:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            ),
            border: OutlineInputBorder(),
            labelText: 'password',
            hintText: 'enter password , min length 8 ',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }
  //this is a linr added to test the commits are being done properly

  Widget _showFormAction() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                )
              : RaisedButton(
                  child: Text('submit',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black)),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: Theme.of(context).accentColor,
                  onPressed: () => _submit(),
                ),
          FlatButton(
            child: Text('new user ? register '),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/register'),
          )
        ],
      ),
    );
  }

  void _submit() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    http.Response response =
        await http.post('http://10.0.2.2:1337/auth/local', body: {
      "identifier": _email,
      "password": _password,
    });

    final responseData = json.decode(response.body);
    //error handling during regestration

    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);

      _storeUserData(responseData);
      _showSucessSnack();

      _redirectUser();

      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = responseData['message'];
      _showErrorSnack(errorMsg);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];

    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar = SnackBar(
        content: Text(
      errorMsg,
      style: TextStyle(color: Colors.red),
    ));
    _scaffoldkey.currentState.showSnackBar(snackbar);
    throw Exception('Error logging in ');
  }

  void _showSucessSnack() {
    final snackbar = SnackBar(
        content: Text(
      'user sucessfully logged in !',
      style: TextStyle(color: Colors.green),
    ));
    _scaffoldkey.currentState.showSnackBar(snackbar);
    _formkey.currentState.reset();
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/products');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    _showTitle(),
                    _showEmailInput(),
                    _showPasswordInput(),
                    _showFormAction(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
