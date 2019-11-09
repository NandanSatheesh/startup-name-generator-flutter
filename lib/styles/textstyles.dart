import 'package:flutter/material.dart';

final TextStyle regularTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

final TextStyle medBoldTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

final TextStyle blackRegular = regularTextStyle.copyWith();

final TextStyle blackMedBoldRegular =
    blackRegular.copyWith(fontWeight: FontWeight.w700);

final TextStyle blackHeader = blackRegular.copyWith(fontSize: 24);

final TextStyle medGreyRegular =
    regularTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600);

final TextStyle lightGreyRegular =
    regularTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600);

final List<TextStyle> listOfStyles = [
  regularTextStyle,
  medBoldTextStyle,
  blackRegular,
  blackMedBoldRegular,
  blackHeader,
  regularTextStyle.copyWith(fontStyle: FontStyle.italic),
  medBoldTextStyle.copyWith(fontStyle: FontStyle.italic),
  blackRegular.copyWith(fontStyle: FontStyle.italic),
  blackMedBoldRegular.copyWith(fontStyle: FontStyle.italic),
  blackHeader.copyWith(fontStyle: FontStyle.italic),
];
