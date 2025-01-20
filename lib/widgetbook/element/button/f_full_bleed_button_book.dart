import 'package:flutter_design_system/components/f_full_bleed_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// full bleed button 이름 -> f full bleed button
@widgetbook.UseCase(
  name: 'Full Bleed Button',
  type: FFullBleedButton,
  path: 'element/button',
)
Widget fFullBleedButtons(BuildContext context) {
  return Builder(builder: (context) {
    String type = context.knobs.list(label: 'Type', options: ['1 Button', '2 Button'], initialOption: '1 Button');
    String size = context.knobs.list(label: 'Size', options: ['Large', 'XLarge'], initialOption: 'Large');
    String label1 = context.knobs.string(label: 'Label1', initialValue: 'label1');
    bool disabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    String label2 = context.knobs.string(label: 'Label2', initialValue: 'label2');

    return Builder(builder: (context) {
      if (type == '1 Button') {
        return FFullBleedButton.oneButton(
          text: label1,
          disabled: disabled,
          size: size == 'Large' ? FullBleedButtonSize.large : FullBleedButtonSize.xLarge,
          onTap: () {},
        );
      }
      if (type == '2 Button') {
        return FFullBleedButton.twoButton(
          leftText: label1,
          onTapLeft: () {},
          rightText: label2,
          onTapRight: () {},
          disabled: disabled,
          size: size == 'Large' ? FullBleedButtonSize.large : FullBleedButtonSize.xLarge,
        );
      }
      return const SizedBox();
    });
  });
}
