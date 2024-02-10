import 'package:flutter/material.dart';

import '../../../../../core/utilis/borderbox.dart';
import '../../../../../core/utilis/my_color.dart';

gif(matchData, List widgetsTeamScore){

                    if (matchData.firstCircle.toString().contains("Six")) {
                      widgetsTeamScore.add(Text(""));

                      widgetsTeamScore.add(
                        Center(
                          child: Container(
                            width: 100,
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:  MyColor.getCardBg(),
                              borderRadius: boRadius5,
                              image: const DecorationImage(
                                image: AssetImage("images/six.gif"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

}




