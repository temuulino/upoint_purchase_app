import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final textFieldStyle = GoogleFonts.ubuntu(
  color: text100,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

final textFieldDisabledStyle = GoogleFonts.ubuntu(
  color: text100.withOpacity(0.8),
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

final textFieldHintStyle = GoogleFonts.ubuntu(
  color: greyColor4,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

final textFieldDisabledHintStyle = GoogleFonts.ubuntu(
  color: greyColor3,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

TextStyle get ktsTitleText => GoogleFonts.inter(
      fontSize: 26,
      height: 0.95,
      fontWeight: FontWeight.w800,
    );

TextStyle get ktsBodySmall => GoogleFonts.inter(
      fontSize: 12,
    );

TextStyle get ktsBodySmallBold => GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w800,
    );

TextStyle get ktsBodyRegular => GoogleFonts.inter(
      fontSize: 14,
    );

TextStyle get ktsBodyRegularBold => GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w800,
    );

TextStyle get ktsBodyLarge => GoogleFonts.inter(
      fontSize: 18,
    );

TextStyle get ktsBodyLargeBold => GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w800,
    );

TextStyle get ktsBodyMassive => GoogleFonts.inter(
      fontSize: 22,
    );

TextStyle get ktsBodyMassiveBold => GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w800,
    );

TextStyle get ktsBodyMassivePlus => GoogleFonts.inter(
      fontSize: 32,
    );

TextStyle get ktsBodyMassivePlusBold => GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w800,
    );
