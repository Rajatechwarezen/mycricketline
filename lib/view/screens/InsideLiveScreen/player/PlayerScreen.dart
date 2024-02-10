
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprotbuzz/core/utilis/boxSpace.dart';
import 'package:sprotbuzz/data/repo/player_repo/Player_Repo.dart';
import 'package:sprotbuzz/view/component/custom_loader/custom_loader.dart';

import '../../../../core/utilis/my_color.dart';
import '../../../../core/utilis/style.dart';
import '../../../../data/controller/player_controller/player_controller.dart';
import '../../../../data/model/player_model/player_model.dart';
import '../../../../data/servies/api_service.dart';
import '../../../component/divider/custom_divider.dart';


class CricketPlayerListState extends StatefulWidget {
  var matchId;
   CricketPlayerListState({super.key , required this.matchId});

  @override
  State<CricketPlayerListState> createState() => _CricketPlayerListStateState();
}

class _CricketPlayerListStateState extends State<CricketPlayerListState> {


     PlayerController realTimeDataController = Get.put(
      PlayerController(realTimeRepo: PlayerRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
  
     realTimeDataController.initData(matchId: widget.matchId);
  }
  @override
  Widget build(BuildContext context) {

      
    
    
 return   
   GetBuilder<PlayerController>(builder: (controller){  
     
    return controller.isLoading.value ? const CustomLoader() :   Container(
      decoration: BoxDecoration(color: MyColor.getCardBg()),
      child: SizedBox(
        height: 600,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: 2, // Assuming there are two teams in the match
          itemBuilder: (context, index) {
            TeamData teamData =
                (index == 0) ?  realTimeDataController.playerMatchesList![0].teamA :  realTimeDataController.playerMatchesList![0].teamB;
            return Container(
              width: 170,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                           size10w,
                        CircleAvatar(
                          backgroundImage: NetworkImage(teamData.flag),
                          radius: 20,
                        ),
                        size20w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              teamData.shortName,
                              style:interBoldDefault.copyWith(color: MyColor.getTextColor()),
                            ),
                          ],
                        ),
                                  Spacer(),
                      ],
                    ),
                  ),
                  const CustomDivider(),
                
                    SizedBox(
                      height: 510,
                      child: ListView(
                        shrinkWrap:true,
                        children: teamData.players.map((player) {
                          return ListTile(
                            isThreeLine: true,
                            dense: true,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(player.image),
                              radius: 20,
                            ),
                            title: Text(player.name,
                                style:interBoldExtraSmall.copyWith(color: MyColor.getTextColor()),
                              ),
                            subtitle: Text(player.playRole,
                                style:interBoldExtraSmall.copyWith(color: MyColor.getTextColor()),
                              ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
    
   } );
  }
}
void _navigateToPlayerList(BuildContext context, TeamData teamData) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => playerListPage(teamData),
    ),
  );
}


playerListPage(teamData) {
  return ListView.builder(
    itemCount: teamData.players?.length ?? 0,
    itemBuilder: (context, index) {
      PlayerData player = teamData.players![index];
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(player.image),
          radius: 10,
        ),
        title: Text(player.name, style:interBoldDefault.copyWith(color: MyColor.getCardBg())),
        subtitle: Text(
          player.playRole,
          style: interBoldDefault.copyWith(color: MyColor.getCardBg()),
        ),
      );
    },
  );
}
