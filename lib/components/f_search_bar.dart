import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';

enum FSearchBarVariant { normal, subtle }

class FSearchBar extends StatelessWidget {
  const FSearchBar({
    super.key,
    required this.variant,
    required this.controller,
    this.width,
    this.height,
    this.hintText,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
    this.textInputAction,
    this.onClear,
  });

  final FSearchBarVariant variant;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String? hintText;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final TextInputAction? textInputAction;
  final VoidCallback? onClear;

  factory FSearchBar.normal({
    Key? key,
    required TextEditingController controller,
    double? width,
    String? hintText,
    FocusNode? focusNode,
    Function()? onTap,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    ValueChanged<bool>? onFocusChanged,
    TextInputAction? textInputAction,
    VoidCallback? onClear,
  }) {
    return FSearchBar(
      key: key,
      variant: FSearchBarVariant.normal,
      controller: controller,
      width: width,
      height: 52,
      hintText: hintText,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onFocusChanged: onFocusChanged,
      textInputAction: textInputAction,
      onClear: onClear,
    );
  }

  factory FSearchBar.subtle({
    Key? key,
    required TextEditingController controller,
    double? width,
    String? hintText,
    FocusNode? focusNode,
    Function()? onTap,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    ValueChanged<bool>? onFocusChanged,
    TextInputAction? textInputAction,
    VoidCallback? onClear,
  }) {
    return FSearchBar(
      key: key,
      variant: FSearchBarVariant.subtle,
      width: width,
      height: 44,
      controller: controller,
      hintText: hintText,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onFocusChanged: onFocusChanged,
      textInputAction: textInputAction,
      onClear: onClear,
    );
  }

  OutlineInputBorder outlinedInputBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(24),
      );

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChanged,
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          controller: controller,
          cursorColor: FColors.of(context).lineStrong,
          textAlignVertical: TextAlignVertical.center,
          style: FTextStyles.bodyL.r.copyWith(color: FColors.of(context).labelNormal),
          textInputAction: textInputAction,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FTextStyles.bodyL.r.copyWith(color: FColors.of(context).labelAssistive),
            border: outlinedInputBorder(FColors.of(context).solidAssistive),
            enabledBorder: outlinedInputBorder(FColors.of(context).solidAssistive),
            focusedBorder: outlinedInputBorder(FColors.of(context).solidAssistive),
            contentPadding: contentPadding,
            prefixIcon: Padding(
              padding: prefixIconPadding,
              child: SizedBox(
                width: iconSize,
                height: iconSize,
                child: Center(
                  child: FSvg.asset(
                    Assets.iconsNormalSearch,
                    color: FColors.of(context).labelAlternative,
                    width: iconSize,
                  ),
                ),
              ),
            ),
            suffixIcon: controller.text.isEmpty
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        controller.clear();
                        onClear?.call();
                      },
                      child: SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: Center(
                          child: FSvg.asset(
                            Assets.iconsNormalErase,
                            color: FColors.of(context).labelAssistive,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
            filled: true,
            fillColor: FColors.of(context).solidAssistive,
            isDense: true,
          ),
          onSubmitted: onSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }

  EdgeInsetsGeometry get contentPadding {
    if (variant == FSearchBarVariant.normal) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 14);
    }
    return const EdgeInsets.all(12);
  }

  EdgeInsetsGeometry get prefixIconPadding {
    if (variant == FSearchBarVariant.normal) {
      return const EdgeInsets.fromLTRB(12, 14, 8, 14);
    }
    return const EdgeInsets.fromLTRB(12, 12, 8, 12);
  }

  double get iconSize {
    if (variant == FSearchBarVariant.normal) {
      return 24;
    }
    return 20;
  }
}
