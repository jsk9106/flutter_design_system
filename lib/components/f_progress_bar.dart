import 'package:flutter/material.dart';
import 'package:flutter_design_system/themes/f_colors.dart';

class FProgressBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color? color;
  final Color? startColor;
  final Color? endColor;
  final bool useGradient;
  final bool animate;
  final Duration animationDuration;

  const FProgressBar({
    super.key,
    required this.value,
    required this.maxValue,
    this.color,
    this.startColor,
    this.endColor,
    this.useGradient = false,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    final widthFactor = (maxValue == 0) ? 0.0 : (value / maxValue).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            color: FColors.of(context).solidAssistive,
            borderRadius: BorderRadius.circular(5),
          ),
          child: animate
              ? TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: widthFactor),
                  duration: animationDuration,
                  builder: (context, widthFactor, child) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: widthFactor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: useGradient ? null : color,
                            gradient: useGradient && startColor != null && endColor != null
                                ? LinearGradient(
                                    colors: [startColor!, endColor!],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: value / maxValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: useGradient ? null : color,
                        gradient: useGradient && startColor != null && endColor != null
                            ? LinearGradient(
                                colors: [startColor!, endColor!],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
