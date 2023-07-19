import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Color.dart';

class CustomStyles {
  static final smallheadTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 128, 128, 128),
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
  );
  static final smallLightTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 10,
      fontFamily: 'Poppins',
    ),
  );
  static final smallLightTextStylebold = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
  );

  static final smallLightTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFF020202),
      fontSize: 12,
      fontFamily: 'Poppins',
    ),
  );

  static final smallLightTextStylebold2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
  );
  static final smallTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),
  );
  static final smallTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFF000000),
      fontSize: 12,
    ),
  );

  static final normalTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final normalTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xff303030),
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );

  static final mediumTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );
  static final mediumTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
  static final cardBoldTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
  static final cardTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.w300,
    ),
  );
  static final cardTextStyle2 = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
  static final cardBoldDarkTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkDrawerTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkTextStyle2 = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
  static final grayTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Cricket_SkyBlue_Color,
      height: 0,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
  );
  static final overmontserratwhite = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );

  static final teamtserratwhite = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
  );

  static final cardBoldDarkroboto = GoogleFonts.roboto(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );
  static final cardBoldDarkTextStyleWhite = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardBoldDarkTextStyleblue = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Cricket_Primary,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );
  static final cardBoldDarkTextStyleGreen = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Cricket_Primary,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    ),
  );

  static final cardNormalTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
  );

  static final cardNormalDarkTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color(0xFF000000),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static final livefont = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Cricket_Gradient_color1,
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
  color: Cricket_textColorSecondary,
  width: 0.5,
  style: BorderStyle.solid,
);

/////////////////////////////////
var boxshadow = const BoxShadow(
  color: Color(0xffDDDDDD),
  blurRadius: 6.0,
  spreadRadius: 2.0,
  offset: Offset(0.0, 0.0),
);

////
var sizeboxSmallw = const SizedBox(
  width: 10,
);
var sizeboxSmallh = const SizedBox(
  height: 10,
);
