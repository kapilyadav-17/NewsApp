import 'package:flutter/material.dart';
import 'package:newsapp/modals/news.dart';

class NewsProvider with ChangeNotifier {
  List<News> newsList = [

  ];
  void updateNewsList(List<News> newList){
    this.newsList = newList!;
    notifyListeners();
  }
  List<News> get getnewsList => newsList;
}
