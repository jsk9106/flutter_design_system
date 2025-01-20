import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_solid_button.dart';
import 'package:flutter_design_system/extentions/context_extension.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:gap/gap.dart';

class FMonthPicker extends StatefulWidget {
  const FMonthPicker({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    required this.onSelectedMonth,
    required this.onCanceled,
    this.useMultiLanguage = true,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final Function(DateTime day) onSelectedMonth;
  final GestureTapCallback onCanceled;
  final bool useMultiLanguage;

  @override
  State<FMonthPicker> createState() => FMonthPickerState();
}

class FMonthPickerState extends State<FMonthPicker> {
  late final PageController _pageController =
      PageController(initialPage: widget.focusedDay.year - widget.firstDay.year);
  late DateTime _selectedDay = widget.focusedDay;
  final Duration duration = const Duration(milliseconds: 300);
  final Curve curve = Curves.ease;

  /// 보여지는 년도
  int get _currentYear {
    try {
      return widget.firstDay.year + _pageController.page!.round();
    } catch (e) {
      return _selectedDay.year;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  /// 달 선택
  void _onTapMonth(DateTime date) {
    _selectedDay = date;
    setState(() {});
  }

  /// 이전 페이지
  void _onPreviousPage() {
    _pageController.previousPage(
      duration: duration,
      curve: curve,
    );
  }

  /// 다음 페이지
  void _onNextPage() {
    _pageController.nextPage(
      duration: duration,
      curve: curve,
    );
  }

  /// 페이지 변경
  void onPageChanged(int index) {
    DateTime date = DateTime(_currentYear, _selectedDay.month);

    if (date.isBefore(widget.firstDay)) {
      date = DateTime(date.year, widget.firstDay.month);
    } else if (date.isAfter(widget.lastDay)) {
      date = DateTime(date.year, widget.lastDay.month);
    }

    _selectedDay = date;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _appBar(),
        const Gap(12),
        _yearPicker(),
        const Gap(16),
        _month(),
        const Gap(32),
        FSolidButton.primary(
          text: widget.useMultiLanguage ? context.localeString.c_ui_public_bt_confirm : '확인',
          size: FSolidButtonSize.large,
          onPressed: () => widget.onSelectedMonth(_selectedDay),
        ),
        const Gap(4),
      ],
    );
  }

  Widget _month() {
    return AspectRatio(
      aspectRatio: 1.36,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.lastDay.year - widget.firstDay.year + 1,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final DateTime date = DateTime(_currentYear, index + 1);
              final bool isSelectedDay = _selectedDay.month == date.month;
              final bool isDisabled =
                  DateTime(_currentYear, index + 2, 0).isBefore(widget.firstDay) || date.isAfter(widget.lastDay);

              return GestureDetector(
                onTap: isDisabled ? null : () => _onTapMonth(DateTime(_selectedDay.year, date.month, _selectedDay.day)),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelectedDay ? FColors.of(context).solidStrong : null,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.useMultiLanguage
                        ? context.localeString.c_ui_public_mm.format(index + 1)
                        : '{0}월'.format(index + 1),
                    style: FTextStyles.titleS.copyWith(
                      color: isDisabled
                          ? FColors.of(context).labelAlternative
                          : isSelectedDay
                              ? FColors.of(context).inverseStrong
                              : FColors.of(context).labelNormal,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _yearPicker() {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: _currentYear <= widget.firstDay.year ? null : _onPreviousPage,
            child: FSvg.asset(
              Assets.iconsChevronsChevronLeftThick,
              color: _currentYear <= widget.firstDay.year
                  ? FColors.of(context).labelDisable
                  : FColors.of(context).labelAlternative,
              width: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Text(
              widget.useMultiLanguage
                  ? context.localeString.c_ui_public_yyyy.format(_currentYear)
                  : '{0}년'.format(_currentYear),
              style: FTextStyles.bodyXL.copyWith(color: FColors.of(context).labelNormal),
            ),
          ),
          InkWell(
            onTap: _currentYear >= widget.lastDay.year ? null : _onNextPage,
            child: FSvg.asset(
              Assets.iconsChevronsChevronRightThick,
              color: _currentYear >= widget.lastDay.year
                  ? FColors.of(context).labelDisable
                  : FColors.of(context).labelAlternative,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: InkWell(
              onTap: widget.onCanceled,
              child: FSvg.asset(
                Assets.iconsNormalCloseNormalThin,
                width: 24,
                color: FColors.of(context).labelNormal,
              ),
            ),
          ),
          Text(
            widget.useMultiLanguage ? context.localeString.c_ui_public_data_picker_title : '월 선택',
            style: FTextStyles.bodyXL.copyWith(color: FColors.of(context).labelNormal),
          ),
        ],
      ),
    );
  }
}
