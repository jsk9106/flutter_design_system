import 'package:flutter/material.dart';
import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_outlined_button.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Outlined Button',
  type: FOutlinedButton,
  path: 'element/button',
)
Widget fOutlinedButtons(BuildContext context) {
  return Builder(builder: (context) {
    String type = context.knobs.list(
      label: 'Type',
      options: ['Primary', 'Secondary', 'Assistive'],
      initialOption: 'Primary',
    );
    String size = context.knobs.list(label: 'Size', options: ['Large', 'Medium', 'Small'], initialOption: 'Large');
    String label = context.knobs.string(label: 'Label', initialValue: 'label');
    bool disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    bool usePrefix = context.knobs.boolean(label: 'Use Prefix', initialValue: false);
    bool useSuffix = context.knobs.boolean(label: 'Use Suffix', initialValue: false);

    FOutlinedButtonSize fOutlinedButtonSize = FOutlinedButtonSize.large;
    switch (size) {
      case 'Large':
        fOutlinedButtonSize = FOutlinedButtonSize.large;
        break;
      case 'Medium':
        fOutlinedButtonSize = FOutlinedButtonSize.medium;
        break;
      case 'Small':
        fOutlinedButtonSize = FOutlinedButtonSize.small;
        break;
    }

    if (type == 'Primary') {
      return IntrinsicWidth(
        child: FOutlinedButton.primary(
          size: fOutlinedButtonSize,
          text: label,
          disabled: disabled,
          onPressed: () {},
          prefixPath: usePrefix ? Assets.svgPlus : null,
          suffixPath: useSuffix ? Assets.svgPlus : null,
        ),
      );
    }
    if (type == 'Secondary') {
      return IntrinsicWidth(
        child: FOutlinedButton.secondary(
          size: fOutlinedButtonSize,
          text: label,
          disabled: disabled,
          onPressed: () {},
          prefixPath: usePrefix ? Assets.svgPlus : null,
          suffixPath: useSuffix ? Assets.svgPlus : null,
        ),
      );
    }
    if (type == 'Assistive') {
      Color color = context.knobs.color(label: 'Color', initialValue: FColors.of(context).fiet);

      return IntrinsicWidth(
        child: FOutlinedButton.assistive(
          size: fOutlinedButtonSize,
          text: label,
          disabled: disabled,
          onPressed: () {},
          prefixPath: usePrefix ? Assets.svgPlus : null,
          suffixPath: useSuffix ? Assets.svgPlus : null,
          color: color,
        ),
      );
    }

    return const SizedBox();
  });
}
