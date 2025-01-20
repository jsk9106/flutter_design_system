import 'package:flutter/material.dart';
import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_text_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Text Button',
  type: FTextButton,
  path: 'element/button',
)
Widget fSolidButtons(BuildContext context) {
  return Builder(builder: (context) {
    String type =
        context.knobs.list(label: 'Type', options: ['Primary', 'Secondary', 'Assistive'], initialOption: 'Primary');
    String size = context.knobs.list(label: 'Size', options: ['Medium', 'Small'], initialOption: 'Medium');
    String thickness = context.knobs.list(label: 'thickness', options: ['Strong', 'Thin'], initialOption: 'Strong');
    String text = context.knobs.string(label: 'Label', initialValue: 'Label');
    bool disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    bool usePrefix = context.knobs.boolean(label: 'Use Prefix', initialValue: false);
    bool useSuffix = context.knobs.boolean(label: 'Use Suffix', initialValue: false);

    FTextButtonSize fTextButtonSize = FTextButtonSize.medium;
    switch (size) {
      case 'Medium':
        fTextButtonSize = FTextButtonSize.medium;
        break;
      case 'Small':
        fTextButtonSize = FTextButtonSize.small;
        break;
    }

    FTextButtonThickness fTextButtonThickness = FTextButtonThickness.strong;
    switch (thickness) {
      case 'Strong':
        fTextButtonThickness = FTextButtonThickness.strong;
        break;
      case 'Thin':
        fTextButtonThickness = FTextButtonThickness.thin;
        break;
    }

    if (type == 'Primary') {
      return FTextButton.primary(
        text: text,
        size: fTextButtonSize,
        thickness: fTextButtonThickness,
        prefixIconPath: usePrefix ? Assets.svgPlus : null,
        suffixIconPath: useSuffix ? Assets.svgPlus : null,
        isDisabled: disabled,
        onTap: () {},
      );
    }
    if (type == 'Secondary') {
      return FTextButton.secondary(
        text: text,
        size: fTextButtonSize,
        thickness: fTextButtonThickness,
        prefixIconPath: usePrefix ? Assets.svgPlus : null,
        suffixIconPath: useSuffix ? Assets.svgPlus : null,
        isDisabled: disabled,
        onTap: () {},
      );
    }
    if (type == 'Assistive') {
      return FTextButton.assistive(
        text: text,
        thickness: fTextButtonThickness,
        prefixIconPath: usePrefix ? Assets.svgPlus : null,
        suffixIconPath: useSuffix ? Assets.svgPlus : null,
        isDisabled: disabled,
        onTap: () {},
      );
    }

    return const SizedBox();
  });
}
