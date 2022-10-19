import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../api/authentication.dart';
import '../config/assets.dart';
import '../config/routes.dart' as router;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  AuthService _authService = AuthService.instance;
  StreamSubscription<User?>? _authChangeSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authChangeSubscription = _authService.authStateChanges().listen((user)async {
      if (user != null) {
        Navigator.pushNamed(
          context,
          router.Router.homePage,
        );


      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Flexible(child: Card(
            elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.15),
              child: ListView(
                //physics: Clip,
                children: [

                  Text("SignIn into your",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 20),),
                  Text(" account",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 20),),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailCtrl,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Id is required!';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //     color: Colors.white,
                              //   ),
                              //   borderRadius: BorderRadius.circular(25.0),
                              // ),
                              hintText: "johndoe@gmail.com",
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.redAccent,

                              ),
                              labelText: 'Email Id',
                              labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //     borderSide: const BorderSide(color: Colors.white),
                              //     borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          TextFormField(
                            controller: passwordCtrl,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required!';
                              }

                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //     color: Colors.white,
                              //   ),
                              //   borderRadius: BorderRadius.circular(25.0),
                              // ),
                              hintText: "Password",
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.redAccent,

                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //     borderSide: const BorderSide(color: Colors.white),
                              //     borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: (){
                                if(emailCtrl.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please enter a valid Email Id"))
                                  );
                                }
                                else{
                                  _authService.sendpasswordresetemail(emailCtrl.text);
                                }
                              },
                              child: Text("Forgot Password ?",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 16),),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.center,
                            child: Text("Login with",style: TextStyle(color: Colors.black),),
                          ),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: (){
                              _authService.signinwithgoogle();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              child: Image.asset('lib/assetImage/googleIcon.jpg'),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an Account? "),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(
                                      context,
                                      router.Router.signUpPage,
                                    );
                                  },
                                  child: Text("Register Now",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 16),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.redAccent,
            ),
            child: TextButton(
              onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _authService.signinemail(emailCtrl.text, passwordCtrl.text);
                  }
                // Navigator.pushNamed(
                //   context,
                //   router.Router.homePage,
                // );
              },
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
