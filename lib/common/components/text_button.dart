import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onClick;
  final bool isPositive;
  final double iconSize;

  const AppTextButton({Key? key, required this.text, this.icon, required this.onClick, required this.isPositive, this.iconSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: AppTextStyles.openSansSemiBold(16, isPositive ? AppColors.brandSecondaryDarkest : AppColors.negativeTextButton)),
            icon != null
                ? Row(
                    children: [
                      const SizedBox(width: 4),
                      FaIcon(icon!, size: iconSize, color: AppColors.brandSecondaryDarkest),
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ));
  }
}
