import 'package:flutter_design_system/components/f_input_stepper.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
//focus out/in 구분

@widgetbook.UseCase(
  name: 'Input Stepper',
  type: FInputStepper,
  path: 'element/inputs',
)
Widget fToasts(BuildContext context) {
  String type = context.knobs.list(label: 'Type', options: ['Round', 'Square'], initialOption: 'Round');

  return GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus();
    },
    child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Builder(builder: (context) {
          if (type == 'Round') {
            return FInputStepper.round(
              initialValue: 0,
              unit: 'mL',
              step: 1,
              onValueChanged: (p0) {},
            );
          }
          if (type == 'Square') {
            return SizedBox(
              width: 114,
              child: FInputStepper.square(
                initialValue: 0,
                step: 1,
                onValueChanged: (p0) {},
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    ),
  );
}
