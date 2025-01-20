import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/extentions/context_extension.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum FCheckboxSize { normal, small, tiny }

enum FCheckboxShape { square, round, mark }

class FCheckbox extends StatelessWidget {
  const FCheckbox({
    super.key,
    required this.shape,
    required this.checked,
    this.size = FCheckboxSize.normal,
    this.disabled = false,
    this.label,
    this.checkColor,
    this.onTap,
  });

  final FCheckboxShape shape;
  final bool checked;
  final String? label;
  final FCheckboxSize size;
  final bool disabled;
  final Color? checkColor;
  final void Function(bool value)? onTap;

  factory FCheckbox.square({
    Key? key,
    required bool checked,
    String? label,
    FCheckboxSize size = FCheckboxSize.normal,
    bool disabled = false,
    void Function(bool value)? onTap,
  }) {
    assert(size != FCheckboxSize.tiny, 'Tiny size is not available for square type');
    return FCheckbox(
      key: key,
      shape: FCheckboxShape.square,
      checked: checked,
      label: label,
      onTap: onTap,
      size: size,
      disabled: disabled,
    );
  }

  factory FCheckbox.round({
    Key? key,
    required bool checked,
    String? label,
    FCheckboxSize size = FCheckboxSize.normal,
    bool disabled = false,
    void Function(bool value)? onTap,
  }) {
    assert(size != FCheckboxSize.tiny, 'Tiny size is not available for square type');
    return FCheckbox(
      key: key,
      shape: FCheckboxShape.round,
      checked: checked,
      label: label,
      onTap: onTap,
      size: size,
      disabled: disabled,
    );
  }

  factory FCheckbox.mark({
    Key? key,
    required bool checked,
    String? label,
    bool disabled = false,
    FCheckboxSize size = FCheckboxSize.normal,
    void Function(bool value)? onTap,
  }) {
    return FCheckbox(
      key: key,
      shape: FCheckboxShape.mark,
      label: label,
      checked: checked,
      onTap: onTap,
      size: size,
      disabled: disabled,
      checkColor: disabled
          ? FColors.current.lineAlternative
          : checked
              ? FColors.current.solidStrong
              : FColors.current.lineAlternative,
    );
  }

  double get _checkSize {
    switch (size) {
      case FCheckboxSize.normal:
        return 24;
      case FCheckboxSize.small:
        return 20;
      case FCheckboxSize.tiny:
        return 16;
    }
  }

  TextStyle _textStyle(BuildContext context) {
    Color color = disabled ? FColors.of(context).labelDisable : FColors.of(context).labelNormal;
    switch (size) {
      case FCheckboxSize.normal:
        return FTextStyles.body1_16.r.copyWith(color: color);
      case FCheckboxSize.small:
        return FTextStyles.body2_14.r.copyWith(color: color);
      case FCheckboxSize.tiny:
        return FTextStyles.body2_14.r.copyWith(color: color);
    }
  }

  String _iconPath(BuildContext context) {
    switch (shape) {
      case FCheckboxShape.square:
        // 라이트 모드
        if (context.isBrightness) {
          return disabled
              ? checked
                  ? Assets.iconsCheckboxDisable
                  : Assets.iconsCheckbox
              : checked
                  ? Assets.iconsCheckboxFill
                  : Assets.iconsCheckbox;
        }

        // 다크 모드
        return disabled
            ? checked
                ? Assets.iconsCheckboxDisableDark
                : Assets.iconsCheckboxDark
            : checked
                ? Assets.iconsCheckboxFillDark
                : Assets.iconsCheckboxDark;
      case FCheckboxShape.round:
        // 라이트 모드
        if (context.isBrightness) {
          return disabled
              ? checked
                  ? Assets.iconsNormalCircleCheckDisable
                  : Assets.iconsNormalCircleCheck
              : checked
                  ? Assets.iconsNormalCircleCheckFill
                  : Assets.iconsNormalCircleCheck;
        }

        // 다크 모드
        return disabled
            ? checked
                ? Assets.iconsNormalCircleCheckDisableDark
                : Assets.iconsNormalCircleCheckDark
            : checked
                ? Assets.iconsNormalCircleCheckFillDark
                : Assets.iconsNormalCircleCheckDark;
      case FCheckboxShape.mark:
        return Assets.iconsNormalCheck;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap == null ? null : () => onTap!(!checked),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FSvg.asset(
            _iconPath(context),
            width: _checkSize,
            color: checkColor,
          ),
          if (label != null) ...[
            const Gap(8),
            Text(
              label!,
              style: _textStyle(context),
            ),
          ],
        ],
      ),
    );
  }
}
