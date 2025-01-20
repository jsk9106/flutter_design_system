import 'package:flutter_design_system/components/f_responsive.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FPushMessage extends StatelessWidget {
  const FPushMessage({
    super.key,
    this.title,
    this.description,
    this.delay = const Duration(seconds: 3),
    this.onTap,
  }) : assert(
          !(title == null && description == null),
          'At least one of title or description must be provided',
        );

  final String? title;
  final String? description;
  final Duration delay;
  final VoidCallback? onTap;

  double _getHorizontalMargin(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (FResponsive.isTablet(context)) {
      return isPortrait ? 84 : 264;
    }
    return 20;
  }

  double _getVerticalMargin(BuildContext context) {
    return FResponsive.isMobile(context) ? 20 : 24;
  }

  void show(GlobalKey<NavigatorState> overlayState) {
    final overlay = overlayState.currentState?.overlay;
    OverlayEntry? overlayEntry;

    if (overlay == null) {
      return;
    }

    overlayEntry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0.0, -50 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: onTap != null
                ? () {
                    onTap!();
                    overlayEntry?.remove();
                    overlayEntry = null;
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + _getVerticalMargin(context),
                left: _getHorizontalMargin(context),
                right: _getHorizontalMargin(context),
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FColors.of(context).alphaNormalAlpha7,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null && description == null)
                        Text(
                          title!,
                          style: FTextStyles.bodyL.m.copyWith(
                            color: FColors.of(context).inverseStrong,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (description != null && title == null)
                        Text(
                          description!,
                          style: FTextStyles.bodyL.r.copyWith(
                            color: FColors.of(context).inverseNormal,
                          ),
                        ),
                      if (title != null && description != null) ...[
                        Text(
                          title!,
                          style: FTextStyles.bodyL.b.copyWith(
                            color: FColors.of(context).inverseStrong,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Gap(2),
                        Text(
                          description!,
                          style: FTextStyles.bodyL.r.copyWith(
                            color: FColors.of(context).inverseNormal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
    Future.delayed(delay, () {
      overlayEntry?.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
