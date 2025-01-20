import 'package:flutter/material.dart';

/// 콘텐츠 레이아웃 위젯
/// 기본 값은 [UiConstant.contentMaxWidth]입니다.
/// 커스텀 값은 [maxWidth]로 설정할 수 있습니다.
class ContentLayout extends StatelessWidget {
  const ContentLayout({
    super.key,
    this.maxWidth = 664.0,
    required this.child,
  });

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
