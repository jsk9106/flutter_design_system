import 'package:flutter_design_system/components/f_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'checkbox',
  type: FCheckbox,
  path: 'element/control',
)
Widget fcheckboxs(BuildContext context) {
  return Builder(builder: (context) {
    String kind = context.knobs.list(label: 'Shape', options: ['Mark', 'Square', 'Round'], initialOption: 'Mark');
    String size = context.knobs.list(label: 'Size', options: ['Tiny', 'Small', 'Normal'], initialOption: 'Normal');
    bool isChecked = context.knobs.boolean(label: 'Checked', initialValue: false);
    bool isDisabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    String label = context.knobs.string(label: 'Label', initialValue: 'Label');
    FCheckboxSize fCheckboxSize = size == 'Tiny'
        ? FCheckboxSize.tiny
        : size == 'Small'
            ? FCheckboxSize.small
            : FCheckboxSize.normal;
    if (fCheckboxSize == FCheckboxSize.tiny) {
      kind = 'Mark';
      label = '';
    }

    if (kind == 'Mark') {
      return FCheckbox.mark(
        checked: isChecked,
        disabled: isDisabled,
        size: fCheckboxSize,
        label: label.isEmpty ? null : label,
      );
    }
    if (kind == 'Square') {
      return FCheckbox.square(
        checked: isChecked,
        disabled: isDisabled,
        label: label.isEmpty ? null : label,
        size: fCheckboxSize,
      );
    }
    if (kind == 'Round') {
      return FCheckbox.round(
        checked: isChecked,
        disabled: isDisabled,
        label: label.isEmpty ? null : label,
        size: fCheckboxSize,
      );
    }
    return const SizedBox();
  });
}
