import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FHighlightedText extends StatelessWidget {
  final String input;
  final String match;
  final TextStyle? highlightStyle;
  final TextStyle? textStyle;

  const FHighlightedText({
    super.key,
    required this.input,
    required this.match,
    this.highlightStyle,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // 입력된 문자열과 일치하는 부분을 찾고 분리
    List<TextSpan> spans = [];
    int start = 0;
    while (start < input.length) {
      int index = input.indexOf(match, start);
      if (index < 0) {
        // 일치하는 부분이 없으면 남은 텍스트를 기본 스타일로 추가
        spans.add(
          TextSpan(
            text: input.substring(start),
            style: textStyle ?? FTextStyles.bodyL.r.copyWith(color: FColors.of(context).labelNeutral),
          ),
        );
        break;
      }
      // 일치하지 않는 부분을 기본 스타일로 추가
      if (index > start) {
        spans.add(
          TextSpan(
            text: input.substring(start, index),
            style: textStyle ?? FTextStyles.bodyL.r.copyWith(color: FColors.of(context).labelNeutral),
          ),
        );
      }
      // 일치하는 부분을 하이라이트 스타일로 추가
      spans.add(
        TextSpan(
          text: input.substring(index, index + match.length),
          style: highlightStyle ?? textStyle ?? FTextStyles.bodyL.r.copyWith(color: FColors.of(context).green),
        ),
      );
      start = index + match.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
