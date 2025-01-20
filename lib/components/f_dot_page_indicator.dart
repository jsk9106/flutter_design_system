import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';

/// dot 페이지 인디케이터의 크기 종류
enum FDotPageIndicatorSize { small, normal }

/// dot 페이지 인디케이터의 색상 종류
enum FDotPageIndicatorColor { white, black }

/// 현재 페이지 위치를 dot으로 표시하는 커스텀 가능한 페이지 인디케이터 위젯
class FDotPageIndicator extends StatelessWidget {
  /// 전체 아이템/페이지 수
  final int totalItems;

  /// 현재 선택된 인덱스 (0부터 시작)
  final int currentIndex;

  /// dot의 크기 종류
  final FDotPageIndicatorSize size;

  /// dot의 색상 종류
  final FDotPageIndicatorColor dotPageIndicatorColor;

  /// 한 번에 보여줄 최대 dot 개수
  static const int _maxPageToShow = 5;

  /// dot의 크기 상수
  static const Size _tinyDotSize = Size(4, 4);
  static const Size _smallDotSize = Size(6, 6);
  static const Size _normalDotSize = Size(8, 8);

  const FDotPageIndicator._({
    required this.totalItems,
    required this.currentIndex,
    required this.size,
    required this.dotPageIndicatorColor,
  });

  /// small 크기의 dot 페이지 인디케이터 생성
  factory FDotPageIndicator.small({
    required int totalItems,
    required int currentIndex,
    FDotPageIndicatorColor color = FDotPageIndicatorColor.black,
  }) {
    return FDotPageIndicator._(
      totalItems: totalItems,
      currentIndex: currentIndex,
      size: FDotPageIndicatorSize.small,
      dotPageIndicatorColor: color,
    );
  }

  /// normal 크기의 dot 페이지 인디케이터 생성
  factory FDotPageIndicator.normal({
    required int totalItems,
    required int currentIndex,
    FDotPageIndicatorColor color = FDotPageIndicatorColor.black,
  }) {
    return FDotPageIndicator._(
      totalItems: totalItems,
      currentIndex: currentIndex,
      size: FDotPageIndicatorSize.normal,
      dotPageIndicatorColor: color,
    );
  }

  /// 보여지는 dot들의 중간 인덱스 계산
  int get _halfIndex => _maxPageToShow ~/ 2;

  /// 현재 크기에 맞는 기본 dot 크기 반환
  Size _getNormalDotSize() {
    if (size == FDotPageIndicatorSize.small) {
      return Size(_normalDotSize.width - 2, _normalDotSize.height - 2);
    }
    return _normalDotSize;
  }

  /// 현재 크기에 맞는 작은 dot 크기 반환
  Size _getCurrentSmallDotSize() {
    if (size == FDotPageIndicatorSize.small) {
      return Size(_smallDotSize.width - 2, _smallDotSize.height - 2);
    }
    return _smallDotSize;
  }

  /// 현재 크기에 맞는 가장 작은 dot 크기 반환
  Size _getCurrentTinyDotSize() {
    if (size == FDotPageIndicatorSize.small) {
      return Size(_tinyDotSize.width - 2, _tinyDotSize.height - 2);
    }
    return _tinyDotSize;
  }

  /// 현재 인덱스에 따라 강조될 dot의 위치 결정
  int _getHighlightPage(int index) {
    if (totalItems <= _maxPageToShow) return currentIndex;

    if (currentIndex < _halfIndex) {
      return currentIndex;
    } else if (totalItems - currentIndex <= _halfIndex) {
      return _maxPageToShow - (totalItems - currentIndex);
    } else {
      return _halfIndex;
    }
  }

  /// 주어진 인덱스의 dot 크기 결정
  Size _getDotSize(int index, int highlightPage) {
    if (totalItems <= _maxPageToShow) return _getNormalDotSize();

    if (highlightPage > _maxPageToShow - 1 - _halfIndex) {
      if (index == 0) return _getCurrentTinyDotSize();
      if (index == 1) return _getCurrentSmallDotSize();
    }

    if (highlightPage < _halfIndex) {
      if (index == _maxPageToShow - 1) return _getCurrentTinyDotSize();
      if (index == _maxPageToShow - 2) return _getCurrentSmallDotSize();
    }

    if (highlightPage == _halfIndex) {
      if (index == 0 || index == _maxPageToShow - 1) return _getCurrentSmallDotSize();
    }

    return _getNormalDotSize();
  }

  /// dot의 상태에 따른 적절한 색상 반환
  Color _getDotColor(BuildContext context, bool isCurrentPage) {
    final baseColor =
        dotPageIndicatorColor == FDotPageIndicatorColor.white ? FColors.of(context).white : FColors.of(context).black;
    return baseColor.withValues(alpha: isCurrentPage ? 1 : 0.2);
  }

  @override
  Widget build(BuildContext context) {
    final int dotsToShow = totalItems > _maxPageToShow ? _maxPageToShow : totalItems;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotsToShow,
        (index) {
          final int highlightPage = _getHighlightPage(index);
          final bool isCurrentPage = highlightPage == index;
          final Size dotSize = _getDotSize(index, highlightPage);

          return AnimatedContainer(
            width: dotSize.width,
            height: dotSize.height,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getDotColor(context, isCurrentPage),
            ),
          );
        },
      ),
    );
  }
}
