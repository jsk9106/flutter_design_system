import 'package:flutter_design_system/components/time_picker/f_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
//show 마지막으로 통일
// locale 의존도 제거

@widgetbook.UseCase(
  name: 'Time Picker',
  type: FTimePicker,
  path: 'element/picker',
)
Widget fTimePicker(BuildContext context) {
  context.knobs.list(
    label: 'Type',
    options: ['Time Picker'],
    initialOption: 'Time Picker',
  );
  return Builder(builder: (context) {
    return OutlinedButton(
      child: const Text('Show Time Picker'),
      onPressed: () => FTimePickerBottomSheet.show(
        context,
        onConfirm: (p0) {
          Navigator.of(context).pop();
        },
        useMultiLanguage: false,
      ),
    );
  });
}
