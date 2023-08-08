import 'package:flutter/material.dart';
import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/CustomWidget/Dotetext.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/LiveMatch.dart';
import '../../../AipProvider/ThemeProvider.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import '../../tab4/upcoming.dart';
import 'fullListTrending.dart';
import 'fullviewTrending.dart';

class Tremding extends StatefulWidget {
  const Tremding({super.key});

  @override
  State<Tremding> createState() => _TremdingState();
}

class _TremdingState extends State<Tremding> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final seriesdata = Provider.of<SeriesProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: seriesdata.fetchSeriesData(),
        builder: (context, snapshot) {
          final home = seriesdata.SeriesMatches;
          return seriesdata.SeriesMatches.isEmpty
              ? summer
              : Column(
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                                      "Trending",
                                      style: CustomStyles
                                          .cardBoldDarkDrawerTextStyle,
                                    ),
                                    Text("(${home.length})")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullTrending(
                                    lengthType: "Full",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "See All",
                              style: CustomStyles.cardBoldDarkTextStyleGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                            children: home.take(5).map((myseries) {
                          return InkWell(
                            onTap: () {
                              print(myseries.seriesId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrendingView(
                                        trendingViewName: myseries.series,
                                        matchid: myseries.seriesId)),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: screenWidth,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: themeProvider.isDarkTheme
                                      ? CustomColor.cricketWhite
                                      : CustomColor.cricketBlackColor,
                                  boxShadow: [boxshadow],
                                  borderRadius:
                                      CustomStylesBorder.boderRadius10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 100,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            CustomStylesBorder.boderRadius10,
                                        image: DecorationImage(
                                          image: NetworkImage(myseries.image),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              truncateText(myseries.series, 20),
                                              style: CustomStyles
                                                  .cardBoldTextStyle2),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "Start Date :- ${myseries.startDate} \n End Data${myseries.endDate}",
                                              style:
                                                  CustomStyles.smallTextStyle2),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      )),
                                  Container(
                                    height: 70,
                                    width: 50,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                            Icons.arrow_forward_ios)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                      ],
                    ),
                  ],
                );
        });
  }
}
