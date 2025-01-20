import 'package:flutter/material.dart';
import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_toast.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Toast',
  type: FToast,
  path: 'element/dialog',
)
Widget fToasts(BuildContext context) {
  String message = context.knobs.string(label: 'Message', initialValue: 'Enter a Feedback Text');
  bool? usePrefix = context.knobs.boolean(label: 'Use Icon', initialValue: false);

  return Builder(builder: (context) {
    return OutlinedButton(
        child: const Text('Show Toast'),
        onPressed: () => FToast(
              prefixPath: usePrefix ? Assets.svgPlus : null,
              message: message,
            ).show(context));
  });
}
