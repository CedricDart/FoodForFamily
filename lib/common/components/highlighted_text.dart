import 'package:flutter/cupertino.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final RegExp? highlightRegex;
  final TextStyle highlightStyle;
  final TextStyle nonHighlightStyle;

  const HighlightedText({
    Key? key,
    required this.text,
    required this.highlightRegex,
    required this.highlightStyle,
    required this.nonHighlightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text('', style: nonHighlightStyle);
    }

    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      final String? highlight =
          highlightRegex?.stringMatch(text.substring(start));
      if (highlight == null) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }

      final int indexOfHighlight = text.indexOf(highlight, start);

      if (indexOfHighlight == start) {
        // starts with highlight
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    }

    return RichText(
      text: TextSpan(
        style: nonHighlightStyle,
        children: spans,
      ),
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content);
  }
}
