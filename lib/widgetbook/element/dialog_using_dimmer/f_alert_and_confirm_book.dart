import 'package:flutter_design_system/components/f_dialog.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// barrierDismissible 불필요
// confirm 눌렀을 때 콜백 이후 닫는 것 필요
// 취소일 때 콜백 이후 닫는 것 필요
// twoButton의 경우 취소시 받는 context 상위 context임 dialog context로 변경 필요
// threeButton의 경우 콜백 optional
// two 버튼일 경우 취소가 아닌 오른쪽 왼쪽으로 구분 필요
@widgetbook.UseCase(
  name: 'Alert and Confirm',
  type: FDialog,
  path: 'element/dialog_using_dimmer',
)
Widget fAlertAndConfirms(BuildContext context) {
  String type = context.knobs.list(
    label: 'Type',
    options: ['One', 'Two', 'Three'],
    initialOption: 'One',
  );
  String? title = context.knobs.string(label: 'Title', initialValue: 'Title');
  String? description = context.knobs.string(label: 'Description', initialValue: 'Description');
  if (title.isEmpty) {
    title = null;
  }
  if (description.isEmpty) {
    description = null;
  }
  return Builder(builder: (context) {
    return OutlinedButton(
        child: const Text('Show Dialog'),
        onPressed: () {
          if (type == 'One') {
            FDialog.oneButton(
              title: title,
              description: description,
              confirmText: '확인',
              onConfirm: () {},
            ).show(context);
          } else if (type == 'Two') {
            FDialog.twoButton(
              context,
              title: title,
              description: description,
              confirmText: '확인',
              cancelText: '취소',
              onConfirm: () {},
              onCancel: () {},
            ).show(context);
          } else if (type == 'Three') {
            FDialog.threeButton(
              context,
              title: title,
              description: description ?? '',
              firstText: '첫 번째',
              secondText: '두 번째',
              cancelText: '취소',
              onFirstPressed: () {},
              onSecondPressed: () {},
              onCancel: () {},
            ).show(context);
          }
        });
  });
}
