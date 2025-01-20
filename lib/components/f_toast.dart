import 'dart:developer';

import 'package:flutter_design_system/components/f_responsive.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;

class FToast {
  String message;
  String? prefixPath;
  final ftoast = fluttertoast.FToast();

  FToast({
    required this.message,
    this.prefixPath,
  });

  void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        ftoast.init(context);
        ftoast.showToast(
          child: toast(context),
          gravity: fluttertoast.ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 3),
          positionedToastBuilder: (context, child) {
            final bool isTablet = FResponsive.isTablet(context);
            return Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom + (isTablet ? 24 : 20),
              left: 20.0,
              right: 20.0,
              child: child,
            );
          },
        );
      } catch (e) {
        log(e.toString());
      }
    });
  }

  Widget toast(context) {
    final bool isTablet = FResponsive.isTablet(context);

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        constraints: BoxConstraints(maxWidth: isTablet ? 458 : 350),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: FColors.of(context).solidStrong.withValues(alpha: .9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (prefixPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: FSvg.asset(
                  prefixPath!,
                  width: 20,
                  color: FColors.of(context).inverseAlternative,
                ),
              ),
            Expanded(
              child: Text(
                message,
                style: FTextStyles.bodyL.r.copyWith(
                  color: FColors.of(context).inverseAlternative,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
