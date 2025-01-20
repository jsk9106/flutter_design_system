import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

class FRoundDropdown extends StatelessWidget {
  const FRoundDropdown({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: FColors.of(context).lineAlternative),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: FTextStyles.bodyL.copyWith(color: FColors.of(context).solidStrong),
                ),
              ),
            ),
            SizedBox(
              width: 16,
              height: 16,
              child: FSvg.asset(
                Assets.iconsChevronsChevronDownThin,
                color: FColors.of(context).solidStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
