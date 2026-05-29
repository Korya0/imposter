import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/presentation/widgets/painters/sketchy_input_painter.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.maxLines = 1,
    this.keyboardType,
    this.textAlign = TextAlign.right,
    this.enabled = true,
    this.textInputAction,
    this.onSubmitted,
    this.width,
    this.focusNode,
    this.inputFormatters,
    this.iconWidget,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final double? width;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? iconWidget;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _onTextChanged() {
    setState(() {}); // Rebuild to update suffix icon clear button
  }

  @override
  Widget build(BuildContext context) {
    final activeBorderColor = widget.enabled
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.4);

    return Container(
      width: widget.width,
      constraints: BoxConstraints(
        maxWidth: widget.width ?? 400,
      ),
      child: CustomPaint(
        painter: SketchyInputPainter(
          color: activeBorderColor,
          isFocused: _isFocused && widget.enabled,
          strokeWidth: _isFocused ? 2.8 : 1.8,
          fillColor: AppColors.secondaryBackground,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.p(2)),
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textAlign: widget.textAlign,
            enabled: widget.enabled,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
            style: AppTextStyles.font18W700Primary.copyWith(
              color: widget.enabled
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.5),
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.font10W400Primary.copyWith(
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              prefixIcon: widget.iconWidget,
              suffixIcon: widget.controller.text.isNotEmpty && widget.enabled
                  ? GestureDetector(
                      onTap: () {
                        widget.controller.clear();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.clear_sharp,
                        color: AppColors.primary,
                        size: context.s(20),
                      ),
                    )
                  : null,
              filled: false, // background fill is drawn by SketchyInputPainter
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.p(16),
                vertical: context.p(14),
              ),
            ),
            inputFormatters: widget.inputFormatters,
          ),
        ),
      ),
    );
  }
}
