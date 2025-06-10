import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class FAIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isCircular;
  final double iconSize;
  final Color iconColor;
  final double size;
  final int badgeCount;
  final bool isTransparent;

  const FAIconButton({
    Key? key,
    required this.icon,
    this.iconSize = 20,
    this.iconColor = AppColors.brandSecondaryDarkest,
    this.isCircular = false,
    this.size = 50,
    this.badgeCount = 0,
    this.isTransparent = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child:
            Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, backgroundColor: isTransparent ? Colors.transparent : AppColors.white,
              shadowColor: isTransparent ? Colors.transparent : null,
              shape: isCircular ? const CircleBorder() : null,
            ),
            onPressed: onTap,
            child: FaIcon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
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
                        style: AppTextStyles.openSansBold(14, AppColors.white,
                            lineHeight: 1.1),
                      )))
              : const SizedBox.shrink()
        ]));
  }
}
