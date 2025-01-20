import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_design_system/components/f_spinner.dart';
import 'package:flutter/material.dart';

class FPullToRefreshIndicator extends StatelessWidget {
  const FPullToRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController indicatorController,
      ) {
        return AnimatedBuilder(
          animation: indicatorController,
          builder: (BuildContext context, _) {
            return Column(
              children: [
                if (!indicatorController.isIdle) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: FSpinner.small(),
                  ),
                ],
                Expanded(child: child),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}
