import 'package:flutter/material.dart';
import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_solid_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Solid Button',
  type: FSolidButton,
  path: 'element/button',
)
Widget fSolidButtons(BuildContext context) {
  return Builder(builder: (context) {
    String type =
        context.knobs.list(label: 'Type', options: ['Primary', 'Secondary', 'Assistive'], initialOption: 'Primary');
    String size = context.knobs.list(label: 'Size', options: ['Large', 'Medium', 'Small'], initialOption: 'Large');
    String label = context.knobs.string(label: 'Label', initialValue: 'label');
    bool disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    bool usePrefix = context.knobs.boolean(label: 'Use Prefix', initialValue: false);
    bool useSuffix = context.knobs.boolean(label: 'Use Suffix', initialValue: false);

    FSolidButtonSize fSolidButtonSize = FSolidButtonSize.large;
    switch (size) {
      case 'Large':
        fSolidButtonSize = FSolidButtonSize.large;
        break;
      case 'Medium':
        fSolidButtonSize = FSolidButtonSize.medium;
        break;
      case 'Small':
        fSolidButtonSize = FSolidButtonSize.small;
        break;
    }

    if (type == 'Primary') {
      return IntrinsicWidth(
        child: FSolidButton.primary(
          size: fSolidButtonSize,
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
        child: FSolidButton.secondary(
          size: fSolidButtonSize,
          text: label,
          disabled: disabled,
          onPressed: () {},
          prefixPath: usePrefix ? Assets.svgPlus : null,
          suffixPath: useSuffix ? Assets.svgPlus : null,
        ),
      );
    }
    if (type == 'Assistive') {
      return IntrinsicWidth(
        child: FSolidButton.assistive(
          size: fSolidButtonSize,
          text: label,
          disabled: disabled,
          onPressed: () {},
          prefixPath: usePrefix ? Assets.svgPlus : null,
          suffixPath: useSuffix ? Assets.svgPlus : null,
        ),
      );
    }

    return const SizedBox();
  });
}
