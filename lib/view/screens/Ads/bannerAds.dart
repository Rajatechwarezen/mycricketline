
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

import '../../component/custom_loader/custom_loader.dart';



class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = AdManager.createBannerAd()..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble() ,
      child: _bannerAd == null
          ? CustomLoader() // Show loading indicator while ad is loading
          : AdWidget(ad: _bannerAd!),
    );
  }
}

class AdManager {
  static String get bannerAdUnitId => 'ca-app-pub-1658074074654406/4144995346';

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
     
      size:  AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Banner Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner Ad failed to load: $error');
          ad.dispose();
          
        },
        onAdOpened: (Ad ad) => print('Banner Ad opened.'),
        onAdClosed: (Ad ad) => print('Banner Ad closed.'),
      ),
    );
  }
}
