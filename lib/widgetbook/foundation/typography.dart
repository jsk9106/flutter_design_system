import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Typography',
  type: FTextStyles,
  path: 'foundation/typography',
)
Widget fTypographys(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        titleWidget(
          'Display',
          [
            fTextStylesContainer('Display 1 -36B', FTextStyles.display1_36.b),
            fTextStylesContainer('Display 1 -36M', FTextStyles.display1_36.m),
            fTextStylesContainer('Display 1 -36R', FTextStyles.display1_36.r),
            fTextStylesContainer('Display 2 -32B', FTextStyles.display2_32.b),
            fTextStylesContainer('Display 2 -32M', FTextStyles.display2_32.m),
            fTextStylesContainer('Display 2 -32R', FTextStyles.display2_32.r),
          ],
        ),
        titleWidget(
          'Title',
          [
            fTextStylesContainer('Title 1 -24B', FTextStyles.title1_24.b),
            fTextStylesContainer('Title 1 -24M', FTextStyles.title1_24.m),
            fTextStylesContainer('Title 1 -24R', FTextStyles.title1_24.r),
            fTextStylesContainer('Title 2 -20B', FTextStyles.title2_20.b),
            fTextStylesContainer('Title 2 -20M', FTextStyles.title2_20.m),
            fTextStylesContainer('Title 2 -20R', FTextStyles.title2_20.r),
            fTextStylesContainer('Title 3 -18B', FTextStyles.title3_18.b),
            fTextStylesContainer('Title 3 -18M', FTextStyles.title3_18.m),
            fTextStylesContainer('Title 3 -18R', FTextStyles.title3_18.r),
            fTextStylesContainer('Title 4 -17B', FTextStyles.title4_17.b),
            fTextStylesContainer('Title 4 -17M', FTextStyles.title4_17.m),
            fTextStylesContainer('Title 4 -17R', FTextStyles.title4_17.r),
          ],
        ),
        titleWidget(
          'Body',
          [
            fTextStylesContainer('Body 1 -16B', FTextStyles.body1_16.b),
            fTextStylesContainer('Body 1 -16M', FTextStyles.body1_16.m),
            fTextStylesContainer('Body 1 -16R', FTextStyles.body1_16.r),
            fTextStylesContainer('Body 2 -14B', FTextStyles.body2_14.b),
            fTextStylesContainer('Body 2 -14M', FTextStyles.body2_14.m),
            fTextStylesContainer('Body 2 -14R', FTextStyles.body2_14.r),
            fTextStylesContainer('Body 3 -13B', FTextStyles.body3_13.b),
            fTextStylesContainer('Body 3 -13M', FTextStyles.body3_13.m),
            fTextStylesContainer('Body 3 -13R', FTextStyles.body3_13.r),
            fTextStylesContainer('Body 4 -12B', FTextStyles.body4_12.b),
            fTextStylesContainer('Body 4 -12M', FTextStyles.body4_12.m),
            fTextStylesContainer('Body 4 -12R', FTextStyles.body4_12.r),
            fTextStylesContainer('Body 5 -10B', FTextStyles.body5_10.b),
            fTextStylesContainer('Body 5 -10M', FTextStyles.body5_10.m),
            fTextStylesContainer('Body 5 -10R', FTextStyles.body5_10.r),
          ],
        ),
        titleWidget('Body - Reading', [
          fTextStylesContainer('Body 1 -16B_Rd', FTextStyles.body1_16Rd.b),
          fTextStylesContainer('Body 1 -16M_Rd', FTextStyles.body1_16Rd.m),
          fTextStylesContainer('Body 1 -16R_Rd', FTextStyles.body1_16Rd.r),
          fTextStylesContainer('Body 2 -14B_Rd', FTextStyles.body2_14Rd.b),
          fTextStylesContainer('Body 2 -14M_Rd', FTextStyles.body2_14Rd.m),
          fTextStylesContainer('Body 2 -14R_Rd', FTextStyles.body2_14Rd.r),
          fTextStylesContainer('Body 3 -13B_Rd', FTextStyles.body3_13Rd.b),
          fTextStylesContainer('Body 3 -13M_Rd', FTextStyles.body3_13Rd.m),
          fTextStylesContainer('Body 3 -13R_Rd', FTextStyles.body3_13Rd.r),
        ])
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
        ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            })
      ],
    ),
  );
}

Widget fTextStylesContainer(String name, TextStyle style) {
  return Text(name, style: style);
}
