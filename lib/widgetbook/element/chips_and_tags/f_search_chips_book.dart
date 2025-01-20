import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_search_chips.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// icon은 asset path만 받고 사이즈나 색상은 고정 값으로 사용하는 것이 어떤지?

@widgetbook.UseCase(
  name: 'Search Chips',
  type: FSearchChips,
  path: 'element/chips_and_tags',
)
Widget fSearchChips(BuildContext context) {
  return Builder(builder: (context) {
    String label = context.knobs.string(label: 'Label', initialValue: 'label');
    double radius = context.knobs.double.input(label: 'Radius', initialValue: 20);
    Color fontColor = context.knobs.color(label: 'Font Color', initialValue: FColors.of(context).white);
    Color color = context.knobs.color(label: 'Color', initialValue: FColors.of(context).labelStrong);
    bool isShowIcon = context.knobs.boolean(label: 'Show Icon', initialValue: false);
    return FSearchChips(
      label: label,
      radius: radius,
      fontColor: fontColor,
      color: color,
      iconPath: isShowIcon ? Assets.svgCheck : null,
    );
  });
}
