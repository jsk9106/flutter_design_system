import 'package:flutter_design_system/components/f_action_sheet.dart';
import 'package:flutter_design_system/components/f_toast.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Action Sheet',
  type: FActionSheet,
  path: 'element/dialog_using_dimmer',
)
Widget fActionSheets(BuildContext context) {
  int max = context.knobs.int.slider(label: 'Max', min: 2, max: 10, initialValue: 3);
  return Builder(builder: (context) {
    return OutlinedButton(
      child: const Text('Show Action Sheet'),
      onPressed: () => FActionSheet(
        items: [
          for (int i = 1; i < max + 1; i++) 'Action 0$i',
        ],
        names: [for (int i = 1; i < max + 1; i++) 'Action 0$i'],
        onChanged: (a) {
          Navigator.of(context).pop();
          FToast(message: 'Action $a Selected').show(context);
        },
        onCancelText: 'Cancel',
        onCancel: () {
          Navigator.of(context).pop();
        },
      ).show(context),
    );
  });
}
