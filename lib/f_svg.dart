import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG 이미지 위젯
/// [FSvg.asset]을 사용하면 asset 경로를, [FSvg.string]을 사용하면 SVG 문자열을 사용합니다.
/// [color]를 사용하면 이미지의 색상을 변경할 수 있습니다.
class FSvg extends StatelessWidget {
  final String iconString;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? package;

  const FSvg._(
    this.iconString, {
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.package,
  });

  factory FSvg.asset(
    final String path, {
    final Color? color,
    final double? width,
    final double? height,
    final BoxFit? fit,
    final String? package,
  }) =>
      FSvg._(
        path,
        color: color,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        package: package ?? 'design',
      );

  SvgPicture get toSvgPicture => SvgPicture.asset(
        iconString,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(
                color!,
                BlendMode.srcIn,
              ),
        width: width,
        height: height,
        fit: fit,
        package: kIsWeb ? null : package,
      );

  @override
  Widget build(BuildContext context) => toSvgPicture;
}
