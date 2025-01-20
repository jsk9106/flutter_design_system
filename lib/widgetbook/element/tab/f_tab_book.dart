import 'package:flutter_design_system/components/f_tab.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// default일 때 scrollable 하도록 설정 필요

@widgetbook.UseCase(
  name: 'page indicator',
  type: FTab,
  path: 'element/tab',
)
Widget fTabs(BuildContext context) {
  int max = context.knobs.int.slider(
    label: 'Max',
    // Switch 탭은 2-4개만 허용되므로 max를 4로 제한
    min: 2,
    max: 4,
    initialValue: 2,
  );

  String type = context.knobs.list(
      label: 'Type',
      options: [
        'Default',
        'Fixed',
        'Capsule/normal',
        'Capsule/small',
        'Switch/round', // Switch 옵션 추가
        'Switch/square', // Switch 옵션 추가
      ],
      initialOption: 'Default');

  return FTabs(
    max: max,
    type: type,
  );
}

class FTabs extends StatefulWidget {
  const FTabs({
    super.key,
    this.type = 'Default',
    this.max = 2,
  });

  final String type;
  final int max;

  @override
  State<FTabs> createState() => _FTabsState();
}

class _FTabsState extends State<FTabs> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    // 탭 리스트 미리 생성
    final List<SwitchTabValue> switchTabList = List.generate(
      widget.max,
      (i) => SwitchTabValue(text: 'Tab $i'),
    );

    final List<String> regularTabList = List.generate(
      widget.max,
      (i) => 'Tab $i',
    );

    // Switch 탭 타입 체크 및 반환
    switch (widget.type) {
      case 'Switch/round':
        return SizedBox(
          width: 350,
          height: 52,
          child: FTab.switchTab(
            currentIndex: current,
            tabList: switchTabList,
            switchTabType: SwitchTabType.round,
            onChangedTap: (index) => setState(() => current = index),
          ),
        );

      case 'Switch/square':
        return SizedBox(
          width: 350,
          height: 48,
          child: FTab.switchTab(
            currentIndex: current,
            tabList: switchTabList,
            switchTabType: SwitchTabType.square,
            onChangedTap: (index) => setState(() => current = index),
          ),
        );

      case 'Default':
        return FTab.defaultTab(
          currentIndex: current,
          tabList: regularTabList,
          onChangedTap: (index) => setState(() => current = index),
        );

      case 'Fixed':
        return FTab.fixedTab(
          currentIndex: current,
          tabList: regularTabList,
          onChangedTap: (index) => setState(() => current = index),
        );

      case 'Capsule/normal':
        return FTab.capsuleTab(
          size: CapsuleTapSize.normal,
          currentIndex: current,
          tabList: regularTabList,
          onChangedTap: (index) => setState(() => current = index),
        );

      case 'Capsule/small':
        return FTab.capsuleTab(
          size: CapsuleTapSize.small,
          currentIndex: current,
          tabList: regularTabList,
          onChangedTap: (index) => setState(() => current = index),
        );

      default:
        return const SizedBox();
    }
  }
}
