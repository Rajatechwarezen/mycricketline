import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Style.dart';

import '../../screen/tab1/News/AllNewsListView.dart';
import '../../screen/tab3/LiveFullScreenList.dart';

titlebtn(
    {required String HeadName,
    String,
    required BuildContext context1,
    required Headno,
    required Routes}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 24,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    HeadName,
                    style: CustomStyles.cardBoldDarkDrawerTextStyle,
                  ),
                  Text("($Headno)")
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context1,
              MaterialPageRoute(builder: (context) => Routes),
            );
          },
          child: Text(
            "See All",
            style: CustomStyles.cardBoldDarkTextStyleGreen,
          ),
        )
      ],
    ),
  );
}

newstitlebtn(
    {required String HeadName,
    String,
    required BuildContext context1,
    required Headno,
    required Routes}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context1,
              MaterialPageRoute(
                builder: (context) => Routes,
              ),
            );
          },
          child: SizedBox(
            height: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      HeadName,
                      style: CustomStyles.cardBoldDarkDrawerTextStyle,
                    ),
                    Text("($Headno)"),
                    sizeboxSmallw,
                    const Icon(
                      Icons.arrow_forward_ios,
                      weight: 100,
                      size: 15,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
