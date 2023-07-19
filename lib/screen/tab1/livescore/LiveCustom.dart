import 'package:flutter/cupertino.dart';

import '../../../utils/Style.dart';

//////////////////////Image

teamImage2(String images) {
  return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: CustomStylesBorder.borderRadiusfull,
        image: DecorationImage(
          image: NetworkImage(images),
          fit: BoxFit.fill,
        ),
      ));
}

teamheadingscore({teamName, teamScore, teamOver}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(teamName, style: CustomStyles.cardBoldTextStyle2),
      Row(
        children: [
          Text("($teamOver)", style: CustomStyles.smallTextStyle2),
          const SizedBox(
            width: 8,
          ),
          Text(teamScore, style: CustomStyles.cardBoldTextStyle2),
        ],
      ),
    ],
  );
}

teamheadingscore2({
  teamAImg,
  teamBImg,
  teamName,
  teamName2,
  teamScore,
  teamScore2,
  teamOver,
  teamOver2,
  teamType,
  matchTime,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: CustomStylesBorder.borderRadiusfull,
                    image: DecorationImage(
                      image: NetworkImage(teamAImg.toString()),
                      fit: BoxFit.cover,
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(teamName.toString(),
                      style: CustomStyles.cardBoldTextStyle2),
                  Text(teamOver.toString(), style: CustomStyles.cardTextStyle2),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: CustomStylesBorder.borderRadiusfull,
                    image: DecorationImage(
                      image: NetworkImage(teamBImg.toString()),
                      fit: BoxFit.cover,
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(teamName2.toString(),
                      style: CustomStyles.cardBoldTextStyle2),
                  Text(teamOver2.toString(),
                      style: CustomStyles.cardTextStyle2),
                ],
              ),
            ],
          ),
        ],
      ),
      Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: CustomStylesBorder.borderRadiusfull,
            image: const DecorationImage(
              image: AssetImage('images/vs1.png'),
              fit: BoxFit.cover,
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(teamScore, style: CustomStyles.cardBoldTextStyle2),
              Text(teamType, style: CustomStyles.cardTextStyle2),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(teamScore2, style: CustomStyles.cardBoldTextStyle2),
              Text(matchTime, style: CustomStyles.cardTextStyle2),
            ],
          ),
        ],
      ),
    ],
  );
}
