import 'package:flutter/material.dart';
import 'package:mycricketline/screen/tab1/Blog/Blog.dart';
import 'package:mycricketline/screen/tab1/trending/trending.dart';
import 'package:provider/provider.dart';
import 'News/BestNews.dart';
import 'News/MyCurrentnews.dart';
import 'carouse/Carousel.dart';
import 'livescore/LiveLine/RealTimeLive.dart';
import 'livescore/LiveLine/livescore.dart';

class CricketCard extends StatefulWidget {
  const CricketCard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CricketCardState createState() => _CricketCardState();
}

class _CricketCardState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CorouselContainer(),
          LiveScores(),
          Tremding(),
          News(),
          Blogs(),
          MyCurrentNews()
        ],
      ),
    );
  }
}
