import 'package:flutter_design_system/components/f_dot_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'dot page indicator',
  type: FDotPageIndicator,
  path: 'element/page_indicator',
)
Widget fDotPageIndicators(BuildContext context) {
  return Builder(builder: (context) {
    String size = context.knobs.list(
      label: 'Size',
      options: ['Normal', 'Small'],
      initialOption: 'Normal',
    );

    String color = context.knobs.list(
      label: 'Color',
      options: ['Black', 'White'],
      initialOption: 'Black',
    );

    int max = context.knobs.int.slider(
      label: 'Max',
      min: 3,
      max: 10,
      initialValue: 8,
    );

    // 1부터 시작하는 current 표시용 슬라이더
    int displayCurrent = context.knobs.int.slider(
      label: 'Current',
      min: 1,
      max: 10,
      initialValue: 6,
      description: 'max 넘어가는 숫자는 크게 신경쓰지 마세요. test 용 입니다.',
    );

    // 실제 인덱스용 current (0부터 시작)
    int current = displayCurrent - 1;

    if (displayCurrent > max) {
      displayCurrent = max;
      current = max - 1;
    }

    final dotColor = color == 'Black' ? FDotPageIndicatorColor.black : FDotPageIndicatorColor.white;

    return Container(
      padding: const EdgeInsets.all(16),
      child: size == 'Normal'
          ? FDotPageIndicator.normal(
              currentIndex: current,
              totalItems: max,
              color: dotColor,
            )
          : FDotPageIndicator.small(
              currentIndex: current,
              totalItems: max,
              color: dotColor,
            ),
    );
  });
}
