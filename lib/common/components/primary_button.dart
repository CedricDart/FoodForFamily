import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final bool isReversed;
  final bool hasBorder;
  final VoidCallback onClick;

  const AppPrimaryButton({
    Key? key,
    required this.text,
    this.isEnabled = true,
    this.isReversed = false,
    this.hasBorder = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? isReversed
                ? AppColors.white
                : AppColors.brandSecondaryDarkest
            : AppColors.brandSecondaryDarkest.withAlpha(125),
        elevation: 0.0,
        shape: hasBorder
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(color: isReversed ? AppColors.brandSecondaryDarkest : AppColors.white),
              )
            : null,
        shadowColor: Colors.transparent,
      ),
      onPressed: isEnabled ? onClick : () => {},
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.openSansBold(16, isReversed ? AppColors.brandSecondaryDarkest : AppColors.white),
            textScaleFactor: 0.95,
          )),
    );
  }
}
