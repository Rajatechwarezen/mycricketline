import 'package:flutter/material.dart';
import 'package:sprotbuzz/view/component/text/default_text.dart';

import '../../../core/utilis/dimansion.dart';
import '../../../core/utilis/my_color.dart';

////////////////////////////menu
class MenuRowWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;

  const MenuRowWidget(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color:  MyColor.getTextColor(),
                size: 20,
              ),
              const SizedBox(width: Dimensions.space15),
              DefaultText(text: label, textColor: MyColor.getTextColor())
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
                color: MyColor.mytransparentColor, shape: BoxShape.circle),
            child: Icon(Icons.arrow_forward_ios_rounded,
                color: MyColor.getTextColor(), size: 15),
          )
        ],
      ),
    );
  }
}
