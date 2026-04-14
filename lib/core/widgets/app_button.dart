import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/core/widgets/app_text_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.style,
    this.width,
    this.height,
  });

  final String title;
  final VoidCallback? onTap;
  final TextStyle? style;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: width ?? double.infinity,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AppSvgs.paper,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 4,
                ),
                child: Center(
                  child: Transform.translate(
                    offset: const Offset(0, -14),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AppTextWidget(
                        title: title,
                        style: style ?? AppTextStyles.font34BoldSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
