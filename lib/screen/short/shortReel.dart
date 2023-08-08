import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/FinishApi.dart';
import '../../model/FinishData.dart';
import '../../model/TermAndConditionData.dart';
import '../../utils/CustomWidget/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ImageShotData> items = [];
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Check if data has been fetched already to avoid redundant fetch
    if (!_dataFetched) {
      final shortMatches = Provider.of<FinishMatchesProvider>(context);
      items = await shortMatches.ShortData(); // Await the data fetch
      _dataFetched = true; // Mark data as fetched

      // Initialize TabController with the correct length after data is fetched
      _tabController = TabController(length: items.length, vsync: this);

      // Verify if the data fetched has all 34 items
      if (items.length != 34) {
        // Show a loading spinner while waiting for data
        Center(
          child: summer,
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataFetched) {
      // Show a loading spinner while waiting for data
      return Scaffold(
        body: Center(
          child: summer,
        ),
      );
    }

    return Scaffold(
      body: RotatedBox(
        quarterTurns: 1,
        child: TabBarView(
          controller: _tabController,
          children: items.map((item) => ReelVideoItem(item: item)).toList(),
        ),
      ),
    );
  }
}

class ReelVideoItem extends StatefulWidget {
  final ImageShotData item;

  ReelVideoItem({required this.item});

  @override
  _ReelVideoItemState createState() => _ReelVideoItemState();
}

class _ReelVideoItemState extends State<ReelVideoItem> {
  bool isShowPlaying = false;
  late int itemId;
  @override
  void initState() {
    setState(() {
      itemId = widget.item.id;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 800,
                      width: 400,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(Uri.parse(
                                  'http://cricapi.mycricketline.com/uploads/shorts/${widget.item.image}')
                              .toString()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          bottom: 10,
                          right: 15,
                        ),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    LeftPanel(
                                      item: widget.item,
                                    ),
                                    RightPanel(item: widget.item, id: itemId),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftPanel extends StatelessWidget {
  final ImageShotData item;

  LeftPanel({required this.item});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightPanel extends StatefulWidget {
  final ImageShotData item;
  final int id;
  const RightPanel({required this.item, required this.id});

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  bool isButtonDisabled = false; // Track whether the button is disabled or not
  final LocalStorage storage = LocalStorage('like_button_storage');
  dynamic userLikeCount;
  late List userLikeId = [];
  @override
  void initState() {
    super.initState();
    storage.ready.then((_) {
      setState(() {
        isButtonDisabled = storage.getItem('isButtonDisabled') ?? false;
        userLikeId = storage.getItem('userLikeId') ?? [];
        userLikeCount = widget.item.userslike;
      });
    });
  }

  Future<void> LikeIncreese(id, int userlike) async {
    const url = 'http://cricapi.mycricketline.com/api/updatelike';
    print("--------------------$id");
    final data = {'id': id, "userslike": userlike + 1};

    final jsonData = json.encode(data);

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        setState(() {
          if (!userLikeId.contains(id)) {
            userLikeCount = userlike + 1;
            isButtonDisabled = true;
            userLikeId.add(id);
            storage.setItem('userLikeId', userLikeId);
            storage.setItem('isButtonDisabled', isButtonDisabled);
          } else {
            userLikeCount = userlike - 1;
            isButtonDisabled = false;
            userLikeId.remove(id);
            storage.setItem('userLikeId', userLikeId);
            storage.setItem('isButtonDisabled', isButtonDisabled);
          }
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                LikeIncreese(widget.id, widget.item.userslike);
              },
              child: FutureBuilder(
                future: Future.delayed(Duration.zero),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return getIcons(Icons.favorite_border,
                        userLikeCount.toString(), 35.0, Colors.red);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return getIcons(
                        isButtonDisabled
                            ? Icons.favorite
                            : Icons.favorite_border,
                        userLikeCount.toString(),
                        35.0,
                        Colors.red);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            getIcons(Icons.reply_outlined, widget.item.usershare.toString(),
                25.0, Colors.white),
          ],
        ),
      ),
    );
  }
}

Widget getIcons(IconData icon, String count, double size, colors) {
  return Column(
    children: [
      Icon(
        icon,
        color: colors,
        size: size,
      ),
      Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}
