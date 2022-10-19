import 'package:flutter/material.dart';
import 'package:newsapp/api/newsapi.dart';
import 'package:newsapp/config/localstoarage.dart';
import 'package:newsapp/providers/newsprovider.dart';
import 'package:newsapp/widgets/newscard.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart' as router;
import '../api/authentication.dart';
import '../modals/news.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService.instance;
  var loading = true;
  var isOffline = false;
  var isSaved = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService.getArticle(context).then((value) {
      if (value) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<News> newsList = Provider.of<NewsProvider>(context).getnewsList;
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: isOffline?Colors.grey:Colors.white,
          leading: Icon(
            Icons.search,
            color: Colors.blue,
          ),
          title: TextButton(
            onPressed: () {},
            child: Text(
              isOffline?"Offline Mode":"Search in feed",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          actions: [
            isOffline?Container():IconButton(

                onPressed: () {
                  if(!isSaved){
                    DbManager.insertModel(newsList[0]);
                    setState(() {
                      isSaved= true;

                    });
                  }
                },
                icon: Icon(
                  isSaved?Icons.check:Icons.save,
                  color: Colors.green,
                )),
            SizedBox(
              width: 3,
            ),
            IconButton(
                onPressed: ()async {
                  Provider.of<NewsProvider>(context,listen: false).updateNewsList(await DbManager.getNewsList());
                  setState(() {
                    isOffline = isOffline?false:true;
                  });
                },
                icon: Icon(
                  isOffline?Icons.wifi:Icons.wifi_off,
                  color: Colors.black,
                )),
            SizedBox(
              width: 3,
            ),
            IconButton(
                onPressed: () async {
                  _authService.fbauth.signOut();
                  Navigator.pushReplacementNamed(
                    context,
                    router.Router.authPage,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : newsList.isEmpty?Center(child: Text("No Results Available"),):Container(
                //height: 150,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 15),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NewsCard(newsItem: newsList[index]),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                  itemCount: newsList.length,
                  shrinkWrap: true,
                ),
                //child: NewsCard(newsItem: newsList[0],),
              ));
  }
}
