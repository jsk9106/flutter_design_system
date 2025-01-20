import 'package:flutter_design_system/components/f_action_sheet.dart';
import 'package:flutter_design_system/components/f_sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Sort Dropdown',
  type: FSortDropdown,
  path: 'element/dropdown',
)
Widget fSortDropDowns(BuildContext context) {
  String size = context.knobs.list(label: 'Size', options: ['Small', 'Normal'], initialOption: 'Small');
  int itemCount = context.knobs.int.slider(label: 'Item Count', initialValue: 3);

  return IntrinsicWidth(
    child: FSortDropdowns(
      size: size,
      items: List.generate(itemCount, (index) => 'Item ${index + 1}'),
    ),
  );
}

class FSortDropdowns extends StatefulWidget {
  const FSortDropdowns({super.key, required this.size, required this.items});

  final String size;
  final List<String> items;

  @override
  State<FSortDropdowns> createState() => _FSortDropdownsState();
}

class _FSortDropdownsState extends State<FSortDropdowns> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    if (widget.size == 'Small') {
      return FSortDropdown.small(
        label: selectedValue ?? 'Label',
        onTap: () {
          FActionSheet(
            items: widget.items,
            names: widget.items,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              Navigator.of(context).pop();
            },
            onCancelText: 'Cancel',
            onCancel: () {
              Navigator.of(context).pop();
            },
          ).show(context);
        },
      );
    }
    if (widget.size == 'Normal') {
      return FSortDropdown.normal(
        label: selectedValue ?? 'Label',
        onTap: () {
          FActionSheet(
            items: widget.items,
            names: widget.items,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              Navigator.of(context).pop();
            },
            onCancelText: 'Cancel',
            onCancel: () {
              Navigator.of(context).pop();
            },
          ).show(context);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
