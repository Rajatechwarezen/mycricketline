import 'package:flutter/material.dart';

import 'package:mycricketline/utils/Color.dart';
import 'package:mycricketline/utils/CustomWidget/shimmer.dart';
import 'package:mycricketline/utils/Style.dart';
import 'package:provider/provider.dart';

import '../../../AipProvider/LiveMatch.dart';

import '../../../AipProvider/ThemeProvider.dart';
import '../../../utils/CustomWidget/TitleBtn.dart';
import 'fullviewTrending.dart';

class FullTrending extends StatefulWidget {
  FullTrending({super.key, this.lengthType});
  var lengthType;
  @override
  State<FullTrending> createState() => _FullTrendingState();
}

class _FullTrendingState extends State<FullTrending> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final seriesdata = Provider.of<SeriesProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: themeProvider.isDarkTheme
                ? CustomColor.cricketWhite
                : CustomColor.cricketBlackColor,
            iconTheme: IconThemeData(color: CustomColor.cricketBlackColor),
            elevation: 0,
            title: Center(
                child: Text(
              "Treanding List",
              style: CustomStyles.cardBoldDarkDrawerTextStyle,
            ))),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(border: border),
            child: Stack(
              children: [
                sizeboxSmallh,
                FutureBuilder(
                    future: seriesdata.fetchSeriesData(),
                    builder: (context, snapshot) {
                      final home = seriesdata.SeriesMatches;
                      return seriesdata.SeriesMatches.isEmpty
                          ? summer2
                          : Column(
                              children: home.map((myseries) {
                              return InkWell(
                                onTap: () {
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
                                            borderRadius: CustomStylesBorder
                                                .boderRadius10,
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(myseries.image),
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
                                              Text(myseries.series,
                                                  style: CustomStyles
                                                      .cardBoldTextStyle2),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "Start Date :- ${myseries.startDate} End Data${myseries.endDate} ",
                                                  style: CustomStyles
                                                      .smallTextStyle2),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 70,
                                          width: 100,
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                  Icons.arrow_forward_ios)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList());
                    }),
                sizeboxSmallh,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
