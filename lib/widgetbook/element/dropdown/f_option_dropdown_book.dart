import 'package:flutter_design_system/components/f_action_sheet.dart';
import 'package:flutter_design_system/components/f_option_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Option Dropdown',
  type: FOptionDropdown,
  path: 'element/dropdown',
)
Widget fOptionDropDowns(BuildContext context) {
  String type = context.knobs.list(label: 'Type', options: ['Overlay', 'BottomSheet'], initialOption: 'Overlay');
  String hint = context.knobs.string(label: 'Hint', initialValue: 'Hint');
  int itemCount = context.knobs.int.slider(label: 'Item Count', initialValue: 3);
  bool isRequired = context.knobs.boolean(label: 'Is Required', initialValue: true);
  bool isEnable = context.knobs.boolean(label: 'Is Enable', initialValue: true);
  bool isDisabledPretyped = context.knobs.boolean(label: 'Is Disabled Pretyped', initialValue: false); // 추가된 부분
  bool isError = context.knobs.boolean(label: 'Is Error', initialValue: true);
  bool showDescription = context.knobs.boolean(label: 'Show Description', initialValue: true);

  return Builder(builder: (context) {
    return _FOptionDropdown(
      hint: hint,
      type: type,
      items: List.generate(itemCount, (index) => 'Item ${index + 1}'),
      isRequired: isRequired,
      isEnable: isEnable,
      isDisabledPretyped: isDisabledPretyped, // 추가된 부분
      isError: isError,
      showDescription: showDescription,
    );
  });
}

// ignore: must_be_immutable
class _FOptionDropdown extends StatefulWidget {
  _FOptionDropdown({
    required this.hint,
    required this.type,
    required this.items,
    required this.isRequired,
    required this.isEnable,
    required this.isDisabledPretyped, // 추가된 부분
    required this.isError,
    required this.showDescription,
  });

  String hint;
  String type;
  List<String> items;
  bool isRequired;
  bool isEnable;
  bool isDisabledPretyped; // 추가된 부분
  bool isError;
  bool showDescription;

  @override
  State<_FOptionDropdown> createState() => _FOptionDropdownState();
}

class _FOptionDropdownState extends State<_FOptionDropdown> {
  String? selectedValue;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FOptionDropdown(
        focusNode: focusNode,
        type: widget.type == 'Overlay' ? DropdownType.overlay : DropdownType.bottomSheet,
        onTap: () {
          if (widget.type == 'Overlay') return;
          FActionSheet(
            items: widget.items,
            names: widget.items,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              Navigator.of(context).pop();
              focusNode.unfocus();
            },
            onCancelText: 'Cancel',
            onCancel: () {},
          ).show(context);
        },
        hintText: widget.hint,
        items: widget.items,
        value: selectedValue,
        enabled: widget.isEnable,
        disabledPretyped: widget.isDisabledPretyped, // 추가된 부분
        isRequired: widget.isRequired,
        label: widget.isRequired ? 'Label' : null,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        isError: widget.isError,
        description: widget.showDescription ? 'Description' : null,
      ),
    );
  }
}
