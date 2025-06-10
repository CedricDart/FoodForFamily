import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class ImageIconButton extends StatelessWidget {
  final String iconName;
  final VoidCallback onTap;
  final bool isCircular;
  final double iconSize;
  final Color iconColor;
  final double size;
  final int badgeCount;

  const ImageIconButton({
    Key? key,
    required this.iconName,
    this.iconSize = 20,
    this.iconColor = AppColors.brandSecondaryDarkest,
    this.isCircular = false,
    this.size = 50,
    this.badgeCount = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.white,
              shape: isCircular ? const CircleBorder() : null,
            ),
            onPressed: onTap,
            child: Image.asset(iconName, color: iconColor, width: iconSize, height: iconSize),
          ),
          badgeCount != 0
              ? Positioned(
                  right: 4,
                  top: 5,
                  child: Container(
                      width: 18,
                      height: 18,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: AppColors.brandSecondaryBase,
                      ),
                      child: Text(
                        badgeCount.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.openSansBold(14, AppColors.white, lineHeight: 1.1),
                      )))
              : const SizedBox.shrink()
        ]));
  }
}
