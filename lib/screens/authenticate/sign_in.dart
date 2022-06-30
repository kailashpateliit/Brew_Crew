import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Color(0xFFDCC7C0),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/coffee_settings_form.png'),
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
                  Text('LOGIN',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontSize: 19),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                      hoverColor: Colors.white,
                      hintText: 'Email'
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter email': null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    }
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.black,fontSize: 19),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                      fillColor: Colors.black,
                      hintText: 'Password'
                    ),
                    validator: (val) => val!.length<6 ? 'Password must contain atleast 6 characters':null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    }
                  ),
                  SizedBox(height: 20),
                  TextButton(onPressed: ()async{
                    
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null) {
                        setState(() {
                            error = 'Invalid Credentials';
                            loading = false;
                        });
                      }
                    }
                  },
                      child: Text('Login',style: TextStyle(fontSize: 15),),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      primary: Colors.white,
                      backgroundColor: Colors.brown[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                      elevation: 8,
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text('New User? Register',style: TextStyle(color: Colors.black,fontSize: 20),),
                        SizedBox(height: 15),
                        TextButton(onPressed: (){
                          widget.toggleView();
                        },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.brown[900],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 10,
                            ),
                            child: Text('Create New Account',style: TextStyle(fontSize: 17),)),
                    ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(error,style: TextStyle(color: Colors.red),),
                ],
              )
          ),
        ),
      ),
    );
  }
}
