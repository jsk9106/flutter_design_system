import 'package:flutter_design_system/components/f_tag.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Tag',
  type: FTag,
  path: 'element/chips_and_tags',
)
Widget fTags(BuildContext context) {
  return Builder(builder: (context) {
    String type = context.knobs.list(label: 'Type', options: ['Small', 'Normal'], initialOption: 'Normal');
    String label = context.knobs.string(label: 'Label', initialValue: 'label');
    double radius = context.knobs.double.input(label: 'Radius', initialValue: 4);
    Color fontColor = context.knobs.color(label: 'Font Color', initialValue: FColors.of(context).inverseNormal);
    Color color = context.knobs.color(label: 'Color', initialValue: FColors.of(context).solidNormal);
    if (type == 'Small') {
      return FTag.small(
        label: label,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        fontColor: fontColor,
        color: color,
      );
    }
    if (type == 'Normal') {
      return FTag.normal(
        label: label,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        fontColor: fontColor,
        color: color,
      );
    }
    return const SizedBox();
  });
}
