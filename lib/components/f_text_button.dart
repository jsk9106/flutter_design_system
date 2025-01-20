import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter_design_system/themes/f_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum FTextButtonType {
  primary,
  secondary,
  assistive,
}

enum FTextButtonSize {
  medium,
  small,
}

enum FTextButtonThickness {
  strong,
  thin,
}

class FTextButton extends StatelessWidget {
  const FTextButton({
    super.key,
    required this.type,
    required this.size,
    required this.thickness,
    required this.text,
    this.prefixIconPath,
    this.suffixIconPath,
    this.isDisabled = false,
    required this.onTap,
  });

  final FTextButtonType type;
  final FTextButtonSize size;
  final FTextButtonThickness thickness;
  final String text;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final bool isDisabled;
  final VoidCallback onTap;

  /// 폰트 사이즈
  double get fontSize {
    if (type == FTextButtonType.assistive) {
      return 13;
    }

    switch (size) {
      case FTextButtonSize.medium:
        return 16;
      case FTextButtonSize.small:
        return 14;
    }
  }

  /// 폰트 웨이트
  FontWeight get fontWeight {
    switch (thickness) {
      case FTextButtonThickness.strong:
        return FFontWeight.bold;
      case FTextButtonThickness.thin:
        if (type == FTextButtonType.assistive) {
          return FFontWeight.medium;
        }
        return FFontWeight.regular;
    }
  }

  /// 폰트 컬러
  Color fontColor(BuildContext context) {
    if (isDisabled) {
      return FColors.of(context).labelDisable;
    }
    switch (type) {
      case FTextButtonType.primary:
        return FColors.of(context).labelNormal;
      case FTextButtonType.secondary:
        return FColors.of(context).labelAlternative;
      case FTextButtonType.assistive:
        return FColors.of(context).labelAlternative;
    }
  }

  /// primary
  factory FTextButton.primary({
    Key? key,
    required String text,
    FTextButtonSize size = FTextButtonSize.medium,
    FTextButtonThickness thickness = FTextButtonThickness.strong,
    String? prefixIconPath,
    String? suffixIconPath,
    bool isDisabled = false,
    required VoidCallback onTap,
  }) {
    return FTextButton(
      key: key,
      type: FTextButtonType.primary,
      text: text,
      size: size,
      thickness: thickness,
      prefixIconPath: prefixIconPath,
      suffixIconPath: suffixIconPath,
      isDisabled: isDisabled,
      onTap: onTap,
    );
  }

  /// secondary
  factory FTextButton.secondary({
    Key? key,
    required String text,
    FTextButtonSize size = FTextButtonSize.medium,
    FTextButtonThickness thickness = FTextButtonThickness.strong,
    String? prefixIconPath,
    String? suffixIconPath,
    bool isDisabled = false,
    required VoidCallback onTap,
  }) {
    return FTextButton(
      key: key,
      type: FTextButtonType.secondary,
      text: text,
      size: size,
      thickness: thickness,
      prefixIconPath: prefixIconPath,
      suffixIconPath: suffixIconPath,
      isDisabled: isDisabled,
      onTap: onTap,
    );
  }

  /// assistive
  factory FTextButton.assistive({
    Key? key,
    required String text,
    FTextButtonThickness thickness = FTextButtonThickness.strong,
    String? prefixIconPath,
    String? suffixIconPath,
    bool isDisabled = false,
    required VoidCallback onTap,
  }) {
    return FTextButton(
      key: key,
      type: FTextButtonType.assistive,
      text: text,
      size: FTextButtonSize.small,
      thickness: thickness,
      prefixIconPath: prefixIconPath,
      suffixIconPath: suffixIconPath,
      isDisabled: isDisabled,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIconPath != null) ...[
            FSvg.asset(
              prefixIconPath!,
              width: 16,
              color: fontColor(context),
            ),
            const Gap(4),
          ],
          Text(
            text,
            style: FTextStyles.body1_16.copyWith(
              color: fontColor(context),
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          if (suffixIconPath != null) ...[
            const Gap(4),
            FSvg.asset(
              suffixIconPath!,
              width: 16,
              color: fontColor(context),
            ),
          ],
        ],
      ),
    );
  }
}
