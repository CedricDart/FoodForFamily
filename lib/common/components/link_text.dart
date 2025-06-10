import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onClick;

  const LinkText({
    Key? key,
    required this.text,
    required this.color,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Text(
        text,
        style: AppTextStyles.openSansSemiBold(16, color).copyWith(
          decoration: TextDecoration.underline,
          decorationThickness: 1.0,
          decorationColor: color,
        ),
      ),
    );
  }
}
