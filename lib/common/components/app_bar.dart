import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/common/constants/text_styles.dart';
import 'package:food_for_family/generated/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool hasCloseButton;
  final bool hasBackButton;
  final Function? backActionCallback;

  const CustomAppBar(
      {Key? key,
      this.title = '',
      this.actions,
      this.hasBackButton = false,
      this.hasCloseButton = false,
      this.backActionCallback})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: !hasBackButton ? Text(title!) : const SizedBox.shrink(),
        automaticallyImplyLeading: false,
        leadingWidth: hasBackButton ? 125 : 8,
        leading: hasBackButton
            ? InkWell(
                onTap: () => {
                      backActionCallback != null
                          ? backActionCallback!()
                          : Navigator.of(context).pop()
                    },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    const FaIcon(FontAwesomeIcons.chevronLeft, size: 20),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                            S.of(context).label_common_button_back_title,
                            style: AppTextStyles.ibmPlexSansBold(
                                16, AppColors.brandSecondaryDarkest)))
                  ],
                ))
            : const SizedBox.shrink(),
        actions: hasCloseButton
            ? [
                IconButton(
                  splashRadius: 15,
                  splashColor: AppColors.neutralLightest,
                  icon: const FaIcon(FontAwesomeIcons.xmark, size: 20),
                  onPressed: () => {
                    Navigator.of(context).popUntil((route) => route.isFirst)
                  },
                )
              ]
            : actions);
  }
}
