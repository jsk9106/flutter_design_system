import 'package:flutter_design_system/components/content_layout.dart';
import 'package:flutter_design_system/components/date_picker/f_date_picker.dart';
import 'package:flutter_design_system/extentions/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
// locale 의존도 제거

@widgetbook.UseCase(
  name: 'Date picker',
  type: FDatePicker,
  path: 'element/picker',
)
Widget fDatePickers(BuildContext context) {
  final DateTime eventDate = context.knobs.dateTime(
    label: 'Event Date',
    start: DateTime.now().subtract(const Duration(days: 365)),
    end: DateTime.now().add(const Duration(days: 365)),
    initialValue: DateTime.now(),
  );

  return ScrollConfiguration(
    behavior: CustomScrollBehavior(),
    child: Builder(
      builder: (context) {
        return _DatePicker(
          eventDate,
        );
      },
    ),
  );
}

class _DatePicker extends StatefulWidget {
  const _DatePicker(this.eventDate);

  final DateTime eventDate;

  @override
  State<_DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  DateTime focusedDay = DateTime.now();
  FCalendarFormat calendarFormat = FCalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ContentLayout(
        child: Column(
          children: [
            FDatePicker(
              focusedDay: focusedDay,
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              events: {
                widget.eventDate: const ['Event'],
              },
              isModal: false,
              onChangedDay: (datetime) {
                setState(() {
                  focusedDay = datetime;
                });
              },
              calendarFormat: calendarFormat,
              onFormatChanged: (fCalendarFormat) {
                setState(() {
                  calendarFormat = fCalendarFormat;
                });
              },
              useMultiLanguage: false,
            ),
            const Gap(32),
            const Expanded(
              child: Center(child: Text('패키지 이용해 구현한 위젯이라 세부 px 조정은 조율 필요')),
            ),
          ],
        ),
      ),
    );
  }
}
