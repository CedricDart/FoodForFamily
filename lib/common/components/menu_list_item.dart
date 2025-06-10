import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';

class MenuListItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onClick;

  const MenuListItem({Key? key, required this.title, this.isActive = true, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      enableFeedback: isActive,
      enabled: isActive,
      title: Text(title, style: AppTextStyles.openSansSemiBold(16, isActive ? AppColors.brandSecondaryDarkest : AppColors.neutralLight)),
      trailing: FaIcon(
        isActive ? FontAwesomeIcons.chevronRight : FontAwesomeIcons.lock,
        color: isActive ? AppColors.brandSecondaryDarkest : AppColors.neutralLight,
        size: 20,
      ),
      selectedColor: AppColors.itemSelected,
      selectedTileColor: AppColors.itemSelected,
      onTap: onClick,
    );
  }
}
