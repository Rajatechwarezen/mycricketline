import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycricketline/utils/Style.dart';

import '../../../utils/CustomWidget/Dotetext.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import 'AllNewsListView.dart';
import 'NewsContent.dart';
import 'newsLayout.dart';
import '../../../model/newData.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final ScrollController _scrollController = ScrollController();
  final List<MyNews> _newsList = [];
  int _currentPage = 3;
  final int _resultsPerPage = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      final url =
          'http://apicricketchampion.in/webservices/news/20122cd5366e30f0847774c9d7698d30?page=$_currentPage&limit=$_resultsPerPage';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> newsList = data['data'];

          setState(() {
            for (dynamic news in newsList) {
              final MyNews newsItem = MyNews.fromJson(news);
              _newsList.add(newsItem);
            }
            _currentPage++;
          });
        } else {
          throw Exception('Failed to fetch news list');
        }
      } catch (error) {
        print('Error: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildNewsItem(MyNews news) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsLayout(newsData: news),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.14,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(news.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            newheadingscore(
              newscontent: truncateText(news.title, 50),
              teamScore: news.pubDate,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          sizeboxSmallh,
          sizeboxSmallh,
          Divider(),
          newstitlebtn(
            context1: context,
            HeadName: 'Trending News',
            Headno: _newsList.length,
            Routes: MyNewsWidget(),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _newsList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildNewsItem(_newsList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
