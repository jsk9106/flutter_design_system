import 'package:flutter_design_system/assets.dart';
import 'package:flutter_design_system/f_svg.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum DropdownType { overlay, bottomSheet }

class FOptionDropdown extends StatefulWidget {
  const FOptionDropdown({
    super.key,
    this.value,
    required this.items,
    required this.focusNode,
    this.type = DropdownType.overlay,
    this.onChanged,
    this.label,
    this.isRequired,
    this.maxHeight, // 필드가 아닌 overlay 영역의 최대 길이, bottomsheet 내부에서 sheet의 길이에 따라 변경되도록 사용
    this.onTap,
    this.enabled = true,
    this.disabledPretyped = false,
    this.hintText,
    this.description,
    this.isError,
    this.width,
  }) : assert(
          !(label == null && isRequired == true),
          'isRequired can only be set when label is not null',
        );

  final String? value;
  final List<String> items;
  final FocusNode focusNode;
  final DropdownType type;
  final Function(String? value)? onChanged;
  final String? label;
  final bool? isRequired;
  final double? maxHeight;
  final VoidCallback? onTap;
  final bool enabled;
  final bool disabledPretyped;
  final String? hintText;
  final String? description;
  final bool? isError;
  final double? width;

  @override
  State<FOptionDropdown> createState() => _FOptionDropdownState();
}

class _FOptionDropdownState extends State<FOptionDropdown> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? _value;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    if (widget.enabled && !widget.disabledPretyped) widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.enabled && !widget.disabledPretyped) widget.focusNode.removeListener(_onFocusChange);
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FOptionDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      setState(() {
        _value = widget.value;
      });
    }
  }

  void _onFocusChange() {
    if (widget.type == DropdownType.overlay) {
      if (widget.focusNode.hasFocus) {
        if (!isOpen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _showOverlay();
          });
        }
      } else {
        _hideOverlay();
      }
    } else {
      setState(() {
        isOpen = !widget.focusNode.hasFocus;
      });
    }
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry();
    setState(() {
      isOpen = true;
    });
    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isOpen = false;
    });
  }

  Color _fontColor() {
    if (!widget.enabled || widget.disabledPretyped) {
      return FColors.of(context).labelDisable;
    }
    return FColors.of(context).labelNormal;
  }

  Color _getBorderColor(bool isFocused) {
    if (widget.isError != null && widget.isError!) {
      return FColors.of(context).statusNegative;
    }

    if (isFocused) {
      return FColors.of(context).lineNormal;
    }

    return widget.enabled || !widget.disabledPretyped
        ? FColors.of(context).lineAlternative
        : FColors.of(context).lineAlternative;
  }

  Color _suffixIconColor() {
    if (!widget.enabled || widget.disabledPretyped) {
      return FColors.of(context).labelDisable;
    }
    return FColors.of(context).labelNormal;
  }

  Color? _fillColor() {
    if (!widget.enabled || widget.disabledPretyped) {
      return FColors.of(context).solidDisable;
    }
    return null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size ?? Size.zero;
    final descriptionOffset = widget.description != null ? 24.0 : 0.0;
    Color? borderColor =
        widget.isError != null && widget.isError! ? FColors.of(context).statusNegative : FColors.of(context).lineStrong;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0.0,
                widget.label != null ? size.height - 28 - descriptionOffset : size.height - descriptionOffset,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: widget.maxHeight ?? 200,
                ),
                decoration: BoxDecoration(
                  color: FColors.of(context).backgroundNormalN,
                  border: Border(
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                    bottom: BorderSide(color: borderColor, width: 1),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: FColors.of(context).backgroundNormalN,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _value = widget.items[index];
                          });

                          if (widget.onChanged != null) {
                            widget.onChanged!(widget.items[index]);
                          }

                          widget.focusNode.unfocus();
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.items[index],
                            style: FTextStyles.bodyL.copyWith(
                              color: FColors.of(context).labelNormal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // description이 있을 경우 추가 높이 계산
    final double totalHeight = widget.label != null
        ? (widget.description != null ? 100 : 76) // description이 있으면 100, 없으면 76
        : (widget.description != null ? 72 : 48); // label이 없을 때는 description 유무에 따라 72 또는 48

    return SizedBox(
      height: totalHeight,
      width: widget.width ?? double.infinity,
      child: Column(
        children: [
          if (widget.label != null) ...[
            Row(
              children: [
                Text(
                  widget.label!,
                  style: FTextStyles.bodyM.copyWith(
                    color: FColors.of(context).labelNormal,
                  ),
                ),
                if (widget.isRequired != null && widget.isRequired == true) ...[
                  const Gap(2),
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
                      const Gap(4),
                    ],
                  ),
                ],
              ],
            ),
            const Gap(8),
          ],
          CompositedTransformTarget(
            link: _layerLink,
            child: Focus(
              focusNode: widget.focusNode,
              child: Builder(
                builder: (context) {
                  final isFocused = Focus.of(context).hasFocus;
                  return GestureDetector(
                    onTap: () {
                      if (widget.disabledPretyped || !widget.enabled) return;

                      if (!isOpen) {
                        widget.focusNode.requestFocus();
                      } else {
                        _hideOverlay();
                        widget.focusNode.unfocus();
                      }
                      widget.onTap?.call();
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: _fillColor(),
                        border: Border.all(
                          color: _getBorderColor(isFocused),
                          width: 1,
                        ),
                        borderRadius: widget.type == DropdownType.overlay && isOpen
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              )
                            : BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _value?.isEmpty ?? true ? (widget.hintText ?? '') : _value!,
                              style: FTextStyles.bodyL.m.copyWith(
                                color: _value?.isEmpty ?? true ? FColors.of(context).labelAssistive : _fontColor(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: FSvg.asset(
                              !isOpen ? Assets.iconsChevronsChevronDownThin : Assets.iconsChevronsChevronUpThin,
                              color: _suffixIconColor(),
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.description != null) ...[
            const Gap(8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.description!,
                style: FTextStyles.bodyS.r.copyWith(
                  color: widget.isError != null && widget.isError!
                      ? FColors.of(context).statusNegative
                      : FColors.of(context).labelAlternative,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
