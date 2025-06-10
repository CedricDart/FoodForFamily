import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkedTextItem {
  final String linkText;
  final VoidCallback onClick;

  LinkedTextItem({Key? key, required this.linkText, required this.onClick});
}

class LinkedText extends StatelessWidget {
  final String fullText;
  final List<LinkedTextItem> linkItems;
  final TextStyle textStyle;
  final TextStyle linkedTextStyle;

  final List<String> _textParts = List.empty(growable: true);

  LinkedText({
    Key? key,
    required this.fullText,
    required this.linkItems,
    required this.textStyle,
    required this.linkedTextStyle,
  }) : super(key: key) {
    var regex = '';
    linkItems.forEachIndexed((index, item) {
      regex += item.linkText;

      if (index != linkItems.length - 1) {
        regex += '|';
      }
    });

    var modifiedText = fullText.splitMapJoin(RegExp(regex),
        onMatch: (m) => '{${m[0]?.replaceAll(' ', '')}}');

    _textParts.addAll(modifiedText.split(' '));
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: textStyle,
          children: _textParts.map((text) {
            bool shouldAddDotAtEnd = false;

            if (text.contains('{') && (text.contains('}'))) {
              var temp = text;
              temp = temp.replaceAll('{', '');
              temp = temp.replaceAll('}', '');

              if (temp.endsWith('.')) {
                shouldAddDotAtEnd = true;

                temp = temp.replaceAll('.', '');
              }

              var linkItem = linkItems.firstWhere((element) {
                return element.linkText.replaceAll(' ', '') == temp;
              });

              return TextSpan(
                  text:
                      ' ' + linkItem.linkText + (shouldAddDotAtEnd ? '.' : ''),
                  style: linkedTextStyle,
                  recognizer: TapGestureRecognizer()..onTap = linkItem.onClick);
            }
            return TextSpan(text: ' ' + text);
          }).toList()),
    );
  }
}
