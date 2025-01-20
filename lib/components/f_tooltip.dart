import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:super_tooltip/super_tooltip.dart';

enum FTooltipSize { normal, small }

class FTooltip extends SuperTooltip {
  FTooltip._({
    required BuildContext context,
    required SuperTooltipController controller,
    String? title,
    TooltipDirection? popupDirection,
    required String description,
    required Widget targetWidget,
    required FTooltipSize size,
  }) : super(
          controller: controller,
          barrierColor: Colors.transparent,
          popupDirection: popupDirection ?? TooltipDirection.up,
          backgroundColor: FColors.of(context).solidStrong,
          hasShadow: false,
          arrowLength: size == FTooltipSize.normal ? 7 : 5,
          arrowBaseWidth: size == FTooltipSize.normal ? 14 : 10,
          arrowTipDistance: size == FTooltipSize.normal ? 12 : 8,
          borderRadius: 4,
          content: size == FTooltipSize.normal
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyles.bodyM.b.copyWith(color: FColors.of(context).inverseAlternative),
                      ),
                    ),
                    const Gap(4),
                    Flexible(
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyles.bodyS.r.copyWith(color: FColors.of(context).inverseNormal),
                      ),
                    ),
                  ],
                )
              : Text(
                  description,
                  style: FTextStyles.bodyS.r.copyWith(color: FColors.of(context).inverseNormal),
                ),
          child: targetWidget,
        );

  factory FTooltip.normal({
    required BuildContext context,
    required SuperTooltipController controller,
    required String title,
    required String description,
    required Widget targetWidget,
    TooltipDirection? popupDirection,
  }) {
    return FTooltip._(
      context: context,
      controller: controller,
      title: title,
      description: description,
      targetWidget: targetWidget,
      size: FTooltipSize.normal,
      popupDirection: popupDirection,
    );
  }

  factory FTooltip.small({
    required BuildContext context,
    required SuperTooltipController controller,
    VoidCallback? onShow,
    VoidCallback? onHide,
    required String description,
    required Widget targetWidget,
    TooltipDirection? popupDirection,
  }) {
    return FTooltip._(
      context: context,
      controller: controller,
      description: description,
      targetWidget: targetWidget,
      size: FTooltipSize.small,
      popupDirection: popupDirection,
    );
  }
}
