
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';

import '../../../../data/controller/liveMatch_controller/live_match_controller.dart';
import '../../../../data/repo/liveMatch_repo/liveMatch_repo.dart';
import '../../../component/show_match_container/show_match_container.dart';

class LiveMatchList extends StatefulWidget {
  const LiveMatchList({super.key});

  @override
  State<LiveMatchList> createState() => _LiveMatchListState();
}

class _LiveMatchListState extends State<LiveMatchList> {
  

  LiveMatchController realTimeDataController = Get.put(LiveMatchController(liveMatchRepo:LiveMatchRepo(apiClient:  Get.find())));


  @override
  void onInit() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
   
    main();
    });
  }


  @override
  void dispose() {
  realTimeDataController. clearData();
    super.dispose();
  }

   
  Future<void> main() async {
    await realTimeDataController.fetcLiveTimeData();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Obx(() =>realTimeDataController.isLoading.value
          ? const CustomLoader(isFullScreen : true,isPagination: true,)
          : Column(children:  realTimeDataController.allLiveMatches.map((details) {
           return showMatchContainer(details:details, onTap: (){},isLive: false); }).toList())
      ),
    );
 
  }

}