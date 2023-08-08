import 'package:flutter/material.dart';
import 'package:mycricketline/model/Allmodel.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../AipProvider/LiveMatch.dart';
import '../../../utils/Color.dart';
import '../../../utils/Style.dart';

class BlogFull extends StatelessWidget {
  const BlogFull({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsData = Provider.of<BlogProvider>(context);
    NewsData.getBlogData();
    final newsList = NewsData.blogMatches;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: CustomColor.cricketBlackColor),
            elevation: 0,
            backgroundColor: CustomColor.cricketAppBackground,
            title: Center(
                child: Text(
              "Bolg",
              style: CustomStyles.cardBoldDarkDrawerTextStyle,
            ))),
        body: SingleChildScrollView(
          child: Column(
            children: newsList.asMap().entries.map((entry) {
              final news = entry.value;
              print(news.blImg);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: CustomStylesBorder.boderRadius10,
                  border: border,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 133,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://cricapi.mycricketline.com/uploads/blogimg/${news.blImg}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.blTitle,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(news.blDesc),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Published: ${news.createdOn}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          const Text('Content:'),
                          SizedBox(height: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReadMoreText(
                                '${news.blDesc}',
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
