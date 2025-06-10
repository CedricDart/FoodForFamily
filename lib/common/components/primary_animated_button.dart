import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';

class AppPrimaryAnimatedButton extends StatelessWidget {
  final Widget animation;
  final bool isEnabled;
  final bool isReversed;
  final VoidCallback onClick;

  const AppPrimaryAnimatedButton({
    Key? key,
    required this.animation,
    this.isEnabled = true,
    this.isReversed = false,
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
            : isReversed
                ? AppColors.white.withAlpha(175)
                : AppColors.brandSecondaryDarkest.withAlpha(125),
        elevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      onPressed: isEnabled ? onClick : () => {},
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
        child: SizedBox(width: 24, height: 24, child: animation),
      ),
    );
  }
}
