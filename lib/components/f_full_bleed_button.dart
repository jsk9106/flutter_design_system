import 'package:flutter/material.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';

enum FullBleedButtonType { oneButton, twoButton }

enum FullBleedButtonSize { large, xLarge }

class FFullBleedButton extends StatelessWidget {
  const FFullBleedButton._({
    super.key,
    required this.type,
    this.onTap,
    this.text,
    this.leftText,
    this.rightText,
    this.onTapLeft,
    this.onTapRight,
    this.disabled = false,
    this.size = FullBleedButtonSize.large,
  });

  // OneButton Factory Constructor
  factory FFullBleedButton.oneButton({
    Key? key,
    required String text,
    required VoidCallback onTap,
    bool disabled = false,
    FullBleedButtonSize size = FullBleedButtonSize.large,
  }) {
    return FFullBleedButton._(
      key: key,
      type: FullBleedButtonType.oneButton,
      text: text,
      onTap: onTap,
      disabled: disabled,
      size: size,
    );
  }

  // TwoButton Factory Constructor
  factory FFullBleedButton.twoButton({
    Key? key,
    required String leftText,
    required String rightText,
    required VoidCallback onTapLeft,
    required VoidCallback onTapRight,
    bool disabled = false,
    FullBleedButtonSize size = FullBleedButtonSize.large,
  }) {
    return FFullBleedButton._(
      key: key,
      type: FullBleedButtonType.twoButton,
      leftText: leftText,
      rightText: rightText,
      onTapLeft: onTapLeft,
      onTapRight: onTapRight,
      disabled: disabled,
      size: size,
    );
  }

  final FullBleedButtonType type;
  final VoidCallback? onTap;
  final String? text;
  final String? leftText;
  final String? rightText;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  final bool disabled;
  final FullBleedButtonSize size;

  double get _height => size == FullBleedButtonSize.large ? 52.0 : 60.0;

  @override
  Widget build(BuildContext context) {
    return type == FullBleedButtonType.oneButton ? _buildOneButton(context) : _buildTwoButton(context);
  }

  Widget _buildOneButton(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: disabled ? FColors.of(context).solidDisable : FColors.of(context).solidStrong,
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            text!,
            style: FTextStyles.bodyXL.b.copyWith(
              color: disabled ? FColors.of(context).labelDisable : FColors.of(context).inverseStrong,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoButton(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: _height,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: disabled ? null : onTapLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabled ? FColors.of(context).solidDisable : FColors.of(context).solidStrong,
                    ),
                    child: Center(
                      child: Text(
                        leftText!,
                        style: FTextStyles.bodyXL.b.copyWith(
                          color: disabled ? FColors.of(context).labelDisable : FColors.of(context).inverseStrong,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: disabled ? null : onTapRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabled ? FColors.of(context).solidDisable : FColors.of(context).solidStrong,
                    ),
                    child: Center(
                      child: Text(
                        rightText!,
                        style: FTextStyles.bodyXL.b.copyWith(
                          color: disabled ? FColors.of(context).labelDisable : FColors.of(context).inverseStrong,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Divider
        Container(
          width: 1,
          height: 20,
          color: disabled ? FColors.of(context).lineAssistive : FColors.of(context).lineNormal,
        ),
      ],
    );
  }
}
