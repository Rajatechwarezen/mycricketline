import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/core/helper/shared_preference_helper.dart';
import 'package:sprotbuzz/core/utilis/borderbox.dart';
import 'package:sprotbuzz/core/utilis/style.dart';
import 'package:sprotbuzz/data/repo/short_rero/short_repo.dart';
import 'package:sprotbuzz/data/servies/api_service.dart';
import 'package:sprotbuzz/view/component/bottom-sheet/custom_bottom_sheet.dart';

import 'package:video_player/video_player.dart';
import '../../../core/utilis/my_color.dart';
import '../../../core/utilis/my_strings.dart';
import '../../../data/controller/shrot/shrot_controller.dart';
import '../../../data/model/shrot_model/short_model.dart';
import '../../component/bottom_Nav/bottom_nav.dart';
import '../../component/custom_loader/custom_loader.dart';
import '../../component/image/round_shape_icon.dart';



List<String> videos1 = [
  'assets/videos/3.mp4',
  'assets/videos/1.mp4',
  'assets/videos/2.mp4',
];

List<String> videos2 = [
  'assets/videos/4.mp4',
  'assets/videos/5.mp4',
  'assets/videos/6.mp4',
];

List<String> imagesInDisc1 = [
  'assets/user/user1.png',
  'assets/user/user2.png',
  'assets/user/user3.png',
];

List<String> imagesInDisc2 = [
  'assets/user/user4.png',
  'assets/user/user3.png',
  'assets/user/user1.png',
];
class ShortPageScreen extends StatefulWidget {
  @override
  _ShortPageScreenState createState() => _ShortPageScreenState();
}
class _ShortPageScreenState extends State<ShortPageScreen>{

  List items = [];

  late ShrotController controller;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ShortRepo(apiClient: Get.find()));
    controller = Get.put(ShrotController(shortRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    
      setState(() {});
    });
       }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   backgroundColor: MyColor.getScreenBgColor(),
    //   appBar: CustomAppBar(
    //       title: MyStrings.hshort.tr,
    //       isShowBackBtn: false,
    //       isShowActionBtn: false,
    //       bgColor: MyColor.getAppbarBgColor()),
    //   body: GetBuilder<ShrotController>(builder: (controller) {
    //     return RotatedBox(
    //       quarterTurns: 1,
    //       child: TabBarView(
          
    //         controller: _tabController,
    //         children:  controller.isLoading ?  [const CustomLoader()] : controller.shortData.map((item) => ReelVideoItem(item: item)).toList() ,
    //       ),
    //     );
    //   }),
    // );



    
    return Scaffold(
   
      body: DefaultTabController(
        length: 1,
        child: Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                FollowingTabPage(videos1, imagesInDisc1,true, false),
                
              ],
            ),
            ],
        ),
      ),
        bottomNavigationBar: const CustomBottomNav(
        currentIndex: 1,
      ),
    );

  }
}











///////////\FollowingTabPage

class FollowingTabPage extends StatelessWidget {
  final List<String> videos;
  final List<String> images;
  final bool isFollowing;
   bool  isVideo = true;

  final int? variable;

   FollowingTabPage(this.videos, this.images, this.isFollowing, this.isVideo, {super.key, this.variable});

  @override
  Widget build(BuildContext context) {
    return FollowingTabBody(videos, images, isFollowing, variable , isVideo);
  }
}

class FollowingTabBody extends StatefulWidget {
  final List<String> videos;
  final List<String> images;
   bool  isVideo ;

  final bool isFollowing;
  final int? variable;

  FollowingTabBody(this.videos, this.images, this.isFollowing, this.variable,   this.isVideo 
);

  @override
  _FollowingTabBodyState createState() => _FollowingTabBodyState();
}

class _FollowingTabBodyState extends State<FollowingTabBody> {
  PageController? _pageController;
  int current = 0;
  bool isOnPageTurning = false;

  void scrollListener() {
    if (isOnPageTurning &&
        _pageController!.page == _pageController!.page!.roundToDouble()) {
      setState(() {
        current = _pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning && current.toDouble() != _pageController!.page) {
      if ((current.toDouble() - _pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController!.addListener(scrollListener);
             Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ShortRepo(apiClient: Get.find()));
    final controller = Get.put(ShrotController(shortRepo: Get.find()));

    
      controller.initData();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShrotController>(builder: (shortcontroller) {
        return PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemBuilder: (context, position) {
            return shortcontroller.isLoading ?  const CustomLoader() : VideoPage(
             shortcontroller.shortData[position].image,
              shortcontroller:  shortcontroller.shortData,
              widget.images[position] ,
              pageIndex: position,
              currentPageIndex: current,
              isPaused: isOnPageTurning,
              isFollowing: widget.isFollowing,
             isVideo: widget.isVideo,
            );
          },
          onPageChanged: widget.variable == null
              ? (i) async {
                  if (i == 2) {
              
         
      // Scroll position is at the end, reset to the top
      _pageController?.jumpTo(0.0);
    
                  }
                }
              : null,
          itemCount:shortcontroller.shortData.length,
        );
      }
    );
  }
}




//////////////video
class VideoPage extends StatefulWidget {
  final String video;
  final String image;
  final int pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;
  bool?  isVideo ;
 List<ImageShotData>  shortcontroller ;
  VideoPage(this.video, this.image,
      {super.key, required this.pageIndex, this.currentPageIndex, this.isPaused, this.isFollowing, required bool isVideo, required this.shortcontroller});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with RouteAware {
  late VideoPlayerController _controller;
  bool initialized = false;
  bool? isLiked ;
  List<dynamic>? isCheckLike = [];

  @override
  void initState() {
    super.initState();
    getLocalStore();


  }

  getLocalStore() async {
    final storage = await SharedPreferences.getInstance();
    List<String>? data = await storage.getStringList(SharedPreferenceHelper.userLikeData);

    if (data != null && data.isNotEmpty) {
      // Assuming each item in the list is a JSON string
      isCheckLike = data.map((jsonString) => json.decode(jsonString)).toList();

      // Check if the current item is liked based on isCheckLike
      if (isCheckLike != null) {
        setState(() {
          isLiked = isCheckLike!.any((element) =>
              element["useClickLike"] == true &&
              element["userLikeId"] == widget.shortcontroller[widget.pageIndex ].id.toString());

              print("${isCheckLike!.any((element) =>
              element["useClickLike"] == true &&
              element["userLikeId"] == widget.shortcontroller[widget.pageIndex ].id.toString())} =====================================");
        });
      }

      print("isCheckLike $isCheckLike");
    } else {
      print("No data found in SharedPreferences");
    }
  }


  @override
  Widget build(BuildContext context) {
isLiked = isCheckLike!.any((element) =>
  element["useClickLike"] == true &&
  element["userLikeId"] == widget.shortcontroller[widget.pageIndex ?? 0].id.toString())  ;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  GetBuilder<ShrotController>(
      builder: (Shotrcontroller) {
          return Stack(
            children: <Widget>[
      Container(
                    
              
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(Uri.parse(


                               
                                  'http://cricapi.mycricketline.com/uploads/shorts/${widget.video}'
                                
                                
                                
                                
                                )
                              .toString()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),),
          
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 18.0,
                bottom: 80.0,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _controller.pause();
                        // Navigator.pushNamed(context, PageRoutes.userProfilePage);
                      },
                      child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.png')),
                    ),
                    CustomButton(
                    icon:  const ImageIcon(
                        AssetImage('assets/icons/ic_views.png'),
                        color:  MyColor.mycolorWhite,
                      ),
                    text:   widget.shortcontroller[widget.pageIndex ?? 0].usershare.toString(),
                    ),
                    CustomButton(
                      icon:    const ImageIcon(
                          AssetImage('assets/icons/ic_comment.png'),
                          color: MyColor.mycolorWhite,
                        ),
                       text:   '287', onPressed: () {
                     
                    }),

CustomButton(
        icon: isLiked!
            ? const Icon(
                Icons.favorite,
                color: MyColor.redCancelTextColor,
              )
            : const Icon(
                Icons.favorite_border,
                color: MyColor.redCancelTextColor,
              ) ,
        text: widget.shortcontroller[widget.pageIndex ].userslike.toString(),
        onPressed: () async {
          // Update the like status based on the existing state
          bool newLikeStatus = !isLiked!;

          // Update the local state
          setState(() {
            isLiked = newLikeStatus;
          });

          // Update the server and local storage
          await Shotrcontroller.updateLike(
            id: widget.shortcontroller[widget.pageIndex].id.toString(),
            userLikeCount: newLikeStatus
                ? int.parse(widget.shortcontroller[widget.pageIndex ].userslike.toString()) + 1
                : int.parse(widget.shortcontroller[widget.pageIndex ].userslike.toString()) - 1,
            boolLike: newLikeStatus,
          );

          // Update the local storage
          await getLocalStore();
        },
      ),    
                  ],
                ),
              ),
          
          
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 12.0,
                bottom: 72.0,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '@emiliwilliamson\n',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5)),
                    const TextSpan(text: "comment8"),
                    TextSpan(
                        text: '  Seemore',
                        style: TextStyle(
                            color: MyColor.myborderColor.withOpacity(0.5),
                            fontStyle: FontStyle.italic))
                  ]),
                ),
              )
            ],
          );
        }
      ),
      
    );
  }
}



class CustomButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? borderColor;
  final Color? color;
  final TextStyle? style;
  final Widget? icon;
  final Color? textColor;

  CustomButton( {
    this.text,
    this.onPressed,
    this.borderColor,
    this.color,
    this.style,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: color ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: boRadiusAll,
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        icon: icon ?? const SizedBox.shrink(),
        onPressed: onPressed as void Function()?,
        label: Text(
          text ?? MyStrings.appName!,
          style: style ??
             interRegularDefault.copyWith(color: MyColor.getTextColor()),
        ),
      ),
    );
  }
}
