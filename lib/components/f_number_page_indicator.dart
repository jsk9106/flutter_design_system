import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum FNumberPageIndicatorSize { small, normal }

class FNumberPageIndicator extends StatefulWidget {
  final int currentIndex;
  final int totalItems;
  final bool showBackground;
  final FNumberPageIndicatorSize size;

  const FNumberPageIndicator._({
    required this.currentIndex,
    required this.totalItems,
    required this.size,
    this.showBackground = true,
  });

  factory FNumberPageIndicator.small({
    required int totalItems,
    int currentIndex = 0,
    bool showBackground = true,
  }) {
    return FNumberPageIndicator._(
      currentIndex: currentIndex,
      totalItems: totalItems,
      showBackground: showBackground,
      size: FNumberPageIndicatorSize.small,
    );
  }

  factory FNumberPageIndicator.normal({
    required int totalItems,
    int currentIndex = 0,
    bool showBackground = true,
  }) {
    return FNumberPageIndicator._(
      currentIndex: currentIndex,
      totalItems: totalItems,
      showBackground: showBackground,
      size: FNumberPageIndicatorSize.normal,
    );
  }

  @override
  _FNumberPageIndicatorState createState() => _FNumberPageIndicatorState();
}

class _FNumberPageIndicatorState extends State<FNumberPageIndicator> {
  @override
  Widget build(BuildContext context) {
    final isSmall = widget.size == FNumberPageIndicatorSize.small;
    final containerWidth = isSmall ? 52.0 : 63.0;
    final sizedBoxWidth = isSmall ? 15.0 : 18.0;
    final double padding = isSmall ? 6.0 : 8.0;

    return Container(
      width: containerWidth,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding / 2,
      ),
      decoration: BoxDecoration(
        color: widget.showBackground ? FColors.of(context).black.withValues(alpha: 0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: sizedBoxWidth,
            child: Text(
              '${widget.currentIndex + 1}',
              textAlign: TextAlign.center,
              style: isSmall
                  ? FTextStyles.bodyS.m.copyWith(
                      color: FColors.of(context).white,
                    )
                  : FTextStyles.bodyL.m.copyWith(
                      color: FColors.of(context).white,
                    ),
            ),
          ),
          const Gap(2),
          Text(
            '/',
            textAlign: TextAlign.center,
            style: isSmall
                ? FTextStyles.bodyS.r.copyWith(
                    color: FColors.of(context).white,
                  )
                : FTextStyles.bodyL.r.copyWith(
                    color: FColors.of(context).white,
                  ),
          ),
          const Gap(2),
          SizedBox(
            width: sizedBoxWidth,
            child: Text(
              '${widget.totalItems}',
              textAlign: TextAlign.center,
              style: isSmall
                  ? FTextStyles.bodyS.r.copyWith(
                      color: FColors.of(context).white.withValues(alpha: .8),
                    )
                  : FTextStyles.bodyL.r.copyWith(
                      color: FColors.of(context).white.withValues(alpha: .8),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
