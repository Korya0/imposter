import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/presentation/widgets/app_button.dart';
import 'package:imposter/features/game/presentation/widgets/how_to_play_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.showText = true,
    this.showHowToPlay = true,
  });
  final bool showText;
  final bool showHowToPlay;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appBarBottomPadding(context),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                height: 50,
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppAssets.backIconSvg,
                  height: 24,
                ),
              ),
              if (!showHowToPlay) const SizedBox(),
              if (showHowToPlay) HowToPlayIconButton(showText: showText),
            ],
          ).animate().slideY(
            begin: -1,
            end: 0,
            duration: 600.ms,
            curve: Curves.easeOutQuad,
          ),
    );
  }
}
