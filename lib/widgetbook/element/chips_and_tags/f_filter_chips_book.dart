import 'package:flutter/material.dart';
import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_filter_chips.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
// multiple에서 아이콘 suffix말고 고정 값으로 사용

@widgetbook.UseCase(
  name: 'Filter Chips',
  type: FFilterChips,
  path: 'element/chips_and_tags',
)
Widget fFilterChips(BuildContext context) {
  return Builder(builder: (context) {
    String type = context.knobs.list(label: 'Type', options: ['Singular', 'Multiple'], initialOption: 'Singular');
    String label = context.knobs.string(label: 'Label', initialValue: 'label');
    bool isSelected = context.knobs.boolean(label: 'Selected', initialValue: false);
    bool isDisabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    bool isShowCheck = context.knobs.boolean(label: 'Show Check', initialValue: false);
    if (type == 'Singular') {
      return FFilterChips.singular(
        label: label,
        isSelected: isSelected,
        disabled: isDisabled,
        onChanged: (isSelected) {},
      );
    }
    if (type == 'Multiple') {
      return FFilterChips.multiple(
        label: label,
        isSelected: isSelected,
        disabled: isDisabled,
        suffix: isShowCheck
            ? isSelected && !isDisabled
                ? Assets.svgCheck
                : Assets.svgPlusSmallThick
            : null,
        onChanged: (isSelected) {},
      );
    }
    return const SizedBox();
  });
}
