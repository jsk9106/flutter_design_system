import 'package:flutter_design_system/components/f_spinner.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// (완)large, small 사이즈 차이가 없어보임 -> 확인 필요
// (완)기본 색 변경 필요
// (완)불필요한 옵션 제거
@widgetbook.UseCase(
  name: 'spinner',
  type: FSpinner,
  path: 'element/spinner',
)
Widget fSpinners(BuildContext context) {
  String size = context.knobs.list(label: 'Size', options: ['Large', 'Small', 'Custom'], initialOption: 'Large');
  double? customSize = context.knobs.double.slider(label: 'Custom Size', min: 10, max: 30, initialValue: 10);
  if (size != 'Custom') {
    customSize = null;
  }
  return Builder(builder: (context) {
    if (size == 'Large') {
      return FSpinner.large();
    }
    if (size == 'Small') {
      return FSpinner.small();
    }

    return FSpinner.custom(
      customSize: customSize!,
    );
  });
}
