import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/extentions/number_extension.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter_design_system/themes/f_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum FInputStepperType { round, square }

class FInputStepper extends StatefulWidget {
  final double initialValue;
  final String unit;
  final int step;
  final double minValue;
  final double maxValue;
  final Function(double) onValueChanged;
  final FocusNode? focusNode;
  final FInputStepperType type;

  const FInputStepper({
    super.key,
    required this.initialValue,
    required this.unit,
    required this.step,
    required this.onValueChanged,
    this.focusNode,
    this.minValue = 0,
    this.maxValue = 9999999,
    required this.type,
  });

  @override
  _FInputStepperState createState() => _FInputStepperState();

  factory FInputStepper.round({
    required double initialValue,
    required String unit,
    required int step,
    required Function(double) onValueChanged,
    double minValue = 0,
    double maxValue = 9999999,
    FocusNode? focusNode,
  }) =>
      FInputStepper(
        initialValue: initialValue,
        unit: unit,
        step: step,
        onValueChanged: onValueChanged,
        minValue: minValue,
        maxValue: maxValue,
        focusNode: focusNode,
        type: FInputStepperType.round,
      );

  factory FInputStepper.square({
    required double initialValue,
    required int step,
    required Function(double) onValueChanged,
    double minValue = 0,
    double maxValue = 9999999,
    FocusNode? focusNode,
  }) =>
      FInputStepper(
        initialValue: initialValue,
        unit: '',
        step: step,
        onValueChanged: onValueChanged,
        minValue: minValue,
        maxValue: maxValue,
        focusNode: focusNode,
        type: FInputStepperType.square,
      );
}

class _FInputStepperState extends State<FInputStepper> {
  late double _currentValue;
  late TextEditingController _controller;
  late FocusNode _textFieldFocusNode;
  final _focusNode = FocusNode();
  bool _isFocused = false; // 포커스 상태를 추적하기 위한 변수 추가

  /// type에 따라 달라지는 UI
  late final double _borderRadius;
  late final EdgeInsetsGeometry _padding;
  late final double _iconSize;
  late final double _height;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController();
    _textFieldFocusNode = widget.focusNode ?? FocusNode();
    if (widget.type == FInputStepperType.round) {
      _textFieldFocusNode.addListener(() {
        setState(() {
          _isFocused = _textFieldFocusNode.hasFocus;
        });
      });
    }
    _focusNode.addListener(_onFocusChange);
    _updateControllerText();
    _setUiForType();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    if (widget.type == FInputStepperType.round && widget.focusNode == null) {
      _textFieldFocusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    _validateValue();
  }

  @override
  void didUpdateWidget(covariant FInputStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _currentValue = widget.initialValue;
      _updateControllerText();
    }
  }

  void _setUiForType() {
    switch (widget.type) {
      case FInputStepperType.round:
        _borderRadius = 999;
        _padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
        _iconSize = 24;
        _height = 52;
        break;
      case FInputStepperType.square:
        _borderRadius = 4;
        _padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
        _iconSize = 16;
        _height = 32;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      child: Container(
        height: _height,
        padding: _padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(color: _isFocused ? FColors.of(context).labelNormal : FColors.of(context).lineAlternative),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: _currentValue <= widget.minValue ? null : _decrement,
              child: FSvg.asset(
                Assets.iconsNormalMinusSmallThin,
                width: _iconSize,
                color: (_currentValue <= widget.minValue)
                    ? FColors.of(context).labelDisable
                    : FColors.of(context).labelNormal,
              ),
            ),
            if (widget.type == FInputStepperType.round) ...[
              const Gap(4),
              Expanded(
                child: _buildTextField(),
              ),
              const Gap(4),
            ] else if (widget.type == FInputStepperType.square) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 48,
                  child: _buildTextField(),
                ),
              ),
            ],
            GestureDetector(
              onTap: _currentValue >= widget.maxValue ? null : _increment,
              child: FSvg.asset(
                Assets.iconsNormalPlusSmallThin,
                width: _iconSize,
                color: (_currentValue >= widget.maxValue)
                    ? FColors.of(context).labelDisable
                    : FColors.of(context).labelNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      focusNode: _textFieldFocusNode,
      controller: _controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: FColors.of(context).lineStrong,
      onChanged: _onTextChanged,
      onTap: () {
        final unitStartPosition = _controller.text.length - widget.unit.length;
        if (_controller.selection.baseOffset >= unitStartPosition) {
          _controller.selection = TextSelection.collapsed(offset: unitStartPosition);
        }
      },
      onEditingComplete: () {
        _validateValue(); // 편집이 끝날 때 값 유효성 검사
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        counterText: '',
      ),
      style: FTextStyles.bodyL.copyWith(
        color: FColors.of(context).labelNormal,
        fontWeight: widget.type == FInputStepperType.round ? FFontWeight.regular : FFontWeight.medium,
      ),
    );
  }

  void _onTextChanged(String text) {
    // 단위를 포함한 전체 텍스트에서 단위를 제거하고 숫자 부분만 가져옴
    String inputValue = text.replaceAll(widget.unit, '').trim();

    // 숫자가 아닌 값이 입력되면 현재 상태를 유지하고 단위를 다시 추가
    if (inputValue.isNotEmpty && int.tryParse(inputValue) == null) {
      _updateControllerText(keepCursorPosition: true);
      return;
    }

    // 입력된 값이 빈 경우 단위를 유지하고 숫자 부분은 빈 상태로 유지
    if (inputValue.isEmpty) {
      _currentValue = 0;
      int newPosition = text.length;

      if (widget.type == FInputStepperType.round) {
        newPosition = text.length - 1;
      } else {
        newPosition = text.length - 2;
      }

      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: newPosition),
      );
    } else {
      _currentValue = double.parse(inputValue);
    }

    _updateControllerText(keepCursorPosition: true);
  }

  void _validateValue() {
    setState(() {
      _currentValue = _currentValue.clamp(widget.minValue, widget.maxValue);
      _updateControllerText();
    });
  }

  void _updateControllerText({bool keepCursorPosition = false}) {
    final newText = '${_currentValue.toCleanString(1)}${widget.unit}';
    int cursorPosition = _currentValue.toString().length;

    if (keepCursorPosition) {
      cursorPosition = _controller.selection.baseOffset.clamp(0, cursorPosition);

      // 커서가 단위 앞에만 위치하도록 제한
      if (cursorPosition >= newText.length - widget.unit.length) {
        cursorPosition = newText.length - widget.unit.length;
      }
    } else {
      // 커서를 기본적으로 단위 앞에 위치시키도록 설정
      cursorPosition = newText.length - widget.unit.length;
    }

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: cursorPosition,
      ),
    );

    widget.onValueChanged(_currentValue);
  }

  void _increment() {
    setState(() {
      _currentValue = (_currentValue + widget.step).clamp(widget.minValue, widget.maxValue);
      _updateControllerText();
    });
  }

  void _decrement() {
    setState(() {
      _currentValue = (_currentValue - widget.step).clamp(widget.minValue, widget.maxValue);
      _updateControllerText();
    });
  }
}
