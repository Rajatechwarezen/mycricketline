import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:sprotbuzz/core/utilis/dimansion.dart';
import 'package:sprotbuzz/view/component/html/htmlComp.dart';
import '../../../../core/utilis/borderbox.dart';
import '../../../../core/utilis/boxSpace.dart';
import '../../../../core/utilis/my_color.dart';
import '../../../../core/utilis/my_images.dart';
import '../../../../core/utilis/style.dart';
import '../../../component/text/small_text.dart';
import '../../home/home_page_componet/carousel/widget/Widget.dart';
import 'package:html/dom.dart' as htmlDom;
class NewsBlogsCard extends StatelessWidget {
  const NewsBlogsCard(
      {Key? key,
      required this.newTitle,
      required this.dateTime,
      required this.status,
      required this.img,
      this.height = 150})
      : super(key: key);

  final String newTitle;
  final String dateTime;
  final String status;

  final double? height;
  final String? img;
  @override
  Widget build(BuildContext context) {
      var document = extractTextFromHtml(newTitle);


     
    return Container(
      height: height! * 1.8,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 20),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space10, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.getCardBg(), borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              alignment: Alignment.center,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: boRadiusAll,
                  color: MyColor.mycolorGrey.withOpacity(0.1),
                  shape: BoxShape.rectangle),
              child: FadeInImage.assetNetwork(
                image: img!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                imageErrorBuilder: (ctx, object, trx) {
                  return Image.asset(
                  MyImages.placeHolderImage,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  );
                },
                placeholder: MyImages.placeHolderImage,
              )),

          size10h,
          Text(
            truncateText(document.toString(), 100),
        style:
                interSemiBoldDefault.copyWith(color: MyColor.getTextColor()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(
                  text: status,
                  textStyle: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor1(),
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: Dimensions.space5),
              SmallText(
                  text: dateTime,
                  textStyle: interRegularExtraSmall.copyWith(
                      color: MyColor.getTextColor()))
            ],
          ),
          const SizedBox(height: Dimensions.space5)
        ],
      ),
    );
  }
}
