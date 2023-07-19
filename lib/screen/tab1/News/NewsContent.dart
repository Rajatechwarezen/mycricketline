import 'package:flutter/cupertino.dart';

import '../../../utils/CustomWidget/Externel.dart';
import '../../../utils/Style.dart';

newheadingscore({newscontent, teamScore}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        cropText(newscontent, 20),
        style: CustomStyles.cardBoldTextStyle2,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      Text(teamScore, style: CustomStyles.smallLightTextStyle2),
    ],
  );
}
