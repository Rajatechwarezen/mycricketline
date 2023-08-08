import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../AipProvider/ThemeProvider.dart';
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
      color: CustomColor.cricketGradientColor1,
    ),
    child: Text(value.toString(),
        style: CustomStyles.cardTextStyle(CustomColor.cricketWhite)),
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
      color: CustomColor.cricketPrimary,
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
      color: CustomColor.cricketGradientColor1,
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
      color: CustomColor.cricketTextColorSecondary,
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
      color: ScoreType == "A"
          ? CustomColor.cricketGradientColor1
          : CustomColor.cricketPrimary,
    ),
    child: Text(value.toString(),
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: CustomColor.cricketWhite)),
  );
}

customboxbutton2(inningKey) {
  return Container(
      decoration: BoxDecoration(
        color: CustomColor.cricketPrimary,
        border: border,
      ),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            inningKey,
            style: CustomStyles.cardBoldDarkTextStyleWhite,
          ),
          Icon(
            Icons.arrow_circle_down,
            color: CustomColor.cricketWhite,
          )
        ],
      ));
}

class DarkModeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () => themeProvider.toggleTheme(),
      child: Image(
        image: themeProvider.isDarkTheme
            ? const AssetImage('images/dark_mode.png')
            : const AssetImage('images/light_mode.png'),
        width: 35,
        height: 35,
      ),
    );
  }
}
