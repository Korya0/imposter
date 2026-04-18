import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imposter/core/constants/aoo_constants.dart';
import 'package:imposter/core/constants/app_assets.dart';
import 'package:imposter/core/constants/app_paddings.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/app_text_widget.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/theme/app_colors.dart';
import 'package:imposter/core/theme/app_text_styles.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawerView extends StatelessWidget {
  const AppDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.h18,
          child: Column(
            children: [
              const CustomAppBar(showHowToPlay: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Section 1: Support & Contact
                      AppTextWidget(
                        'دعم وتواصل',
                        style: AppTextStyles.font28W800Primary.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDrawerItem(
                        icon: Icons.lightbulb_outline,
                        text: AppStrings.feedbackSuggestionOrComplaint,
                        onTap: () => showFeedbackBottomSheet(context),
                      ),
                      const SizedBox(height: 12),
                      _buildDrawerItem(
                        icon: Icons.chat_outlined,
                        text: AppStrings.feedbackBusinessContact,
                        onTap: () {
                          // TODO: Implement business contact logic
                        },
                      ),
                      const Divider(
                        color: AppColors.secondaryBackground,
                        thickness: 1,
                        height: 40,
                      ),

                      // Section 2: Share & Rate
                      AppTextWidget(
                        AppStrings.shareAndRate,
                        style: AppTextStyles.font28W800Primary.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDrawerItem(
                        icon: Icons.share,
                        text: AppStrings.shareApp,
                        onTap: () {
                          // TODO: Implement share logic
                        },
                      ),
                      const Divider(
                        color: AppColors.secondaryBackground,
                        thickness: 1,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),

              // Facebook Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Column(
                    children: [
                      AppTextWidget(
                        AppStrings.followUsOn,
                        style: AppTextStyles.font22W800Primary.copyWith(
                          color: AppColors.secondaryBackground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(AppConstants.facebookLink);
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            // Optionally handle error
                          }
                        },
                        child: SvgPicture.asset(
                          AppAssets.facebookSvg,
                          width: 45,
                          height: 45,
                          colorFilter: const ColorFilter.mode(
                            Colors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(width: 16),
            AppTextWidget(
              text,
              style: AppTextStyles.font24W800Primary,
            ),
          ],
        ),
      ),
    );
  }
}
