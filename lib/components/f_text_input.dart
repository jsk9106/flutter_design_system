import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class FTextInputConstants {
  // outlined 버전용 패딩
  static const outlinedContentPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 12.0,
  );

  // contained 버전용 패딩
  static const containedContentPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 12.0, // vertical 패딩 추가
  );
  static const BoxConstraints suffixConstraints = BoxConstraints(
    minWidth: 24,
    maxWidth: 93, // suffix가 가질 수 있는 최대 넓이 합산
    maxHeight: 24,
    minHeight: 24,
  );

  static const BoxConstraints prefixConstraints = BoxConstraints(
    minWidth: 24,
    maxWidth: 40, // prefix가 가질 수 있는 최대 넓이 합산
    maxHeight: 24,
    minHeight: 24,
  );

  static const double borderRadius = 4.0;
  static const double asteriskSpacing = 2.0;
  static const double asteriskBottomPadding = 4.0;
}

class FTextInput extends StatefulWidget {
  final FocusNode? fousNode;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEdditingComplete;
  final Function()? onTap;
  final AutovalidateMode? autoValidateMode;
  final String? hintText;
  final String? label;
  final Widget? prefix; // Widget은 Center에 감싸주어야함
  final Widget? suffix; // Widget은 Center에 감싸주어야함
  final TextInputType keyboardType;
  final bool isRequired;
  final bool isPassword;
  final bool enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLine;
  final int? minLine;
  final Widget? counter;
  final TextAlign? textAlign;
  final bool disabledPretyped;
  final bool autoFocus;
  final bool _isContained;
  final String? errorText;
  final String? helperText;

  const FTextInput._({
    super.key,
    this.fousNode,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onEdditingComplete,
    this.onTap,
    this.autoValidateMode = AutovalidateMode.onUnfocus, // 사용하지 않을 때 AutovalidateMode.disabled (폼 전체 검토 버튼으로만 작동할 경우)
    this.hintText,
    this.label,
    this.prefix,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.isRequired = false,
    this.isPassword = false,
    this.enabled = true,
    this.maxLength,
    this.inputFormatters,
    this.maxLine,
    this.minLine,
    this.counter,
    this.textAlign,
    this.disabledPretyped = false,
    this.autoFocus = false,
    bool isContained = false,
    this.errorText, // 생성자에 errorText 추가
    this.helperText,
  }) : _isContained = isContained;

  factory FTextInput({
    Key? key,
    FocusNode? fousNode,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    Function()? onEdditingComplete,
    Function()? onTap,
    AutovalidateMode? autoValidateMode = AutovalidateMode.onUnfocus,

    /// 사용하지 않을 때 AutovalidateMode.disabled (폼 전체 검토 버튼으로만 작동할 경우)
    String? hintText,
    String? label,
    Widget? prefix,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
    bool isPassword = false,
    bool enabled = true,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    int? maxLine,
    int? minLine,
    Widget? counter,
    TextAlign? textAlign,
    bool disabledPretyped = false,
    bool autoFocus = false,
    String? errorText,
    String? helperText,
  }) {
    return FTextInput._(
      key: key,
      fousNode: fousNode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEdditingComplete: onEdditingComplete,
      onTap: onTap,
      autoValidateMode: autoValidateMode,
      hintText: hintText,
      label: label,
      prefix: prefix,
      suffix: suffix,
      keyboardType: keyboardType,
      isRequired: isRequired,
      isPassword: isPassword,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      maxLine: maxLine,
      minLine: minLine,
      counter: counter,
      textAlign: textAlign,
      disabledPretyped: disabledPretyped,
      autoFocus: autoFocus,
      isContained: false,
      errorText: errorText,
      helperText: helperText,
    );
  }

  factory FTextInput.contained({
    Key? key,
    FocusNode? fousNode,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    Function()? onEdditingComplete,
    Function()? onTap,
    AutovalidateMode? autoValidateMode = AutovalidateMode.onUnfocus,

    /// 사용하지 않을 때 AutovalidateMode.disabled (폼 전체 검토 버튼으로만 작동할 경우)
    String? hintText,
    String? label,
    Widget? prefix,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
    bool isPassword = false,
    bool enabled = true,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    int? maxLine,
    int? minLine,
    Widget? counter,
    TextAlign? textAlign,
    bool disabledPretyped = false,
    bool autoFocus = false,
    String? errorText,
    String? helperText,
  }) {
    return FTextInput._(
      key: key,
      fousNode: fousNode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEdditingComplete: onEdditingComplete,
      onTap: onTap,
      autoValidateMode: autoValidateMode,
      hintText: hintText,
      label: label,
      prefix: prefix,
      suffix: suffix,
      keyboardType: keyboardType,
      isRequired: isRequired,
      isPassword: isPassword,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      maxLine: maxLine,
      minLine: minLine,
      counter: counter,
      textAlign: textAlign,
      disabledPretyped: disabledPretyped,
      autoFocus: autoFocus,
      isContained: true,
      errorText: errorText,
      helperText: helperText,
    );
  }

  @override
  State<FTextInput> createState() => _FTextInputState();
}

class _FTextInputState extends State<FTextInput> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _errorText = widget.errorText;
  }

  Widget _buildLabel() {
    if (widget.label == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label!,
              style: FTextStyles.bodyM.copyWith(
                color: FColors.of(context).labelNormal,
              ),
            ),
            if (widget.isRequired) ...[
              const Gap(FTextInputConstants.asteriskSpacing),
              Column(
                children: [
                  Text(
                    '*',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: FTextStyles.bodyS.b.copyWith(
                      color: FColors.of(context).statusNegative,
                    ),
                  ),
                  const Gap(FTextInputConstants.asteriskBottomPadding),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildStatusText() {
    final colors = FColors.of(context);

    // 에러 텍스트가 있는 경우
    if (_errorText != null && _errorText!.isNotEmpty) {
      return Text(
        _errorText!,
        style: FTextStyles.bodyS.copyWith(
          color: colors.statusNegative,
        ),
        textAlign: TextAlign.start,
      );
    }

    // 헬퍼 텍스트가 있는 경우
    if (widget.helperText != null) {
      return Text(
        widget.helperText!,
        style: FTextStyles.bodyS.copyWith(
          color: colors.labelAlternative,
        ),
        textAlign: TextAlign.start,
      );
    }

    return const SizedBox.shrink();
  }

  InputDecoration _buildInputDecoration() {
    final colors = FColors.of(context);

    if (widget._isContained) {
      return InputDecoration(
        contentPadding: FTextInputConstants.containedContentPadding,
        isDense: true,
        prefixIcon: widget.prefix,
        counter: widget.counter,
        errorMaxLines: 1,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: colors.labelAssistive,
        ),
        errorStyle: const TextStyle(
          color: Colors.transparent,
          fontSize: 0,
          height: 0.0,
        ),
        filled: true,
        fillColor: widget.enabled ? colors.solidAssistive : colors.solidDisable,
        enabled: widget.enabled,
        suffixIcon: widget.suffix,
        suffixIconConstraints: FTextInputConstants.suffixConstraints,
        prefixIconConstraints: FTextInputConstants.prefixConstraints,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
        ),
      );
    }

    return InputDecoration(
      contentPadding: FTextInputConstants.outlinedContentPadding,
      suffixIconConstraints: FTextInputConstants.suffixConstraints,
      prefixIconConstraints: FTextInputConstants.prefixConstraints,
      suffixIcon: widget.suffix,
      isDense: true,
      prefixIcon: widget.prefix,
      counter: widget.counter,
      errorMaxLines: 1,
      hintText: widget.hintText,
      hintStyle: TextStyle(
        color: colors.labelAssistive,
      ),
      errorStyle: const TextStyle(
        color: Colors.transparent,
        fontSize: 0,
        height: 0.0, // 에러 텍스트의 높이를 조절
      ),
      filled: !widget.enabled,
      fillColor: widget.enabled ? null : colors.solidDisable,
      enabled: widget.enabled,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colors.lineNormal, width: 1),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.lineAlternative, width: 1),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.lineNormal, width: 1),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.statusNegative,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.lineAlternative, width: 1),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.statusNegative,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(FTextInputConstants.borderRadius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        const Gap(8),
        SizedBox(
          height: 48,
          child: TextFormField(
            cursorHeight: 16,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters,
            focusNode: widget.fousNode,
            maxLength: widget.maxLength,
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign ?? TextAlign.start,
            validator: (value) {
              if (widget.validator != null) {
                final error = widget.validator!(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _errorText != error) {
                    setState(() {
                      _errorText = error;
                    });
                  }
                });
                return error; // error를 실제로 반환
              }
              return null;
            },
            enabled: widget.enabled,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEdditingComplete,
            autovalidateMode: widget.autoValidateMode,
            controller: widget.controller,
            cursorColor: FColors.of(context).lineStrong,
            obscureText: widget.isPassword,
            keyboardType: widget.keyboardType,
            style: FTextStyles.bodyL.r.copyWith(
              color: widget.enabled || widget.disabledPretyped
                  ? FColors.of(context).labelNormal
                  : FColors.of(context).labelAssistive,
            ),
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            decoration: _buildInputDecoration(),
          ),
        ),
        _buildStatusText(),
      ],
    );
  }
}
