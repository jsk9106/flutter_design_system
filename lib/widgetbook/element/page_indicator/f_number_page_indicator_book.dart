import 'package:flutter_design_system/components/f_number_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'number page indicator',
  type: FNumberPageIndicator,
  path: 'element/page_indicator',
)
Widget fNumberPageIndicators(BuildContext context) {
  return Builder(builder: (context) {
    String size = context.knobs.list(
      label: 'Size',
      options: ['Normal', 'Small'],
      initialOption: 'Normal',
    );

    bool showBackground = context.knobs.boolean(
      label: 'Show Background',
      initialValue: true,
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

    return Container(
      padding: const EdgeInsets.all(16),
      child: size == 'Normal'
          ? FNumberPageIndicator.normal(
              currentIndex: current,
              totalItems: max,
              showBackground: showBackground,
            )
          : FNumberPageIndicator.small(
              currentIndex: current,
              totalItems: max,
              showBackground: showBackground,
            ),
    );
  });
}
