import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_bottom_sheet.dart';
import 'package:flutter_design_system/components/f_toast.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum BottomSheetType { basic, handler }

@widgetbook.UseCase(
  name: 'Bottom Sheet',
  type: FBottomSheet,
  path: 'element/dialog_using_dimmer',
)
Widget fBottomSheets(BuildContext context) {
  final sheetType = context.knobs.list(
    label: 'Bottom Sheet Type',
    options: BottomSheetType.values,
    initialOption: BottomSheetType.basic,
  );
  String? title = context.knobs.string(label: 'Title', initialValue: 'Title');
  bool useActionButton = context.knobs.boolean(label: 'Use Action Button', initialValue: true);
  bool useIcon = context.knobs.boolean(label: 'Use Icon Button', initialValue: false);
  bool isActionButtonDisabled = context.knobs.boolean(label: 'Action Button Disabled', initialValue: false);
  final contentCount = context.knobs.int.slider(
    label: 'Content Lines',
    initialValue: 5,
    min: 1,
    max: 10,
  );

  if (title.isEmpty) {
    title = null;
  }

  return Builder(builder: (context) {
    return OutlinedButton(
      child: Text('Show ${sheetType.name} Bottom Sheet'),
      onPressed: () {
        if (sheetType == BottomSheetType.basic) {
          FBottomSheet(
            title: title,
            item: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Center(child: Text('This is Sample Widget')),
            ),
            actionButton: useActionButton,
            showIcon: useIcon,
            onIconPressed: () {
              FToast(message: '아이콘 버튼 작동').show(context);
            },
            iconPath: Assets.svgPlus,
            actionButtonLabel: '확인',
            actionButtonDisabled: isActionButtonDisabled,
            onActionButtonPressed: () {
              FToast(message: '액션 버튼 작동').show(context);
            },
          ).show(context);
        } else {
          FBottomSheet.showWithHandler(
            context,
            contentBuilder: (isExpanded) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expanded: $isExpanded'),
                  const SizedBox(height: 20),
                  const Text('Drag this sheet up and down to test expansion.\n'
                      'Content will rebuild based on expansion state.'),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contentCount.toInt(),
                    itemBuilder: (context, index) => Text('Content line ${index + 1}'),
                  ),
                ],
              ),
            ),
            initialHeight: 0.5,
            enableDrag: true,
          );
        }
      },
    );
  });
}
