import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sprotbuzz/core/utilis/my_color.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

class LabelText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final bool required;
  const LabelText({
    Key? key,
    required this.text,
    this.textAlign,
    this.required = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required? FormRow(label: text.tr, isRequired: true):Text(
      text.tr,
      textAlign: textAlign,
      style: interRegularDefault.copyWith(color: MyColor.getLabelTextColor()),
    );
  }
}
///////////////////////////////form
class FormRow extends StatelessWidget {
  const FormRow({Key? key,
    required this.label,
    required this.isRequired}) : super(key: key);

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label.tr,style: interBoldDefault.copyWith(color: MyColor.getPrimaryTextColor())),
        Text(isRequired?' *':'',style: interBoldDefault.copyWith(color: MyColor.myred))
      ],
    );
  }
}
