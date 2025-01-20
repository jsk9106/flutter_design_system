import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'snackbar',
  type: FSnackbar,
  path: 'element/dialog',
)
Widget fSnackbars(BuildContext context) {
  String? title = context.knobs.string(label: 'Title', initialValue: 'Title');
  String? description = context.knobs.string(label: 'Description', initialValue: 'Description');
  String? actionLabel = context.knobs.string(label: 'Action Label', initialValue: 'Action');

  bool? isBanner = context.knobs.boolean(label: 'isBanner', initialValue: false);
  bool usePrefix = context.knobs.boolean(label: 'Use Icon', initialValue: false);
  if (title.isEmpty) {
    title = null;
  }
  if (description.isEmpty) {
    description = null;
  }
  if (actionLabel.isEmpty) {
    actionLabel = null;
  }

  return Builder(builder: (context) {
    return OutlinedButton(
      child: const Text('Show Snackbar'),
      onPressed: () => FSnackbar(
        prefixPath: usePrefix ? Assets.svgPlus : null,
        actionLabel: actionLabel,
        title: title,
        description: description,
        isBanner: isBanner,
      ).show(context),
    );
  });
}
