import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FRadio extends StatelessWidget {
  final bool isChecked;
  final bool disabled;
  final String? label;
  final void Function(bool value)? onTap;
  final double size;
  final TextStyle textStyle;

  const FRadio({
    super.key,
    required this.isChecked,
    this.disabled = false,
    this.label,
    this.onTap,
    required this.size,
    required this.textStyle,
  });

  factory FRadio.normal(
    BuildContext context, {
    required bool isChecked,
    bool disabled = false,
    String? label,
    void Function(bool value)? onTap,
  }) =>
      FRadio(
        isChecked: isChecked,
        disabled: disabled,
        label: label,
        onTap: onTap,
        size: 20.0, // 24 -> 20으로 수정
        textStyle: FTextStyles.bodyXL.r.copyWith(
          color: disabled ? FColors.of(context).labelDisable : FColors.of(context).labelNormal,
        ),
      );

  factory FRadio.small(
    BuildContext context, {
    required bool isChecked,
    bool disabled = false,
    String? label,
    void Function(bool value)? onTap,
  }) =>
      FRadio(
        isChecked: isChecked,
        disabled: disabled,
        label: label,
        onTap: onTap,
        size: 16.0, // 20 -> 16으로 수정
        textStyle: FTextStyles.bodyL.r.copyWith(
          color: disabled ? FColors.of(context).labelDisable : FColors.of(context).labelNormal,
        ),
      );

  Color checkIconColor(BuildContext context) {
    if (disabled) {
      return !isChecked
          ? Colors.transparent // disabled이고 체크되지 않은 상태
          : FColors.of(context).solidDisable;
    } else {
      return isChecked ? FColors.of(context).inverseStrong : Colors.transparent;
    }
  }

  Color? checkboxColor(BuildContext context) {
    if (disabled) {
      return !isChecked
          ? FColors.of(context).solidDisable // disabled이고 체크되지 않은 상태
          : FColors.of(context).solidNeutral; // disabled이고 체크된 상태
    } else {
      return isChecked ? FColors.of(context).solidStrong : Colors.transparent;
    }
  }

  BoxBorder? checkboxBorder(BuildContext context) {
    if (disabled) {
      return Border.all(
        color: !isChecked
            ? FColors.of(context).lineAlternative // disabled이고 체크되지 않은 상태
            : FColors.of(context).solidNeutral, // disabled이고 체크된 상태
        width: 2,
      );
    } else {
      return Border.all(
        color: isChecked ? FColors.of(context).solidStrong : FColors.of(context).lineAlternative,
        width: 2,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (disabled) return;
        if (onTap != null) {
          onTap!(!isChecked);
        }
      },
      child: label != null ? _checkboxWithText(context) : _singleCheckbox(context),
    );
  }

  Widget _singleCheckbox(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: checkboxColor(context),
              borderRadius: BorderRadius.circular(size / 2),
              border: checkboxBorder(context),
            ),
          ),
          if (isChecked)
            Container(
              width: size == 20.0 ? 9.0 : 7.0, // 정확한 내부 원 크기 지정
              height: size == 20.0 ? 9.0 : 7.0,
              decoration: BoxDecoration(
                color: checkIconColor(context),
                borderRadius: BorderRadius.circular(size / 2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _checkboxWithText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _singleCheckbox(context),
        const SizedBox(width: 8),
        Text(
          label!,
          style: textStyle,
        ),
      ],
    );
  }
}
