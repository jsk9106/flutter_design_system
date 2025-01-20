import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter_design_system/themes/f_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// suffix의 disabled 조건이 있으므로 widget 대신 path를 입력 받음.

class FFilterChips extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function(bool isSelected)? onChanged;
  final bool disabled;
  final bool isMultiple;
  final String? suffix;

  const FFilterChips._({
    required this.label,
    required this.isSelected,
    required this.onChanged,
    this.disabled = false,
    required this.isMultiple,
    this.suffix,
  });

  factory FFilterChips.singular({
    required String label,
    required bool isSelected,
    bool disabled = false,
    required void Function(bool isSelected)? onChanged,
  }) {
    return FFilterChips._(
      label: label,
      isSelected: isSelected,
      onChanged: onChanged,
      disabled: disabled,
      isMultiple: false,
    );
  }

  factory FFilterChips.multiple({
    required String label,
    required bool isSelected,
    bool disabled = false,
    required void Function(bool isSelected)? onChanged,
    String? suffix,
  }) {
    return FFilterChips._(
      label: label,
      isSelected: isSelected,
      onChanged: onChanged,
      disabled: disabled,
      isMultiple: true,
      suffix: suffix,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (disabled) {
      return FColors.of(context).solidDisable;
    }

    if (isMultiple) {
      return Colors.transparent;
    }

    return isSelected ? FColors.of(context).solidStrong : FColors.of(context).solidAssistive;
  }

  Color _getBorderColor(BuildContext context) {
    if (!isMultiple) {
      return _getBackgroundColor(context);
    }

    if (disabled) {
      return FColors.of(context).lineAlternative;
    }

    if (isSelected) {
      return FColors.of(context).lineStrong;
    }

    return FColors.of(context).lineAlternative;
  }

  FontWeight _getFontWeight(BuildContext context) {
    if (disabled) {
      return FFontWeight.regular;
    }

    if (isSelected) {
      return FFontWeight.medium;
    }

    return FFontWeight.regular;
  }

  Color _getTextColor(BuildContext context) {
    if (disabled) {
      return FColors.of(context).labelDisable;
    } else if (isSelected) {
      return isMultiple ? FColors.of(context).labelStrong : FColors.of(context).inverseStrong;
    } else {
      return FColors.of(context).labelNormal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (disabled) return;
        onChanged?.call(!isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _getBorderColor(context),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: FTextStyles.body2_14.copyWith(
                color: _getTextColor(context),
                fontWeight: _getFontWeight(context),
              ),
            ),
            if (isMultiple && suffix != null) ...[
              const Gap(4),
              FSvg.asset(
                suffix!,
                color: disabled ? FColors.of(context).labelDisable : FColors.of(context).labelStrong,
                width: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
