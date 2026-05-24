import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter/core/style/fonts/app_text_styles.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';

class AppTextField extends StatelessWidget {
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

  OutlineInputBorder _border(BuildContext context, Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.p(12)),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: BoxConstraints(
        maxWidth: width ?? 400,
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: textAlign,
        enabled: enabled,
        textInputAction: textInputAction,

        onSubmitted: onSubmitted,
        style: AppTextStyles.font18W700Primary.copyWith(
          color: enabled
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.5),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.font15W700Primary.copyWith(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),

          filled: true,
          fillColor: AppColors.secondaryBackground,
          border: _border(context, AppColors.primary, 1.5),
          enabledBorder: _border(context, AppColors.primary, 1.5),
          focusedBorder: _border(context, AppColors.primary, 2.5),
          disabledBorder: _border(
            context,
            AppColors.primary.withValues(alpha: 0.4),
            1.5,
          ),

          contentPadding: EdgeInsets.symmetric(
            horizontal: context.p(16),
            vertical: context.p(12),
          ),
        ),
        inputFormatters: inputFormatters,
      ),
    );
  }
}
