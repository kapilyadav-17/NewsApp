import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsapp/providers/newsprovider.dart';
import 'package:newsapp/screens/homepage.dart';
import 'package:newsapp/screens/loginpage.dart';
import 'package:newsapp/screens/signuppage.dart';
import 'package:provider/provider.dart';
import './config/routes.dart' as router;
import 'package:easy_rich_text/easy_rich_text.dart';

import 'api/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => NewsProvider(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return AuthScreen();
            } else {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            }
          },
        ),
        onGenerateRoute: router.Router.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final AuthService _authService = AuthService.instance;
  String title = "SocialX";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Future.delayed(Duration(milliseconds: 2000),()async{
    if(_authService.currentUser!=null){
      Navigator.pushNamed(
        context,
        router.Router.homePage,
      );
    }
  });
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldkey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: EasyRichText(
              title,
              patternList: [
                EasyRichTextPattern(
                    targetString: title.substring(1,7),
                    style: TextStyle(color: Colors.black)),
                EasyRichTextPattern(
                    targetString: title.substring(7), style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold))
              ],
            ),
            backgroundColor: Colors.redAccent,
            bottom: TabBar(
                indicatorColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black),
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "LOGIN",
                  ),
                  Tab(
                    text: "SIGN UP",
                  )
                ]),
          ),
          body: TabBarView(
            children: [LoginPage(), SignupPage()],
          )),
    );
  }
}
