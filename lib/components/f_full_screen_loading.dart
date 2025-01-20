import 'package:flutter_design_system/components/f_spinner.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';

class FFullScreenLoading extends StatelessWidget {
  const FFullScreenLoading({
    super.key,
    this.spinnerColor,
    this.backgroundColor,
  });

  final Color? spinnerColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? FColors.of(context).black.withValues(alpha: .05),
      alignment: Alignment.center,
      child: FSpinner.small(color: spinnerColor),
    );
  }
}
