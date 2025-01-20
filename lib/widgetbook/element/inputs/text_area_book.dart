import 'package:flutter_design_system/components/f_text_area.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Textarea',
  type: FTextArea,
  path: 'element/inputs',
)
Widget fTextarea(BuildContext context) {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  String type = context.knobs.list(
    label: 'Type',
    options: ['Outlined', 'Contained'],
    initialOption: 'Outlined',
  );

  String info = context.knobs.list(
    label: 'Info',
    options: ['None', 'Error', 'Helper'],
    initialOption: 'None',
  );

  bool isRequired = context.knobs.boolean(
    label: 'Is Required',
    initialValue: false,
  );

  bool isEnabled = context.knobs.boolean(
    label: 'Is Enabled',
    initialValue: true,
  );

  int? maxLength = context.knobs.boolean(
    label: 'Use Max Length',
    initialValue: false,
  )
      ? 500
      : null;

  return IntrinsicHeight(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: type == 'Outlined'
          ? FTextArea(
              focusNode: focusNode,
              controller: controller,
              enabled: isEnabled,
              isRequired: isRequired,
              label: isRequired ? 'Label' : null,
              autoValidateMode: AutovalidateMode.always,
              maxLength: maxLength,
              helperText: info == 'Helper' ? '이곳에 내용을 입력해주세요' : null,
              validator: (value) {
                if (info == 'Error') {
                  return '내용을 입력해주세요';
                }
                return null;
              },
              hintText: '내용을 입력해주세요',
            )
          : FTextArea.contained(
              focusNode: focusNode,
              controller: controller,
              enabled: isEnabled,
              isRequired: isRequired,
              label: isRequired ? 'Label' : null,
              autoValidateMode: AutovalidateMode.always,
              maxLength: maxLength,
              helperText: info == 'Helper' ? '이곳에 내용을 입력해주세요' : null,
              validator: (value) {
                if (info == 'Error') {
                  return '내용을 입력해주세요';
                }
                return null;
              },
              hintText: '내용을 입력해주세요',
            ),
    ),
  );
}
