import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../data/controller/live_owl_controller/owl_match_controller.dart';
import '../../../../component/custom_loader/custom_loader.dart';
import '../../../../component/show_match_container/show_match_container.dart';
import '../../../InsideLiveScreen/InsideLiveScreen.dart';

class HomeScreenCarousel extends StatefulWidget {
  HomeScreenCarousel({super.key});

  @override
  State<HomeScreenCarousel> createState() => _HomeScreenCarouselState();
}

class _HomeScreenCarouselState extends State<HomeScreenCarousel> {
  OwlTimeDataController realTimeDataController =
      Get.put(OwlTimeDataController());
  late CarouselController carouselController = CarouselController();
  int _currentSlide = 0;
  @override
  void initState() {
    super.initState();

    main();
  }

  Future<void> main() async {
    await realTimeDataController.fetchRealTimeData();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.width;

    return Obx(() => realTimeDataController.homeliveMatches.isEmpty
        ? const Center(
            child: CustomLoader(),
          )
        : CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: screenheight * 0.5,
              initialPage: 1,
              autoPlay: false,
              pageSnapping: true,
              aspectRatio: 8 / 9,
              pauseAutoPlayInFiniteScroll: true,
              autoPlayCurve: Curves.bounceOut,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0,
              disableCenter: false,
              // Add the pagination option
              onPageChanged: (index, reason) {
                setState(() {
                  _currentSlide = index;
                });
              },
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
            ),
            items:
                realTimeDataController.homeliveMatches.take(20).map((details) {
              return showMatchContainer(
                  details: details,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InsideLiveScreenTab(
                                idMatch: details.matchId,
                                type: details.matchStatus,
                                allData: details,
                                // data: [
                                //   details.teamAScore
                                //       .toString()
                                //       .split("&")[0],
                                //   details.teamBScore
                                //       .toString()
                                //       .split("&")[0],
                                //   details.teamAOver.split("&")[0],
                                //   details.teamBOver.split("&")[0]
                                // ],
                              )),
                    );
                  },
                  isLive: false);
            }).toList(),
          ));
  }
}
