import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isScrolled;
  final String? label;
  final String iconPath;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double iconButtonSize;
  final double iconButtonExtendedWidth;
  final bool? disabled;
  final _FFloatingActionButtonType _type;

  const FFloatingActionButton._({
    required this.onTap,
    required this.isScrolled,
    this.label,
    required this.iconPath,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.disabled,
    required this.iconButtonSize,
    required this.iconButtonExtendedWidth,
    required _FFloatingActionButtonType type,
  }) : _type = type;

  /// Normal type factory constructor
  /// Icon color and text color can be customized
  factory FFloatingActionButton.normal({
    required VoidCallback onTap,
    required bool isScrolled,
    String? label,
    required String iconPath,
    Color? iconColor,
    Color? textColor,
    bool? disabled = false,
  }) {
    return FFloatingActionButton._(
      onTap: onTap,
      isScrolled: isScrolled,
      label: label,
      iconPath: iconPath,
      iconColor: iconColor,
      textColor: textColor,
      iconButtonSize: 50,
      iconButtonExtendedWidth: 116,
      disabled: disabled,
      type: _FFloatingActionButtonType.normal,
    );
  }

  /// Accent type factory constructor
  /// Background color can be customized
  factory FFloatingActionButton.accent({
    required VoidCallback onTap,
    required bool isScrolled,
    String? label,
    required String iconPath,
    required Color backgroundColor,
    Color? iconColor,
    Color? textColor,
    bool? disabled = false,
  }) {
    return FFloatingActionButton._(
      onTap: onTap,
      isScrolled: isScrolled,
      label: label,
      iconPath: iconPath,
      backgroundColor: backgroundColor,
      iconButtonSize: 50,
      iconButtonExtendedWidth: 116,
      type: _FFloatingActionButtonType.accent,
      disabled: disabled,
      iconColor: iconColor,
      textColor: textColor,
    );
  }

  /// Subtle type factory constructor
  factory FFloatingActionButton.subtle({
    required VoidCallback onTap,
    required bool isScrolled,
    String? label,
    required String iconPath,
    bool? disabled = false,
  }) {
    return FFloatingActionButton._(
      onTap: onTap,
      isScrolled: isScrolled,
      label: label,
      iconPath: iconPath,
      iconButtonSize: 44,
      iconButtonExtendedWidth: 110,
      disabled: disabled,
      type: _FFloatingActionButtonType.subtle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = FColors.of(context);

    Color getBackgroundColor() {
      if (disabled == true) {
        return colors.solidDisable;
      }
      switch (_type) {
        case _FFloatingActionButtonType.normal:
          return colors.solidStrong;
        case _FFloatingActionButtonType.accent:
          return backgroundColor ?? colors.solidStrong;
        case _FFloatingActionButtonType.subtle:
          return colors.solidDisable;
      }
    }

    Color getForegroundColor() {
      if (disabled == true) {
        return colors.labelDisable;
      }
      switch (_type) {
        case _FFloatingActionButtonType.normal:
        case _FFloatingActionButtonType.accent:
          return colors.inverseStrong;
        case _FFloatingActionButtonType.subtle:
          return colors.labelDisable;
      }
    }

    BorderSide? getBorderSide() {
      switch (_type) {
        case _FFloatingActionButtonType.normal:
        case _FFloatingActionButtonType.accent:
          return null;
        case _FFloatingActionButtonType.subtle:
          return BorderSide(color: colors.lineAssistive);
      }
    }

    return isScrolled
        ? SizedBox(
            height: iconButtonSize,
            width: iconButtonSize,
            child: FloatingActionButton(
              onPressed: () {
                if (disabled!) return;
                onTap();
              },
              backgroundColor: getBackgroundColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: getBorderSide() ?? BorderSide.none,
              ),
              child: SizedBox(
                width: 20,
                height: 20,
                child: FSvg.asset(
                  iconPath,
                  color: _type == _FFloatingActionButtonType.normal
                      ? iconColor ?? getForegroundColor()
                      : getForegroundColor(),
                ),
              ),
            ),
          )
        : SizedBox(
            height: iconButtonSize,
            width: iconButtonExtendedWidth,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (disabled!) return;
                onTap();
              },
              label: Text(
                label ?? '',
                style: FTextStyles.bodyXL.b.copyWith(
                  color: _type == _FFloatingActionButtonType.normal || _type == _FFloatingActionButtonType.accent
                      ? textColor ?? getForegroundColor()
                      : getForegroundColor(),
                ),
              ),
              icon: FSvg.asset(
                iconPath,
                color: _type == _FFloatingActionButtonType.normal || _type == _FFloatingActionButtonType.accent
                    ? iconColor ?? getForegroundColor()
                    : getForegroundColor(),
              ),
              backgroundColor: getBackgroundColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: getBorderSide() ?? BorderSide.none,
              ),
            ),
          );
  }
}

enum _FFloatingActionButtonType {
  normal,
  accent,
  subtle,
}
