import 'package:flutter_design_system/extentions/context_extension.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter_design_system/themes/f_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef FActionSheetTextStyleMapper = Map<int, TextStyle>;

class FActionSheet extends StatefulWidget {
  const FActionSheet({
    required this.items,
    required this.names,
    required this.onChanged,
    this.selectedItem,
    this.onCancel,
    this.onCancelText,
    this.textStyleMapper,
    super.key,
  });

  final List<Object> items;
  final List<String> names;
  final Function onChanged;
  final Object? selectedItem;
  final Function? onCancel;
  final String? onCancelText;
  final FActionSheetTextStyleMapper? textStyleMapper;

  @override
  State<FActionSheet> createState() => _FActionSheetState();

  Future show(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }
}

class _FActionSheetState extends State<FActionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FColors.of(context).backgroundElevatedNormal,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      height: getHeight,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12.0),
        itemCount: widget.items.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.items.length) {
            final bool isSelected = widget.items[index] == widget.selectedItem;
            return _buildItem(index, isSelected);
          }
          return _buildCancelButton();
        },
      ),
    );
  }

  Widget _buildItem(int index, bool isSelected) {
    return ListTile(
      minTileHeight: 52,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Text(
            widget.names[index],
            style: widget.textStyleMapper?[index] ??
                FTextStyles.bodyL.copyWith(
                  color: isSelected ? FColors.of(context).labelStrong : FColors.of(context).labelNormal,
                  fontWeight: isSelected ? FFontWeight.medium : FFontWeight.regular,
                ),
          ),
        ),
      ),
      onTap: () => widget.onChanged(widget.items[index]),
    );
  }

  Widget _buildCancelButton() {
    return Column(
      children: [
        const Gap(8),
        ListTile(
          minTileHeight: 48,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: Text(
                widget.onCancelText ?? context.localeString.t_ui_public_bt_cancel,
                style: FTextStyles.bodyL.b.copyWith(
                  color: FColors.of(context).labelAlternative,
                ),
              ),
            ),
          ),
          onTap: () {
            if (widget.onCancel != null) {
              widget.onCancel?.call();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  double get getHeight {
    const double itemHeight = 52.0;
    const double cancelButtonHeight = 56.0; // Gap 8 + 48
    const double padding = 34.0; // ListView top padding
    final int itemCount = widget.items.length;

    if (itemCount <= 6) {
      return (itemHeight * itemCount) + cancelButtonHeight + padding;
    }
    return (itemHeight * 6) + cancelButtonHeight + padding;
  }
}
