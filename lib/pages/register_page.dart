import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  bool _obscureText = true;
  String _username, _email, _password;

  Widget _showTitle() {
    return Text('Register', style: Theme.of(context).textTheme.headline1);
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? 'username too short ' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'username',
            hintText: 'enter username , min length 6 ',
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            )),
      ),
    );
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

  Widget _showFormAction() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('submit',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black)),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Theme.of(context).primaryColor,
            onPressed: () => _submit(),
          ),
          FlatButton(
              child: Text('Existing user ? Login'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/login'))
        ],
      ),
    );
  }

  void _submit() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      print('username : $_username email: $_email password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                    _showUsernameInput(),
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
