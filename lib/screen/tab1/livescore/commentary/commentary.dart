import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../../AipProvider/LiveMatch.dart';
import '../../../../AipProvider/commentaryApi.dart';
import '../../../../model/CommentaryData.dart';
import '../../../../utils/CustomWidget/Externel.dart';

class Commentary extends StatefulWidget {
  final idMatch;

  Commentary({Key? key, required this.idMatch}) : super(key: key);

  @override
  State<Commentary> createState() => _CommentaryState();
}

class _CommentaryState extends State<Commentary> {
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final commentaryMatches =
        Provider.of<CommentaryApiProvider>(context, listen: false);
    await commentaryMatches.commentaryApiMatchesFullData(widget.idMatch);
    var commentaryApiMatches = commentaryMatches.commentaryApiMatches;

    if (commentaryApiMatches != null) {
      setState(() {
        isExpandedList =
            List<bool>.filled(commentaryApiMatches.data.length, false);
      });
    }
  }

  void toggleExpansion(int index) {
    setState(() {
      isExpandedList[index] = !isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentaryMatches = Provider.of<CommentaryApiProvider>(context);
    CricketMatch? commentaryApiMatches = commentaryMatches.commentaryApiMatches;
/////////////////////////////////////////
    final screenWidth = MediaQuery.of(context).size.width;
    var commentaryprovider = Provider.of<InfoProvider>(context);
    commentaryprovider.fetchLiveMatchesFullDataInfo(widget.idMatch);
    var infoData = commentaryprovider.infoMatches;

    if (commentaryApiMatches == null) {
      // Handle case when data is not available
      return Scaffold(
        body: Center(
          child: summer2,
        ),
      );
    } else {
      return Scaffold(
        body: SizedBox(
          height: 900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: infoData.map(
                  (MyListData) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Cricket_white,
                        border: border,
                        borderRadius: CustomStylesBorder.borderRadius20,
                        boxShadow: [boxshadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  color: Cricket_white,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 10, right: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: CustomStylesBorder
                                              .borderRadiusfull,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                MyListData.teamAImg),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Text(MyListData.teamA),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/vs2.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 10, right: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: CustomStylesBorder
                                              .borderRadiusfull,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                MyListData.teamBImg),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      sizeboxSmallh,
                                      Text(MyListData.teamB),
                                    ],
                                  ),
                                ),
                                sizeboxSmallh,
                              ]),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: commentaryApiMatches.data.length,
                  itemBuilder: (context, index) {
                    String inningKey =
                        commentaryApiMatches.data.keys.elementAt(index);
                    Inning inning = commentaryApiMatches.data[inningKey]!;

                    return Column(
                      children: [
                        /////////////////////////////////////////////////////////////

                        GestureDetector(
                          onTap: () => toggleExpansion(index),
                          child: Container(child: customboxbutton2(inningKey)),
                        ),
                        if (isExpandedList[index])
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: inning.overs.length,
                            itemBuilder: (context, index) {
                              String overKey =
                                  inning.overs.keys.elementAt(index);
                              List<Commentary1>? commentaries =
                                  inning.overs[overKey];

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      overKey,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: commentaries!.length,
                                    itemBuilder: (context, index) {
                                      Commentary1 commentary =
                                          commentaries[index];
                                      Data data = commentary.data;

                                      return ListTile(
                                        title: Text(data.title ?? ''),
                                        subtitle:
                                            Text('Runs: ${data.runs ?? ''}'),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
