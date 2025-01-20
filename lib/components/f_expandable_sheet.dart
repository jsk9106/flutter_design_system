import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// FBottomSheet.withHandler로 대체됨
class FExpandableSheet extends StatefulWidget {
  final Widget Function(bool isExpanded) contentBuilder;
  final Widget? Function(BuildContext)? bottomBuilder;
  final double initialHeight;
  final bool enableDrag;
  final bool useRootNavigator;

  const FExpandableSheet({
    super.key,
    required this.contentBuilder,
    this.bottomBuilder,
    this.initialHeight = 0.5, // 전체 화면의 50%
    this.enableDrag = true,
    this.useRootNavigator = false,
  });

  @override
  _FExpandableSheetState createState() => _FExpandableSheetState();

  static void show(
    BuildContext context, {
    double initialHeight = 0.5,
    bool enableDrag = true,
    bool useRootNavigator = false,
    required Widget Function(bool isExpanded) contentBuilder,
    Widget? Function(BuildContext)? bottomBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return FExpandableSheet(
          initialHeight: initialHeight,
          enableDrag: enableDrag,
          useRootNavigator: useRootNavigator,
          contentBuilder: contentBuilder,
          bottomBuilder: bottomBuilder,
        );
      },
    ).then(
      (value) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

class _FExpandableSheetState extends State<FExpandableSheet> {
  final _maxHeight = 0.9;
  late double _currentHeight = widget.initialHeight;
  bool _isExpanded = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(updateScrollPixel);
    super.initState();
  }

  void updateScrollPixel() {
    if (_scrollController == null) return;
    if (_scrollController!.position.pixels <= -25 && _isExpanded) {
      setState(() {
        _currentHeight = widget.initialHeight;
        _isExpanded = false;
      });
      return;
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(updateScrollPixel);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      onVerticalDragUpdate: (details) {
        if (widget.enableDrag) {
          setState(() {
            _currentHeight -= details.primaryDelta! / MediaQuery.of(context).size.height;
            _currentHeight = _currentHeight.clamp(0.1, _maxHeight);
          });
        }
      },
      onVerticalDragEnd: (details) {
        if (widget.enableDrag) {
          if (_currentHeight <= 0.2) {
            Navigator.of(context).pop();
          } else if (_currentHeight < widget.initialHeight) {
            setState(() {
              _currentHeight = widget.initialHeight;
              _isExpanded = false;
            });
          } else if (_currentHeight > widget.initialHeight) {
            setState(() {
              _currentHeight = _maxHeight; // 최대 높이로 확장
              _isExpanded = true;
            });
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * _currentHeight,
        decoration: BoxDecoration(
          color: FColors.of(context).backgroundElevatedNormal,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          children: [
            if (widget.enableDrag) ...[
              _buildDragHandler(),
            ],
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast,
                ),
                controller: _scrollController,
                child: widget.contentBuilder(_isExpanded),
              ),
            ),
            if (widget.bottomBuilder != null) ...[widget.bottomBuilder!(context)!],
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandler() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: 30.0,
      height: 3.0,
      decoration: BoxDecoration(
        color: FColors.of(context).solidAlternative,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
