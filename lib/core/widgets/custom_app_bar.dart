import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/how_to_play_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: (context.height * 0.01).clamp(20, 40)),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HowToPlayButton(),

              AppButton(
                height: 50,
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppSvgs.backIcon,
                  height: 24,
                ),
              ),
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
