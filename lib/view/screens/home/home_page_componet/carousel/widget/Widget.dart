import 'package:sprotbuzz/core/utilis/my_color.dart';

import '../../../../../../data/model/home_page_models.dart';

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return "${text.substring(0, maxLength)}...";
  }
}


                      colorChange( detail) {
                        if (detail.matchStatus == "Live") {
                          return MyColor.greenP;
                        } else if (detail.matchStatus == "Finished") {
                          return MyColor.highPriorityPurpleColor;
                        } else {
                          return MyColor.pendingColor;
                        }
                      }