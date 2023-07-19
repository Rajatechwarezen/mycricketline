import 'package:flutter/widgets.dart';

import '../Color.dart';
import '../Style.dart';

String cropText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return text.substring(0, maxLength) + '...';
  }
}

smallboxRed(value) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(2),
    height: 24,
    width: 35,
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius10,
      border: border,
      color: Cricket_Gradient_color1,
    ),
    child: Text(value.toString(), style: CustomStyles.cardTextStyle),
  );
}

smallboxblue(value) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(2),
    height: 24,
    width: 35,
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius10,
      border: border,
      color: Cricket_Primary,
    ),
    child: Text(value.toString(), style: CustomStyles.smallTextStyle),
  );
}

smallboxRedScore(value) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(2),
    height: 20,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius10,
      border: border,
      color: Cricket_Gradient_color1,
    ),
    child: Text(value.toString(), style: CustomStyles.smallTextStyle),
  );
}

smallboxRedScore2(value) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(2),
    height: 20,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius10,
      border: border,
      color: Cricket_textColorSecondary,
    ),
    child: Text(value.toString(), style: CustomStyles.smallTextStyle2),
  );
}

ScoresBox(value, ScoreType) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(2),
    height: 50,
    width: 70,
    decoration: BoxDecoration(
      borderRadius: CustomStylesBorder.boderRadius5,
      border: border,
      color: ScoreType == "A" ? Cricket_Gradient_color1 : Cricket_Primary,
    ),
    child: Text(value.toString(),
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Cricket_white)),
  );
}

customboxbutton2(inningKey) {
  return Container(
      decoration: BoxDecoration(
          color: Cricket_Primary,
          border: border,
          boxShadow: [boxshadow],
          borderRadius: CustomStylesBorder.borderRadius20),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
      padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
      child: Text(
        inningKey,
        style: CustomStyles.cardBoldDarkTextStyleWhite,
      ));
}
