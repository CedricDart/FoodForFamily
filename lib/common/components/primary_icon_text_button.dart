import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class AppPrimaryIconTextButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onClick;
  final bool isEnabled;
  final bool isReversed;

  const AppPrimaryIconTextButton({
    Key? key,
    this.text,
    this.icon,
    required this.onClick,
    this.isEnabled = true,
    this.isReversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? isReversed
                  ? AppColors.white
                  : AppColors.brandSecondaryDarkest
              : AppColors.grayLightest,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          side: isReversed ? BorderSide(width: 0.5, color: isEnabled ? AppColors.brandSecondaryDarkest : AppColors.neutralLight) : null,
          enableFeedback: isEnabled),
      onPressed: isEnabled ? onClick : () => {},
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon != null
                ? Row(children: [FaIcon(icon!, size: 24, color: AppColors.brandSecondaryDarkest), const SizedBox(width: 8)])
                : const SizedBox.shrink(),
            text != null
                ? Expanded(
                    child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.openSansSemiBold(
                        16,
                        isEnabled
                            ? isReversed
                                ? AppColors.brandSecondaryDarkest
                                : AppColors.white
                            : AppColors.neutralBase),
                    textScaleFactor: 0.95,
                  ))
                : const SizedBox.shrink()
          ])),
    );
  }
}
