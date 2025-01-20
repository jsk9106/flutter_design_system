import 'package:flutter_design_system/components/f_push_message.dart';
import 'package:flutter_design_system/main.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
//(완)title 영역 1줄 제한

@widgetbook.UseCase(
  name: 'push message',
  type: FPushMessage,
  path: 'element/dialog',
)
Widget fPushMessages(BuildContext context) {
  String? title = context.knobs.string(label: 'Title', initialValue: 'Title');
  String? description = context.knobs.string(label: 'Description', initialValue: 'Description');
  int delay = context.knobs.int.slider(
    label: 'Delay(sec)',
    min: 3,
    max: 80,
    initialValue: 3,
    description: '없는 옵션이지만 inspector를 위해 추가함',
  );
  if (title.isEmpty) {
    title = null;
  }
  if (description.isEmpty) {
    description = null;
  }
  return Builder(builder: (context) {
    return OutlinedButton(
      child: const Text('Show Push Message'),
      onPressed: () => FPushMessage(
        title: title,
        description: description,
        delay: Duration(seconds: delay),
      ).show(WidgetBookApp.navigatorKey),
    );
  });
}
