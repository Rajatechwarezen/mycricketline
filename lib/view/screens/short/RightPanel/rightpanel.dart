import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/data/repo/short_rero/short_repo.dart';
import '../../../../core/helper/shared_preference_helper.dart';
import '../../../../data/controller/shrot/shrot_controller.dart';
import '../../../../data/model/shrot_model/short_model.dart';
import '../../../../data/servies/api_service.dart';
import '../widget/Short_widget.dart';

class RightPanel extends StatefulWidget {
  final ImageShotData item;
  final int id;
  const RightPanel({required this.item, required this.id});

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
   SharedPreferences? storage;
  bool? isButtonDisabled  = false; // Track whether the button is disabled or not


  @override
  void initState() {
    super.initState();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ShortRepo(apiClient: Get.find()));
    final controller = Get.put(ShrotController(shortRepo: Get.find()));

    
      controller.initData();

   
    

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShrotController>(
      builder: (controller) => Expanded(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  controller.updateLike(
                      id: widget.id.toString(),
                      userLikeCount: widget.item.userslike,boolLike: true);
                },
                child: FutureBuilder(
                  future: Future.delayed(Duration.zero),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return getIcons(Icons.favorite_border,
                        '2', 35.0, Colors.red);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return getIcons(
                          isButtonDisabled!
                              ? Icons.favorite
                              : Icons.favorite_border,
                       "2",
                          35.0,
                          Colors.red);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              getIcons(Icons.reply_outlined, widget.item.usershare.toString(),
                  25.0, Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
