import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/di/di.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/presentation/widgets/app_toast.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_discard_dialog.dart';
import 'package:imposter/features/feedback/presentation/widgets/feedback_form.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _feedbackController = TextEditingController();
  final _contactController = TextEditingController();
  late final ScrollController _scrollController;
  final ValueNotifier<bool> _isAppBarVisible = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    _isAppBarVisible.dispose();
    _feedbackController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (_isAppBarVisible.value) {
        _isAppBarVisible.value = false;
      }
    } else if (direction == ScrollDirection.forward) {
      if (!_isAppBarVisible.value) {
        _isAppBarVisible.value = true;
      }
    }
  }

  Future<bool> _showDiscardConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.75),
          builder: (dialogContext) => const FeedbackDiscardDialog(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeedbackCubit>(),
      child: BlocListener<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSuccess) {
            AppToast.show(context, AppStrings.feedbackSuccess);
            Navigator.pop(context);
          } else if (state is FeedbackError) {
            AppToast.show(context, state.message);
          }
        },
        child: BlocBuilder<FeedbackCubit, FeedbackState>(
          builder: (context, state) {
            final isLoading = state is FeedbackLoading;
            return PopScope(
              canPop:
                  !isLoading &&
                  _feedbackController.text.trim().isEmpty &&
                  _contactController.text.trim().isEmpty,
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop || isLoading) return;
                final shouldPop = await _showDiscardConfirmation(context);
                if (shouldPop && context.mounted) Navigator.pop(context);
              },
              child: Scaffold(
                body: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.p(18)),
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          // Top Spacing so form starts below the app bar
                          SliverToBoxAdapter(
                            child: SizedBox(height: context.p(90)),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: context.p(24)),
                              child: FeedbackForm(
                                feedbackController: _feedbackController,
                                contactController: _contactController,
                                isLoading: isLoading,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isAppBarVisible,
                      builder: (context, isVisible, child) {
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOutQuad,
                          top: isVisible ? 0 : -context.p(100),
                          left: 0,
                          right: 0,
                          child: child!,
                        );
                      },
                      child: ColoredBox(
                        color: AppColors.background,
                        child: CustomAppBar(
                          title: AppStrings.dontLetHopeDown,
                          showBackButton: true,
                          onBackTap: () async {
                            final canPopDirectly = !isLoading &&
                                _feedbackController.text.trim().isEmpty &&
                                _contactController.text.trim().isEmpty;
                            if (canPopDirectly) {
                              Navigator.pop(context);
                            } else {
                              final shouldPop = await _showDiscardConfirmation(context);
                              if (shouldPop && context.mounted) Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
