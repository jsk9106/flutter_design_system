import 'dart:ui';

import 'package:flutter_design_system/components/f_responsive.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FSnackbar {
  FSnackbar({
    this.prefixPath,
    this.actionLabel,
    this.title,
    this.description,
    this.isBanner = false,
    this.onPressedAction,
  }) : assert(
          title != null || description != null,
          'title과 decription중 하나는 사용해 주세요',
        );

  final String? prefixPath;
  final String? actionLabel;
  final VoidCallback? onPressedAction;
  final String? title;
  final String? description;
  final bool isBanner;

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

  void show(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(snackBar(context));

  SnackBar snackBar(BuildContext context) {
    return SnackBar(
      duration: isBanner ? const Duration(days: 999) : const Duration(seconds: 3),
      backgroundColor: Colors.transparent, // 배경색을 투명하게 설정
      padding: EdgeInsets.zero, // 패딩을 0으로 설정하고 내부 Container에서 처리
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
        horizontal: _getHorizontalMargin(context),
        vertical: _getVerticalMargin(context),
      ),
      content: ClipRRect(
        // 블러 효과가 컨테이너 밖으로 넘치지 않도록 설정
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50), // 블러 강도 설정
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: FColors.of(context).alphaNormalAlpha7,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                if (prefixPath != null) ...[
                  FSvg.asset(
                    prefixPath!,
                    width: 20,
                    color: FColors.of(context).inverseAlternative,
                  ),
                  const Gap(8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null && description == null)
                        Text(
                          title!,
                          style: FTextStyles.bodyL.r.copyWith(
                            color: FColors.of(context).inverseAlternative,
                          ),
                          maxLines: 1,
                        ),
                      if (description != null && title == null)
                        Text(
                          description!,
                          style: FTextStyles.bodyL.r.copyWith(
                            color: FColors.of(context).labelAssistive,
                          ),
                          maxLines: 2,
                        ),
                      if (title != null && description != null) ...[
                        Text(
                          title!,
                          style: FTextStyles.bodyL.m.copyWith(
                            color: FColors.of(context).inverseAlternative,
                          ),
                          maxLines: 1,
                        ),
                        const Gap(2),
                        Text(
                          description!,
                          style: FTextStyles.bodyL.r.copyWith(
                            color: FColors.of(context).labelAssistive,
                          ),
                          maxLines: 2,
                        ),
                      ]
                    ],
                  ),
                ),
                if (actionLabel != null) ...[
                  const Gap(6),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (onPressedAction != null) onPressedAction!();
                    },
                    child: Text(
                      actionLabel!,
                      style: FTextStyles.bodyL.b.copyWith(
                        color: FColors.of(context).inverseNormal,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
