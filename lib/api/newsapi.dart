import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/providers/newsprovider.dart';
import 'package:provider/provider.dart';

import '../modals/news.dart';


class ApiService {



  static Future<bool> getArticle(BuildContext context) async {
    try{
      var client = http.Client();
      final endPointUrl =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=1a76c53f48a34a10ac0534f92bc7f2d8";
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      var response = await client.get(Uri.parse(endPointUrl),
          headers: requestHeader, );
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        List<dynamic> body = json['articles'];


        List<News> newList = body.map((dynamic item) {
          return News.fromjson({
            "title": item["title"]!=null?item["title"]:"NA",
            "description": item["description"]!=null?item["description"]:"NA",
            "imageUrl": item["urlToImage"]!=null?item["urlToImage"]:"NA",//TODO handle error
            "publishedAt": item["publishedAt"]!=null?item["publishedAt"]:"NA",
            "source": item["source"]["name"]!=null?item["source"]["name"]:"NA",


          });

        }).toList();
        Provider.of<NewsProvider>(context,listen: false).updateNewsList(newList);
        return true;

      }
      return false;
    }on Exception catch (e) {
      return false;
      // TODO
    }



  }
}