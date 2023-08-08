import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../AipProvider/LiveMatch.dart';
import '../../../model/newData.dart';
import '../../../utils/Color.dart';

class MyNewsWidget extends StatefulWidget {
  const MyNewsWidget({Key? key}) : super(key: key);

  @override
  _MyNewsWidgetState createState() => _MyNewsWidgetState();
}

class _MyNewsWidgetState extends State<MyNewsWidget> {
  bool showFullContent = false;

  @override
  Widget build(BuildContext context) {
    final NewsData = Provider.of<LiveMatchProvider>(context);
    final newsList = NewsData.newsList;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: CustomColor.cricketBlackColor),
            elevation: 0,
            backgroundColor: CustomColor.cricketAppBackground,
            title: Center(
                child: Text(
              "Trending News",
              style: CustomStyles.cardBoldDarkDrawerTextStyle,
            ))),
        body: SingleChildScrollView(
          child: Column(
            children: newsList.asMap().entries.map((entry) {
              final news = entry.value;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: CustomStylesBorder.boderRadius10,
                  border: border,
                ),
                child: Column(
                  children: [
                    Image.network(news.image),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(news.description),
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
                            'Published: ${news.pubDate}',
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
                                '${news.content}',
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
