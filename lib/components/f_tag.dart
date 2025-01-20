import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FTag extends StatelessWidget {
  const FTag({
    super.key,
    required this.label,
    required this.padding,
    this.color,
    this.fontColor,
    this.borderRadius,
  });

  final String label;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? fontColor;
  final BorderRadius? borderRadius;

  factory FTag.normal({
    required String label,
    Color? color,
    Color? fontColor,
    BorderRadius? borderRadius,
  }) =>
      FTag(
        label: label,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: color,
        fontColor: fontColor,
        borderRadius: borderRadius,
      );

  factory FTag.small({
    required String label,
    Color? color,
    Color? fontColor,
    BorderRadius? borderRadius,
  }) =>
      FTag(
        label: label,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: color,
        fontColor: fontColor,
        borderRadius: borderRadius,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? FColors.of(context).solidStrong,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: FTextStyles.bodyS.copyWith(
          color: fontColor ?? FColors.of(context).inverseNormal,
        ),
      ),
    );
  }
}
