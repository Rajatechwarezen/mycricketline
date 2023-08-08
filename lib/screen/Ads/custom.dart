import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AipProvider/ads/displayAds.dart';
import '../../model/adsData.dart';
import '../../utils/CustomWidget/shimmer.dart';
import '../../utils/Style.dart';
import 'netiveAds.dart';

class CustomAdWidget extends StatelessWidget {
  static late bool asdisEmpty;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AdData>>(
      future: fetchAdsFromApi(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return textlinesimmer300();
        } else {
          final ads = snapshot.data;
          return Container(
            margin: EdgeInsets.only(top: 10),
            height: 150,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  color: ads!.isEmpty ? Colors.white : Colors.transparent,
                  borderRadius: CustomStylesBorder.boderRadius10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                ads!.isEmpty
                    ? Text("") // NativeExample()
                    : ListView.builder(
                        itemCount: ads!.length,
                        itemBuilder: (context, index) {
                          return CustomAdCard(adData: ads[0]);
                        },
                      ),
              ]),
            ),
          );
        }
      },
    );
  }
}

class CustomAdCard extends StatelessWidget {
  final AdData adData;

  const CustomAdCard({required this.adData});

  Future<void> _openAdUrl() async {
    if (await canLaunchUrl(Uri.parse(adData.adUrl))) {
      await launchUrl(Uri.parse(adData.adUrl));
    } else {
      throw 'Could not launch ${adData.adUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(adData.adImg);
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: _openAdUrl,
            child: Container(
                width: 340,
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'http://cricapi.mycricketline.com/uploads/advimg/${adData.adImg}'),
                    ))),
          )
        ],
      ),
    );
  }
}
