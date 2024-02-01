
import 'package:flutter/material.dart';

import '../../../../data/model/shrot_model/short_model.dart';
import '../LeftPanel/leftpanel.dart';
import '../RightPanel/RightPanel.dart';

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
