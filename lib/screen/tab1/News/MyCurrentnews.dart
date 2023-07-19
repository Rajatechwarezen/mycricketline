import 'package:flutter/material.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/LiveMatch.dart';
import '../../../utils/CustomWidget/Dotetext.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import 'NewsContent.dart';
import 'newsLayout.dart';

class MyCurrentNews extends StatefulWidget {
  const MyCurrentNews({super.key});

  @override
  State<MyCurrentNews> createState() => _MyCurrentNewsState();
}

class _MyCurrentNewsState extends State<MyCurrentNews> {
  @override
  Widget build(BuildContext context) {
    final NewsData = Provider.of<LiveMatchProvider>(context);
    final newsLists = NewsData.newsList;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        newstitlebtn(
          HeadName: 'Trending News ',
          Headno: '12',
          Routes: '/',
          context1: context,
        ),
        FutureBuilder(
            future: NewsData.fetchNewsList(),
            builder: (context, snapshot) {
              return NewsData.newsList.isEmpty
                  ? summer2
                  : Container(
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      child: Column(
                          children: newsLists.asMap().entries.map((entry) {
                        final news = entry.value;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsLayout(newsData: news)),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenHeight * 0.16,
                                  width: screenWidth * 1,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        CustomStylesBorder.boderRadius10,
                                    image: DecorationImage(
                                      image: NetworkImage(news.image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                newheadingscore(
                                    newscontent: truncateText(news.title, 290),
                                    teamScore: news.pubDate),
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                    );
            })
      ],
    );
  }
}
