import 'package:flutter/material.dart';
import '../api/authentication.dart';
import '../config/assets.dart';
import '../config/routes.dart' as router;
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  AuthService _authService = AuthService.instance;
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

                  Text("Create an",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 20),),
                  Text(" Account",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 20),),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameCtrl,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required!';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //     color: Colors.white,
                              //   ),
                              //   borderRadius: BorderRadius.circular(25.0),
                              // ),
                              hintText: "John doe",
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.redAccent,

                              ),
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //     borderSide: const BorderSide(color: Colors.white),
                              //     borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
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
                            controller: phoneCtrl,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Contact no is required!';
                              }
                              if(value.length!=10){
                                return 'Invalid phone number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //     color: Colors.white,
                              //   ),
                              //   borderRadius: BorderRadius.circular(25.0),
                              // ),
                              hintText: "0128512345",
                              suffixIcon: Icon(
                                Icons.call,
                                color: Colors.redAccent,

                              ),
                              labelText: 'Contact no',
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
                              hintText: "*********",
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
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(value: true, onChanged: (_){}),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("I agree with "),
                                      TextButton(
                                        onPressed: (){},
                                        child: Text("term & condition",style: TextStyle(decoration: TextDecoration.underline,color: Colors.red,fontWeight: FontWeight.w900,fontSize: 16),),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an Account? "),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(
                                      context,
                                      router.Router.loginPage,
                                    );
                                  },
                                  child: Text("Sign In!",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,fontSize: 16),),
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
                  _authService.signinwithemail(emailCtrl.text,passwordCtrl.text);
                  Navigator.pushNamed(
                    context,
                    router.Router.homePage,
                  );
                }
              },
              child: Text(
                "REGISTER",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

}
