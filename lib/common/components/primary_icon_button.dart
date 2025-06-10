import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';

class AppPrimaryIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClick;
  final bool isEnabled;
  final bool isReversed;
  final bool fixedHeight;

  const AppPrimaryIconButton({
    Key? key,
    required this.icon,
    required this.onClick,
    this.isEnabled = true,
    this.isReversed = false,
    this.fixedHeight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 46,
        height: fixedHeight ? 46 : null,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: isEnabled
                ? isReversed
                    ? AppColors.white
                    : AppColors.brandSecondaryDarkest
                : AppColors.grayLightest,
            elevation: 0.0,
            shadowColor: Colors.transparent,
            side: isReversed ? BorderSide(width: 0.5, color: isEnabled ? AppColors.brandSecondaryDarkest : AppColors.neutralLight) : null,
            enableFeedback: isEnabled,
          ),
          onPressed: isEnabled ? onClick : () => {},
          child: FaIcon(icon, size: 24, color: isReversed ? AppColors.brandSecondaryDarkest : AppColors.white),
        ));
  }
}
