import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modals/news.dart';

class NewsCard extends StatelessWidget {
  //const NewsCard({Key? key}) : super(key: key);
  NewsCard({required this.newsItem});
  final News newsItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: Row(
          children: [
            Flexible(child: Container(
              padding: EdgeInsets.only(left: 10,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyRichText(newsItem.publishedAt.substring(1,11)+newsItem.source,
                  patternList: [
                    EasyRichTextPattern(targetString: newsItem.publishedAt.substring(1,11),style: TextStyle(color: Colors.grey)),
                    EasyRichTextPattern(targetString: newsItem.source,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey))
                  ],),
                  SizedBox(height: 5,),
                  Container(
                    child: Text(newsItem.title,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),

                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: Text(newsItem.description,style: TextStyle(color: Colors.lightBlueAccent,fontSize: 16),),
                  )
                ],
              ),
            ),),
            Container(
              height: 100,
              width: 80,
              child: Image.network(newsItem.imageUrl),
            )
          ],
        ),
      ),
    );
  }
}
