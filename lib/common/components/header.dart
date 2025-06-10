import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class Header extends StatelessWidget {
  final String title;
  double textScaleDouble;

  Header({
    Key? key,
    required this.title,
    this.textScaleDouble = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.rubikBold(32, AppColors.neutralDarkest),
      textScaleFactor: textScaleDouble,
    );
  }
}
