import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class FAIconTextButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double iconSize;
  final Color iconColor;

  const FAIconTextButton({
    Key? key,
    required this.icon,
    required this.title,
    this.iconSize = 18,
    this.iconColor = AppColors.brandSecondaryDarkest,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            boxShadow: [BoxShadow(color: AppColors.dropShadow.withAlpha(20), spreadRadius: 0.25, blurRadius: 5, offset: const Offset(0, 1))]),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 8,
            backgroundColor: AppColors.white,
            padding: const EdgeInsets.only(left: 40, right: 40, top: 12, bottom: 12),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
          ),
          onPressed: onTap,
          child: Row(children: [
            FaIcon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            const SizedBox(width: 8),
            Text(title, textAlign: TextAlign.center, style: AppTextStyles.openSansBold(15, AppColors.brandSecondaryDarkest), textScaleFactor: 0.95)
          ]),
        ));
  }
}
