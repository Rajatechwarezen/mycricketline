import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

import 'my_switch_widget.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MySwitchWidget(
    activeIcon:  Icon(Icons.nightlight,size: 18,color: MyColor.pendingColor),
    inactiveIcon:  Icon(Icons.sunny,size: 18,color: MyColor.greenSuccessColor),
    width: 55.0,
    height: 30.0,
    valueFontSize: 11.0,
    toggleSize: 20.0,
    value: value,
    borderRadius: 30.0,
    toggleColor: value?MyColor.bgColorLight:MyColor.greenP,
    activeColor: MyColor.pendingColor,
    inactiveColor: MyColor.getScreenBgColor(),
    padding: 4.0,
    showOnOff: false,
    onToggle: onChanged);
  }
}