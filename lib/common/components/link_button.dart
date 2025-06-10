import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class AppLinkButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onClick;

  const AppLinkButton({Key? key, required this.text, this.color = AppColors.brandSecondaryDarkest, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick,
        child: Text(
          text,
          style: AppTextStyles.openSansRegular(16, color).merge(const TextStyle(decoration: TextDecoration.underline)),
        ));
  }
}
