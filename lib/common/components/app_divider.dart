import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';

class AppDivider extends StatelessWidget {
  final double indent;
  final Color color;

  const AppDivider(
      {Key? key, this.indent = 24, this.color = AppColors.neutralLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: 1,
      thickness: 1,
      indent: indent,
      endIndent: indent,
    );
  }
}
