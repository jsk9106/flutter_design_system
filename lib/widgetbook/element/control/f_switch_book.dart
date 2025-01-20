import 'package:flutter/material.dart';
import 'package:flutter_design_system/components/f_switch.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 앱에서는 애니메이션 정상 동작함
@widgetbook.UseCase(
  name: 'Switch',
  type: FSwitch,
  path: 'element/control',
)
Widget fswitchs(BuildContext context) {
  return Builder(builder: (context) {
    String size = context.knobs.list(label: 'Size', options: ['Small', 'Normal'], initialOption: 'Normal');
    bool isActived = context.knobs.boolean(label: 'Active', initialValue: false);
    bool isDisabled = context.knobs.boolean(label: 'Disabled', initialValue: false);
    if (size == 'Small') {
      return FSwitch.small(
        context,
        active: isActived,
        disabled: isDisabled,
        onTap: (value) {},
      );
    }
    if (size == 'Normal') {
      return FSwitch.normal(
        context,
        active: isActived,
        disabled: isDisabled,
        onTap: (value) {},
      );
    }
    return const SizedBox();
  });
}
