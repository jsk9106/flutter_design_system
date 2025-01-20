import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FSelectableActionSheet extends StatefulWidget {
  const FSelectableActionSheet({
    required this.items,
    required this.names,
    required this.onChanged,
    this.selectedItems = const [], // 초기값을 받는 필드
    this.onCancel,
    this.onCancelText,
    this.title,
    this.icon,
    this.onClose,
    this.isMultiSelect = false,
    super.key,
  });

  final List<Object> items;
  final List<String> names;
  final Function(List<Object>) onChanged;
  final List<Object> selectedItems;
  final Function? onCancel;
  final String? onCancelText;
  final String? title;
  final Widget? icon;
  final Function? onClose;
  final bool isMultiSelect;

  @override
  State<FSelectableActionSheet> createState() => _FSelectableActionSheetState();

  Future show(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: FColors.of(context).backgroundAlternativeN,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: this,
        );
      },
    );
  }
}

class _FSelectableActionSheetState extends State<FSelectableActionSheet> {
  late List<Object> _selectedItems;

  @override
  void initState() {
    super.initState();
    // 초기값을 이용해 _selectedItems 초기화
    _selectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FColors.of(context).backgroundElevatedNormal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          if (widget.title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                minTileHeight: 48,
                onTap: () {
                  if (widget.onClose != null) {
                    widget.onClose!();
                  } else {
                    Navigator.pop(context);
                  }
                },
                leading: FSvg.asset(
                  Assets.iconsCloseNormalThin,
                  width: 24,
                  height: 24,
                  color: FColors.of(context).labelNormal,
                ),
                titleAlignment: ListTileTitleAlignment.center,
                title: Center(
                  child: Text(
                    widget.title!,
                    style: FTextStyles.bodyXL.m.copyWith(color: FColors.of(context).labelStrong),
                  ),
                ),
                trailing: widget.icon ?? const SizedBox(width: 16),
              ),
            ),
          const Gap(12),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedItems.contains(widget.items[index]);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    widget.names[index],
                    style: isSelected
                        ? FTextStyles.bodyL.m.copyWith(
                            color: FColors.of(context).labelStrong,
                          )
                        : FTextStyles.bodyL.copyWith(
                            color: FColors.of(context).labelNormal,
                          ),
                  ),
                  trailing: isSelected
                      ? FSvg.asset(
                          Assets.iconsCheckboxCheck,
                          color: FColors.of(context).labelStrong,
                          width: 20,
                          height: 20,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      if (widget.isMultiSelect) {
                        if (isSelected) {
                          _selectedItems.remove(widget.items[index]);
                        } else {
                          _selectedItems.add(widget.items[index]);
                        }
                      } else {
                        _selectedItems = [widget.items[index]];
                      }
                    });
                    widget.onChanged(_selectedItems);

                    // Close the bottom sheet if not multi-select
                    if (!widget.isMultiSelect) {
                      Navigator.pop(context, _selectedItems);
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
