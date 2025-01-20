import 'package:flutter_design_system/components/f_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

//context를 option으로 받는 것 수정
// tooltip 위치 이상함
// tooltip 화살표 위치 반응형 안됨
// show barrier같은 불필요한 옵션 제거

@widgetbook.UseCase(
  name: 'Tooltip',
  type: FTooltip,
  path: 'element/dialog',
)
Widget fTooltips(BuildContext context) {
  String size = context.knobs.list(label: 'Size', options: ['Normal', 'Small'], initialOption: 'Normal');
  String? title = context.knobs.string(label: 'Title', initialValue: 'Title');
  String description = context.knobs.string(label: 'Description', initialValue: 'Description');
  double targetWidgetX = context.knobs.double
      .slider(label: 'Target Widget X', min: 0, max: MediaQuery.of(context).size.width - 200, initialValue: 50);
  double targetWidgetY = context.knobs.double
      .slider(label: 'Target Widget Y', min: 0, max: MediaQuery.of(context).size.height - 100, initialValue: 50);
  if (title.isEmpty) {
    title = null;
  }
  SuperTooltipController controller = SuperTooltipController();

  return Stack(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      Positioned(
        left: targetWidgetX,
        top: targetWidgetY,
        child: Builder(builder: (context) {
          if (size == 'Normal') {
            return FTooltip.normal(
              context: context,
              title: title ?? '',
              description: description,
              controller: controller,
              targetWidget: OutlinedButton(
                onPressed: () {
                  if (controller.isVisible) {
                    controller.hideTooltip();
                  } else {
                    controller.showTooltip();
                  }
                },
                child: const Text('웹에서 적용 안됨'),
              ),
            );
          }
          if (size == 'Small') {
            return FTooltip.small(
              context: context,
              description: description,
              controller: controller,
              targetWidget: OutlinedButton(
                onPressed: () {
                  if (controller.isVisible) {
                    controller.hideTooltip();
                  } else {
                    controller.showTooltip();
                  }
                },
                child: const Text('웹에서 적용 안됨'),
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    ],
  );
}
