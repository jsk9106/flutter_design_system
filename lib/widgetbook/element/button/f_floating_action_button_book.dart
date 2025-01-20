import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/components/f_floating_action_button.dart';
import 'package:flutter_design_system/components/f_toast.dart';
import 'package:flutter_design_system/extentions/custom_scroll_behavior.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Floating Action Button',
  type: FFloatingActionButton,
  path: 'element/button',
)
Widget fFloatingActionButton(BuildContext context) {
  return Builder(
    builder: (context) {
      bool disabled = context.knobs.boolean(
        label: 'Disabled',
        initialValue: false,
      );

      String type = context.knobs.list(
        label: 'Type',
        options: ['Normal', 'Accent', 'Subtle'],
        initialOption: 'Normal',
      );

      String label = context.knobs.string(
        label: 'Label',
        initialValue: '기록하기',
      );

      return ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: _ScrollableScaffold(
          type: type,
          label: label,
          disabled: disabled,
        ),
      );
    },
  );
}

class _ScrollableScaffold extends StatefulWidget {
  final String type;
  final String label;
  final bool disabled;

  const _ScrollableScaffold({
    required this.type,
    required this.label,
    required this.disabled,
  });

  @override
  State<_ScrollableScaffold> createState() => _ScrollableScaffoldState();
}

class _ScrollableScaffoldState extends State<_ScrollableScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  Widget _buildFAB() {
    if (widget.type == 'Normal') {
      // Normal 타입에서는 아이콘과 텍스트 색상만 변경 가능
      String textColorOption = context.knobs.list(
        label: 'Text Color',
        options: ['Default', 'Red', 'Orange', 'Blue'],
        initialOption: 'Default',
      );

      Color? textColor;
      switch (textColorOption) {
        case 'Red':
          textColor = Colors.red;
          break;
        case 'Orange':
          textColor = Colors.orange;
          break;
        case 'Blue':
          textColor = Colors.blue;
          break;
        default:
          textColor = null;
      }

      String iconColorOption = context.knobs.list(
        label: 'Icon Color',
        options: ['Default', 'Red', 'Orange', 'Blue'],
        initialOption: 'Default',
      );

      Color? iconColor;
      switch (iconColorOption) {
        case 'Red':
          iconColor = Colors.red;
          break;
        case 'Orange':
          iconColor = Colors.orange;
          break;
        case 'Blue':
          iconColor = Colors.blue;
          break;
        default:
          iconColor = null;
      }

      return FFloatingActionButton.normal(
        disabled: widget.disabled,
        onTap: () {
          FToast(message: '기록하기 버튼을 눌렀습니다.').show(context);
        },
        isScrolled: _isScrolled,
        label: widget.label,
        iconPath: Assets.iconsPencil,
        iconColor: iconColor,
        textColor: textColor,
      );
    }

    if (widget.type == 'Accent') {
      // Accent 타입에서는 배경색을 선택할 수 있게 함
      String colorOption = context.knobs.list(
        label: 'Background Color',
        options: ['Red', 'Orange'],
        initialOption: 'Red',
      );
      String textColorOption = context.knobs.list(
        label: 'Text Color',
        options: ['Default', 'Red', 'Orange', 'Blue'],
        initialOption: 'Default',
      );

      Color? textColor;
      switch (textColorOption) {
        case 'Red':
          textColor = Colors.red;
          break;
        case 'Orange':
          textColor = Colors.orange;
          break;
        case 'Blue':
          textColor = Colors.blue;
          break;
        default:
          textColor = null;
      }
      String iconColorOption = context.knobs.list(
        label: 'Icon Color',
        options: ['Default', 'Red', 'Orange', 'Blue'],
        initialOption: 'Default',
      );
      Color? iconColor;
      switch (iconColorOption) {
        case 'Red':
          iconColor = Colors.red;
          break;
        case 'Orange':
          iconColor = Colors.orange;
          break;
        case 'Blue':
          iconColor = Colors.blue;
          break;
        default:
          iconColor = null;
      }

      Color backgroundColor;
      switch (colorOption) {
        case 'Orange':
          backgroundColor = FColors.of(context).fiet;
          break;
        case 'Red':
        default:
          backgroundColor = FColors.of(context).statusNegative;
      }

      return FFloatingActionButton.accent(
        onTap: () {
          FToast(message: '기록하기 버튼을 눌렀습니다.').show(context);
        },
        disabled: widget.disabled,
        isScrolled: _isScrolled,
        label: widget.label,
        iconPath: Assets.iconsPencil,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        textColor: textColor,
      );
    }

    return FFloatingActionButton.subtle(
      onTap: () {},
      isScrolled: _isScrolled,
      label: widget.label,
      iconPath: Assets.iconsPencil,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button Demo'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 2,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Scroll to see FAB change (${50 - index} items remaining)',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
