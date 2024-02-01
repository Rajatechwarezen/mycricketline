
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
     bool isPlayerListVisible = true; 

     PlayerController realTimeDataController = Get.put(
      PlayerController(realTimeRepo: PlayerRepo(apiClient: Get.find())));

  @override
  void initState() {
    super.initState();
  
     realTimeDataController.initData(matchId: widget.matchId);
  }
  @override
  Widget build(BuildContext context) {
    MatchData matchData = realTimeDataController.playerMatchesList![0];
    return  Obx(()=>realTimeDataController.isLoading.value ? const CustomLoader(): 
    
          
  matchData == null ?
   CustomLoader() : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: 
       ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: 2, // Assuming there are two teams in the match
         itemBuilder: (context, index) {
           TeamData teamData =
               (index == 0) ? matchData.teamA : matchData.teamB;
           return Container(
             width: 170,
             margin: EdgeInsets.symmetric(horizontal: 10),
             child: Column(
               children: [
                 GestureDetector(
                   onTap: () {
                     setState(() {
                       isPlayerListVisible = !isPlayerListVisible;
                     });
                   },
                   child: Container(
                     padding: EdgeInsets.all(10),
                     child: Row(
                       children: [
                         CircleAvatar(
                           backgroundImage: NetworkImage(teamData.flag),
                           radius: 20,
                         ),
                         SizedBox(width: 10),
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
                 ),
                 const CustomDivider(
                    ),
                 if (isPlayerListVisible)
                   Column(
                     children: teamData.players!.map((player) {
                       return ListTile(
                         isThreeLine: true,
                         dense: true,
                         leading: CircleAvatar(
                           backgroundImage: NetworkImage(player.image),
                           radius: 20,
                         ),
                         title: Text(player.name,
                             style:interBoldDefault.copyWith(color: MyColor.getTextFieldBg()),
                           ),
                         subtitle: Text(player.playRole,
                             style:interBoldDefault.copyWith(color: MyColor.getTextFieldBg()),
                           ),
                       );
                     }).toList(),
                   ),
               ],
             ),
           );
         },
       ),
         ),
    
    );
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
