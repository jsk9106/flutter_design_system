import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/time_picker/f_time_picker.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class FTimeSelectButton extends StatelessWidget {
  const FTimeSelectButton({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  final DateTime selectedDate;
  final Function(DateTime time) onSelected;

  String _formattedDateTime(BuildContext context) {
    return DateFormat(
      'a hh:mm',
      Localizations.localeOf(context).toString(),
    ).format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width - 48) / 2;
    return GestureDetector(
      onTap: () {
        FTimePickerBottomSheet.show(
          context,
          onConfirm: onSelected,
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: FColors.of(context).green.withValues(alpha: .08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FSvg.asset(
              Assets.iconsClock,
              width: 20,
              color: FColors.of(context).green,
            ),
            const Gap(4),
            Text(
              _formattedDateTime(context),
              style: FTextStyles.bodyL.copyWith(
                color: FColors.of(context).green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
