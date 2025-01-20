import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Semetic Colors',
  type: FColors,
  path: 'foundation/colors',
)
Widget fColors(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        titleWidget(
          'BackGround',
          [
            fColorContainer('Normal\nNormal', FColors.of(context).backgroundNormalN),
            fColorContainer('Normal\nAlternative', FColors.of(context).backgroundNormalA),
            fColorContainer('Alternative\nNormal', FColors.of(context).backgroundAlternativeN),
            fColorContainer('Alternative\nAlternative', FColors.of(context).backgroundAlternativeA),
          ],
        ),
        titleWidget(
          'Label',
          [
            fColorContainer('Strong', FColors.of(context).labelStrong),
            fColorContainer('Normal', FColors.of(context).labelNormal),
            fColorContainer('Neutral', FColors.of(context).labelNeutral),
            fColorContainer('Alternative', FColors.of(context).labelAlternative),
            fColorContainer('Assisive', FColors.of(context).labelAssistive),
            fColorContainer('Disable', FColors.of(context).labelDisable),
          ],
        ),
        titleWidget(
          'Solid',
          [
            fColorContainer('Strong', FColors.of(context).solidStrong),
            fColorContainer('Normal', FColors.of(context).solidNormal),
            fColorContainer('Neutral', FColors.of(context).solidNeutral),
            fColorContainer('Alternative', FColors.of(context).solidAlternative),
            fColorContainer('Assisive', FColors.of(context).solidAssistive),
            fColorContainer('Disable', FColors.of(context).solidDisable),
          ],
        ),
        titleWidget(
          'Line',
          [
            fColorContainer('Strong', FColors.of(context).lineStrong),
            fColorContainer('Normal', FColors.of(context).lineNormal),
            fColorContainer('Neutral', FColors.of(context).lineNeutral),
            fColorContainer('Alternative', FColors.of(context).lineAlternative),
            fColorContainer('Assisive', FColors.of(context).lineAssistive),
            fColorContainer('Subtle', FColors.of(context).lineSubtle),
          ],
        ),
        titleWidget(
          'Alpha-Invers',
          [
            fColorContainer('Alpha 0', FColors.of(context).black.withValues(alpha: 0)),
            fColorContainer('Alpha 1', FColors.of(context).black.withValues(alpha: 0.1)),
            fColorContainer('Alpha 2', FColors.of(context).black.withValues(alpha: 0.2)),
            fColorContainer('Alpha 3', FColors.of(context).black.withValues(alpha: 0.3)),
            fColorContainer('Alpha 4', FColors.of(context).black.withValues(alpha: 0.4)),
            fColorContainer('Alpha 5', FColors.of(context).black.withValues(alpha: 0.5)),
            fColorContainer('Alpha 6', FColors.of(context).black.withValues(alpha: 0.6)),
            fColorContainer('Alpha 7', FColors.of(context).black.withValues(alpha: 0.7)),
            fColorContainer('Alpha 8', FColors.of(context).black.withValues(alpha: 0.8)),
            fColorContainer('Alpha 9', FColors.of(context).black.withValues(alpha: 0.9)),
            fColorContainer('Alpha 10', FColors.of(context).black.withValues(alpha: 1)),
          ],
        ),
        titleWidget(
          'Alpha-Normal',
          [
            fColorContainer('Alpha 0', FColors.of(context).white.withValues(alpha: 0)),
            fColorContainer('Alpha 1', FColors.of(context).white.withValues(alpha: 0.1)),
            fColorContainer('Alpha 2', FColors.of(context).white.withValues(alpha: 0.2)),
            fColorContainer('Alpha 3', FColors.of(context).white.withValues(alpha: 0.3)),
            fColorContainer('Alpha 4', FColors.of(context).white.withValues(alpha: 0.4)),
            fColorContainer('Alpha 5', FColors.of(context).white.withValues(alpha: 0.5)),
            fColorContainer('Alpha 6', FColors.of(context).white.withValues(alpha: 0.6)),
            fColorContainer('Alpha 7', FColors.of(context).white.withValues(alpha: 0.7)),
            fColorContainer('Alpha 8', FColors.of(context).white.withValues(alpha: 0.8)),
            fColorContainer('Alpha 9', FColors.of(context).white.withValues(alpha: 0.9)),
            fColorContainer('Alpha 10', FColors.of(context).white.withValues(alpha: 1)),
          ],
        ),
        titleWidget(
          'Alpha-Static-White',
          [
            fColorContainer('Alpha 0', FColors.of(context).white.withValues(alpha: 0)),
            fColorContainer('Alpha 1', FColors.of(context).white.withValues(alpha: 0.1)),
            fColorContainer('Alpha 2', FColors.of(context).white.withValues(alpha: 0.2)),
            fColorContainer('Alpha 3', FColors.of(context).white.withValues(alpha: 0.3)),
            fColorContainer('Alpha 4', FColors.of(context).white.withValues(alpha: 0.4)),
            fColorContainer('Alpha 5', FColors.of(context).white.withValues(alpha: 0.5)),
            fColorContainer('Alpha 6', FColors.of(context).white.withValues(alpha: 0.6)),
            fColorContainer('Alpha 7', FColors.of(context).white.withValues(alpha: 0.7)),
            fColorContainer('Alpha 8', FColors.of(context).white.withValues(alpha: 0.8)),
            fColorContainer('Alpha 9', FColors.of(context).white.withValues(alpha: 0.9)),
            fColorContainer('Alpha 10', FColors.of(context).white.withValues(alpha: 1)),
          ],
        ),
        titleWidget(
          'Alpha-Static-Black',
          [
            fColorContainer('Alpha 0', FColors.of(context).black.withValues(alpha: 0)),
            fColorContainer('Alpha 1', FColors.of(context).black.withValues(alpha: 0.1)),
            fColorContainer('Alpha 2', FColors.of(context).black.withValues(alpha: 0.2)),
            fColorContainer('Alpha 3', FColors.of(context).black.withValues(alpha: 0.3)),
            fColorContainer('Alpha 4', FColors.of(context).black.withValues(alpha: 0.4)),
            fColorContainer('Alpha 5', FColors.of(context).black.withValues(alpha: 0.5)),
            fColorContainer('Alpha 6', FColors.of(context).black.withValues(alpha: 0.6)),
            fColorContainer('Alpha 7', FColors.of(context).black.withValues(alpha: 0.7)),
            fColorContainer('Alpha 8', FColors.of(context).black.withValues(alpha: 0.8)),
            fColorContainer('Alpha 9', FColors.of(context).black.withValues(alpha: 0.9)),
            fColorContainer('Alpha 10', FColors.of(context).black.withValues(alpha: 1)),
          ],
        ),
        titleWidget(
          'Status',
          [
            fColorContainer('Positive', FColors.of(context).statusPositive),
            fColorContainer('Cautionary', FColors.of(context).statusCautionary),
            fColorContainer('Negative', FColors.of(context).statusNegative),
          ],
        ),
        titleWidget(
          'Color',
          [
            fColorContainer('Red', FColors.of(context).colorRed),
            fColorContainer('Orange', FColors.of(context).colorOrange),
            fColorContainer('Yellow', FColors.of(context).colorYellow),
            fColorContainer('Lime', FColors.of(context).colorLime),
            fColorContainer('Green', FColors.of(context).colorGreen),
            fColorContainer('Sky', FColors.of(context).colorSky),
            fColorContainer('Blue', FColors.of(context).colorBlue),
            fColorContainer('Violet', FColors.of(context).colorViolet),
            fColorContainer('Purple', FColors.of(context).colorPurple),
          ],
        ),
        titleWidget(
          'Static',
          [
            fColorContainer('White', FColors.of(context).white),
            fColorContainer('Black', FColors.of(context).black),
          ],
        ),
        titleWidget(
          'Inverse',
          [
            fColorContainer('Strong', FColors.of(context).inverseStrong),
            fColorContainer('Normal', FColors.of(context).inverseNormal),
            fColorContainer('Alternative', FColors.of(context).inverseAlternative),
            fColorContainer('Assistive', FColors.of(context).inverseAssistive),
            fColorContainer('Subtle', FColors.of(context).inverseSubtle),
          ],
        ),
      ],
    ),
  );
}

Widget titleWidget(String title, List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
            padding: const EdgeInsets.all(0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 3 / 4,
            ),
            shrinkWrap: true,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            })
      ],
    ),
  );
}

Widget fColorContainer(String name, Color color) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 0.4,
            ),
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
          width: 80,
          height: 80,
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(name, style: const TextStyle(fontSize: 9)),
        ),
      ],
    ),
  );
}
