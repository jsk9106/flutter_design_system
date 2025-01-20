import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

enum FSpinnerType { large, small, custom }

class FSpinner extends StatefulWidget {
  final Color? color;
  final Widget? icon;
  final bool clockwise;
  final String? text;
  final TextStyle? textStyle;
  final double spinnerSize;
  final FSpinnerType type;

  // 기본 생성자를 private으로 변경
  const FSpinner._({
    super.key,
    this.color,
    this.icon,
    this.clockwise = true,
    this.text,
    this.textStyle,
    required this.spinnerSize,
    required this.type,
  });

  // Large 스피너 팩토리 생성자
  factory FSpinner.large({
    Key? key,
    Color? color,
    Widget? icon,
    bool clockwise = true,
    String? text,
    TextStyle? textStyle,
  }) {
    return FSpinner._(
      key: key,
      color: color,
      icon: icon,
      clockwise: clockwise,
      text: text,
      textStyle: textStyle,
      spinnerSize: 39,
      type: FSpinnerType.large,
    );
  }

  // Small 스피너 팩토리 생성자
  factory FSpinner.small({
    Key? key,
    Color? color,
    Widget? icon,
    bool clockwise = true,
    String? text,
    TextStyle? textStyle,
  }) {
    return FSpinner._(
      key: key,
      color: color,
      icon: icon,
      clockwise: clockwise,
      text: text,
      textStyle: textStyle,
      spinnerSize: 36,
      type: FSpinnerType.small,
    );
  }

  // Custom 크기 스피너 팩토리 생성자
  factory FSpinner.custom({
    Key? key,
    Color? color,
    Widget? icon,
    bool clockwise = true,
    String? text,
    TextStyle? textStyle,
    required double customSize,
  }) {
    return FSpinner._(
      key: key,
      color: color,
      icon: icon,
      clockwise: clockwise,
      text: text,
      textStyle: textStyle,
      spinnerSize: customSize,
      type: FSpinnerType.custom,
    );
  }

  @override
  _FSpinnerState createState() => _FSpinnerState();
}

class _FSpinnerState extends State<FSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.clockwise ? 1.0 : -1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: widget.spinnerSize,
                  height: widget.spinnerSize,
                  child: widget.icon != null
                      ? _buildIconSpinner()
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.color ?? FColors.of(context).fietFitness,
                          ),
                          strokeWidth: 3.7,
                        ),
                ),
                if (widget.text != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    widget.text!,
                    style: widget.textStyle ??
                        FTextStyles.bodyL.copyWith(
                          color: FColors.of(context).white,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSpinner() {
    return RotationTransition(
      turns: _animation,
      child: widget.icon,
    );
  }
}
