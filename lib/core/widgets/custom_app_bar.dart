import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/widgets/app_button.dart';
import 'package:imposter/core/widgets/how_to_play_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPaddings.h18,
        child: Row(
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
        ),
      ),
    ).animate().slideY(
      begin: -1,
      end: 0,
      duration: 600.ms,
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
