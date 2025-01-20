import 'package:flutter_design_system/components/f_radio.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// onChecked -> onTap으로 변경 다른 것과 통일 필요
@widgetbook.UseCase(
  name: 'radio',
  type: FRadio,
  path: 'element/control',
)
Widget fradioboxs(BuildContext context) {
  return Builder(builder: (context) {
    String size = context.knobs.list(label: 'Size', options: ['Small', 'Normal'], initialOption: 'Normal');
    bool isChecked = context.knobs.boolean(label: 'Checked', initialValue: false);
    bool isDisabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    String label = context.knobs.string(label: 'Label', initialValue: 'Label');
    if (size == 'Small') {
      return FRadio.small(
        context,
        isChecked: isChecked,
        disabled: isDisabled,
        label: label,
      );
    }
    if (size == 'Normal') {
      return FRadio.normal(
        context,
        isChecked: isChecked,
        disabled: isDisabled,
        label: label,
      );
    }
    return const SizedBox();
  });
}
