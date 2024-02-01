import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/view/component/card/card_with_round_icon.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utilis/my_images.dart';
import '../../../../../core/utilis/my_strings.dart';
import '../../../../../data/controller/trendindList_controller/TrendindList_controller.dart';
import '../../../../../data/repo/teanding_repo/teanding_repo.dart';
import '../../../../../data/servies/api_service.dart';

class HomePageTrendindList extends StatefulWidget {
  const HomePageTrendindList({super.key});

  @override
  State<HomePageTrendindList> createState() => _HomePageTrendindListState();
}

class _HomePageTrendindListState extends State<HomePageTrendindList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TeandingRepo(apiClient: Get.find()));
    final controller =
        Get.put(TrendingListController(teandingRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    });

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingListController>(builder: (trendindController) {

try{
return   trendindController.isLoading.value ?  
      
            Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade800,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: CardWithRoundIcon(
                  backgroundColor: MyColor.getCardBg(),
                  titleText: '',
                  titleColor: Colors.transparent,
                  trailColor: Colors.transparent,
                  trailText: '',
                  icon: '',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ) :      
     trendindController.dataList.isEmpty ?   const CustomLoader():
     ListView.builder(
          itemCount:2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (c, i) {
            return   IntrinsicHeight(
              child: Row(children: [
             Expanded(
                  child: CardWithRoundIcon(
                    backgroundColor: MyColor.getCardBg(),
                    titleText: trendindController.dataList[i].series,
                    titleColor: MyColor.getTextColor(),
                    trailColor: MyColor.getPrimaryColor(),
                    trailText:  trendindController.dataList[i].seriesDate,
                    icon:  trendindController.dataList[i].image,
                    onPressed: () {},
                  )
                )  
              ]),
            );
          }) ;

  
}catch(e){
return Text(e.toString());
}
        });
  }
}
