import 'package:flutter/material.dart';
import 'package:sprotbuzz/core/utilis/my_color.dart';

class CustomLoader extends StatelessWidget {

  const CustomLoader({Key? key,this.isPagination = false,this.isFullScreen = false}) : super(key: key);

  final bool isFullScreen;
  final bool isPagination;

  @override
  Widget build(BuildContext context) {
    return isFullScreen?Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(
            strokeWidth :1.5,
          color: MyColor.getPrimaryColor(),
        ),
      ),
    ): isPagination?
    Center(
      child:  Padding(
        padding: const EdgeInsets.all(10),
        child: CircularProgressIndicator(
            strokeWidth :1.5,
          color: MyColor.getPrimaryColor(),
        ),
      ),
    ):
    Center(
      child: CircularProgressIndicator(
        strokeWidth :1.5,
        color: MyColor.getPrimaryColor(),
      ),
    );
  }
}
