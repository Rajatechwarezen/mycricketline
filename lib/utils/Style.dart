import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../AipProvider/ThemeProvider.dart';
import 'Color.dart';

class CustomStyles {
  late Color textcolor;

  CustomStyles(this.textcolor);
  static final LocalStorage storage = LocalStorage('my_theme_storage');

  static Future<void> initStorage() async {
    await storage.ready;
  }

  static final smallLightTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 10,
      fontFamily: 'Poppins',
    ),
  );
  static final smallLightTextStylebold = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
  );

  static final smallLightTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 12,
      fontFamily: 'Poppins',
    ),
  );

  static final smallLightTextStylebold2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
  );
  static final smallTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),
  );
  static final smallTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 12,
    ),
  );

  static final normalTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final normalTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketShadowColor,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final mediumTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );
  static final mediumTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
  static final cardBoldTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextStyle cardTextStyle(Color textcolor) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        color: textcolor,
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static final cardTextStyle2 = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
  static final cardBoldDarkTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkDrawerTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkTextStyle2 = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
  static final grayTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketDarkSkyBlueColor,
      height: 0,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  );
  static final firstCircle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      height: 0,
      fontSize: 21,
      fontWeight: FontWeight.w500,
    ),
  );
  static final overmontserratwhite = GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  static final teamtserratwhite = GoogleFonts.roboto(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
  );

  static final cardBoldDarkroboto = GoogleFonts.roboto(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );
  static final cardBoldDarkTextStyleWhite = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkTextStyleblue = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketPrimary,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );
  static final cardBoldDarkTextStyleGreen = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketPrimary,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardNormalTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketWhite,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
  );

  static final cardNormalDarkTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketBlackColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static final livefont = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: CustomColor.cricketGradientColor1,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),
  );
}

class CustomStylesBorder {
  static final borderRadiusfull = BorderRadius.circular(100);
  static final borderRadius20 = BorderRadius.circular(20);
  static final borderRadius40 = BorderRadius.circular(40);
  static final borderRadius60 = BorderRadius.circular(60);
  static final boderRadius10 = BorderRadius.circular(10);
  static final boderRadius5 = BorderRadius.circular(5);
}

////////////////////////////Border
Border border = Border.all(
  color: CustomColor.cricketTextColorSecondary,
  width: 0.5,
  style: BorderStyle.solid,
);

/////////////////////////////////
var boxshadow = BoxShadow(
  color: CustomColor.cricketTextColorSecondary,
  blurRadius: 6.0,
  spreadRadius: 2.0,
  offset: Offset(0.0, 0.0),
);

////
var sizeboxSmallw = SizedBox(
  width: 10,
);
var sizeboxSmallh = SizedBox(
  height: 10,
);
