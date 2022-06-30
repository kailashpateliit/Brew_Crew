import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String conformPassword = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee_settings_form.png'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.all(30),
              width: 400,
              child: SafeArea(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hoverColor: Colors.white,
                                hintText: 'Email'),
                            validator: (val) =>
                                val!.isEmpty ? 'Please enter email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            }),
                        SizedBox(height: 20),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hoverColor: Colors.white,
                                hintText: 'Password'),
                            validator: (val) => val!.length < 6
                                ? 'The password must contain atleast 6 characters'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            }),
                        SizedBox(height: 20),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hoverColor: Colors.white,
                                hintText: 'Confirm Password'),
                            onChanged: (val) {
                              setState(() {
                                conformPassword = val;
                              });
                            }),
                        SizedBox(height: 25),
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (password == conformPassword) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                setState(() {
                                  if (result == null)
                                    error = 'Please supply a valid email';
                                });
                              } else {
                                setState(() {
                                  error =
                                      'Password and confirm password should be same';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 15),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            primary: Colors.white,
                            backgroundColor: Colors.brown[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)),
                            elevation: 8,
                          ),
                        ),
                        SizedBox(height: 40),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Text(
                                'Already Registered? Sign In',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 17),
                              TextButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 15),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  primary: Colors.white,
                                  backgroundColor: Colors.brown[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17)),
                                  elevation: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
