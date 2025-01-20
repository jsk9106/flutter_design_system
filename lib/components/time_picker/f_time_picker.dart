import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_solid_button.dart';
import 'package:flutter_design_system/components/time_picker/time_picker_spinner.dart';
import 'package:flutter_design_system/extentions/context_extension.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FTimePicker extends StatelessWidget {
  const FTimePicker({
    super.key,
    this.onTimeChange,
    this.onConfirm,
    this.useMultiLanguage = true,
  });

  final Function(DateTime)? onTimeChange;
  final Function? onConfirm;
  final bool useMultiLanguage;

  @override
  Widget build(BuildContext context) {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: FTextStyles.titleS.r.copyWith(color: FColors.of(context).labelAssistive),
      highlightedTextStyle: FTextStyles.titleS.m.copyWith(color: FColors.of(context).labelStrong),
      spacing: 16,
      itemHeight: 58,
      itemWidth: 80,
      alignment: Alignment.center,
      isForce2Digits: true,
      onTimeChange: onTimeChange,
      useMultiLanguage: useMultiLanguage,
    );
  }
}

class FTimePickerBottomSheet extends StatefulWidget {
  final Function(DateTime)? onConfirm;
  final String confirmText;
  final bool useMultiLanguage;

  const FTimePickerBottomSheet({
    super.key,
    this.onConfirm,
    this.confirmText = '확인',
    this.useMultiLanguage = true,
  });

  @override
  State<FTimePickerBottomSheet> createState() => _FTimePickerBottomSheetState();

  static Future<DateTime?> show(
    BuildContext context, {
    String confirmText = '확인',
    Function(DateTime)? onConfirm,
    bool useMultiLanguage = true,
  }) {
    return showModalBottomSheet<DateTime?>(
      context: context,
      builder: (context) => FTimePickerBottomSheet(
        confirmText: confirmText,
        onConfirm: onConfirm,
        useMultiLanguage: useMultiLanguage,
      ),
    );
  }
}

class _FTimePickerBottomSheetState extends State<FTimePickerBottomSheet> {
  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: FColors.of(context).backgroundElevatedNormal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: FSvg.asset(
                      Assets.iconsNormalCloseNormalThin,
                      width: 24,
                      color: FColors.of(context).labelNormal,
                    ),
                  ),
                  Text(
                    widget.useMultiLanguage ? context.localeString.c_ui_public_time_select : '시간 선택',
                    style: FTextStyles.bodyXL.m.copyWith(color: FColors.of(context).labelNormal),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
            const Gap(12),
            FTimePicker(
              onTimeChange: (time) {
                _time = time;
              },
              useMultiLanguage: widget.useMultiLanguage,
            ),
            const Gap(16),
            FSolidButton.primary(
              size: FSolidButtonSize.large,
              text: widget.confirmText,
              onPressed: () {
                widget.onConfirm?.call(_time!);
              },
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
