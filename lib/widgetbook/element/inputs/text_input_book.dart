import 'package:flutter_design_system/components/f_text_input.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Text Input',
  type: FTextInput,
  path: 'element/inputs',
)
Widget fTextFields(BuildContext context) {
  String type = context.knobs.list(label: 'Type', options: ['Outlined', 'Contained'], initialOption: 'Outlined');
  // label 설정을 boolean과 text로 분리
  bool useLabel = context.knobs.boolean(
    label: 'Use Label',
    initialValue: false,
  );
  String labelText = context.knobs.string(
    label: 'Label Text',
    initialValue: 'Label',
  );
  bool isRequired = context.knobs.boolean(
    label: 'Is Required',
    initialValue: false,
  );

  Widget icon = Center(
    child: Icon(
      Icons.add,
      size: 24,
      color: FColors.of(context).labelAssistive,
    ),
  );
  Widget suffixWidget = Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.add,
          size: 24,
          color: FColors.of(context).labelAssistive,
        ),
        const Gap(4),
        Text(
          '00:00',
          textAlign: TextAlign.center,
          style: FTextStyles.bodyL.copyWith(color: FColors.of(context).labelAssistive),
        ),
        const Gap(12),
      ],
    ),
  );
  String info = context.knobs.list(label: 'Info', options: ['None', 'Error', 'Helper'], initialOption: 'None');
  bool usePrefix = context.knobs.boolean(label: 'Use Prefix', initialValue: false);
  bool useSuffix = context.knobs.boolean(label: 'Use Suffix', initialValue: false);
  bool isPassword = context.knobs.boolean(label: 'Is Password', initialValue: false);
  bool isEnabled = context.knobs.boolean(label: 'Is Enabled', initialValue: true);

  return Builder(builder: (context) {
    if (type == 'Outlined') {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FTextInput(
            enabled: isEnabled,
            isRequired: isRequired,
            label: useLabel ? labelText : null, // 수정된 부분
            prefix: usePrefix ? icon : null,
            suffix: useSuffix ? suffixWidget : null,
            autoValidateMode: AutovalidateMode.always,
            hintText: '이메일을 입력하세요',
            isPassword: isPassword,
            helperText: info == 'Helper' ? '이곳에 이메일을 입력해주세요' : null,
            validator: (value) {
              if (info == 'Error') {
                return '올바른 이메일 형식이 아닙니다';
              }
              return null;
            },
          ),
        ),
      );
    } else {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FTextInput.contained(
            enabled: isEnabled,
            isRequired: isRequired,
            label: useLabel ? labelText : null, // 수정된 부분
            prefix: usePrefix ? icon : null,
            suffix: useSuffix ? suffixWidget : null,
            autoValidateMode: AutovalidateMode.always,
            isPassword: isPassword,
            helperText: info == 'Helper' ? '이곳에 이메일을 입력해주세요' : null,
            validator: (value) {
              if (info == 'Error') {
                return '올바른 이메일 형식이 아닙니다';
              }
              return null;
            },
          ),
        ),
      );
    }
  });
}
