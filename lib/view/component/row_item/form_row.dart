import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/style.dart';

import '../../../core/utilis/my_color.dart';

class FormRow extends StatelessWidget {

  final String label;
  final bool isRequired;

  const FormRow({Key? key,
    required this.label,
    required this.isRequired
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label,style: interBoldDefault.copyWith(color: MyColor.getTextColor()),),
        Text(isRequired?' *':'',style: interBoldDefault.copyWith(color: MyColor.redCancelTextColor),)
      ],
    );
  }
}
