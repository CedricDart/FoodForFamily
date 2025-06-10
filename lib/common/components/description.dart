import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class Description extends StatelessWidget {
  final String text;
  double textScaleDouble;

  Description({
    Key? key,
    required this.text,
    this.textScaleDouble = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.openSansRegular(16, AppColors.gray),
      textScaleFactor: textScaleDouble,
    );
  }
}
