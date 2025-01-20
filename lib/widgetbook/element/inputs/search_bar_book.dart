import 'package:flutter_design_system/components/f_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Search Bar',
  type: FSearchBar,
  path: 'element/inputs',
)
Widget fSearchBars(BuildContext context) {
  String type = context.knobs.list(label: 'Type', options: ['Normal', 'Subtle'], initialOption: 'Normal');

  String hint = context.knobs.string(label: 'Hint', initialValue: 'Hint');
  final TextEditingController controller = TextEditingController();

  return StatefulBuilder(builder: (context, setState) {
    if (type == 'Normal') {
      return FSearchBar.normal(
        controller: controller,
        hintText: hint,
        onChanged: (p0) => setState(() {}),
        onClear: () => setState(() {}),
      );
    } else {
      return FSearchBar.subtle(
        controller: controller,
        hintText: hint,
        onChanged: (p0) => setState(() {}),
        onClear: () => setState(() {}),
      );
    }
  });
}
