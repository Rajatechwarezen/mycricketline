import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../../model/Allmodel.dart';
import '../../../utils/CustomWidget/Dotetext.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import '../../../utils/CustomWidget/shimmer.dart';
import '../../../utils/Style.dart';
import '../News/NewsContent.dart';
import 'BlogFull.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  final ScrollController _scrollController = ScrollController();
  final List _newsList = [];
  int _currentPage = 1;
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

      final url = 'http://cricapi.mycricketline.com/api/getblog';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> newsList = data['data'];

          setState(() {
            for (dynamic news in newsList) {
              final Blog newsItem = Blog.fromJson(news);
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

  Widget _buildNewsItem(Blog news) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ,
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.16,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      'http://cricapi.mycricketline.com/uploads/blogimg/${news.blImg}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            newheadingscore(
              newscontent: truncateText(news.blTitle, 100),
              teamScore: '${news.createdOn.split("T")[0]}',
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
          Divider(),
          newstitlebtn(
            context1: context,
            HeadName: 'Blog  ',
            Headno: _newsList.length,
            Routes: BlogFull(),
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
          _isLoading ? summer2 : Container(),
        ],
      ),
    );
  }
}
