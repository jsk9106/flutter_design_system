import 'package:flutter_design_system/extentions/number_extension.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FProgressBarSegmented extends StatelessWidget {
  final List<SegmentValue> segment;
  final TextStyle? legendTextStyle;
  final TextStyle? valueTextStyle;
  final TextStyle? unitTextStyle;

  const FProgressBarSegmented({
    super.key,
    required this.segment,
    this.legendTextStyle,
    this.valueTextStyle,
    this.unitTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    double totalValue = segment.fold(0, (sum, item) => sum + item.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 범례
        SingleChildScrollView(
          // 가로 스크롤 가능하도록 변경
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: segment
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: category.color,
                        ),
                        const SizedBox(width: 6),
                        FittedBox(
                          fit: BoxFit.scaleDown, // 텍스트가 공간을 초과하지 않도록 축소
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${category.name} ',
                                  style: legendTextStyle ??
                                      FTextStyles.bodyM.r.copyWith(
                                        color: FColors.of(context).labelNeutral,
                                      ),
                                ),
                                TextSpan(
                                  text: '${category.value.round()}',
                                  style: valueTextStyle ??
                                      FTextStyles.bodyM.m.copyWith(
                                        color: FColors.of(context).labelNeutral,
                                      ),
                                ),
                                TextSpan(
                                  text: category.unit ?? '',
                                  style: unitTextStyle ??
                                      FTextStyles.bodyM.m.copyWith(
                                        color: FColors.of(context).labelNeutral,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 10),
        // 프로그레스바
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Row(
            children: segment.where((category) => category.value > 0).map((category) {
              double percentage = (category.value / totalValue) * 100;
              return Expanded(
                flex: (percentage * 100).toInt(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 20,
                  color: category.color,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${percentage.toCleanString(0)}%',
                      style: FTextStyles.bodyXS.b.copyWith(color: FColors.of(context).white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SegmentValue {
  final String name;
  final double value;
  final Color color;
  final String? unit;

  SegmentValue({
    required this.name,
    required this.value,
    required this.color,
    this.unit,
  });
}
