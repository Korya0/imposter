import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/presentation/widgets/custom_app_bar.dart';
import 'package:imposter/core/style/theme/app_colors.dart';
import 'package:imposter/core/utils/build_context_extension.dart';
import 'package:imposter/features/how_to_play/presentation/widgets/how_to_play_category_section.dart';

class HowToPlayView extends StatefulWidget {
  const HowToPlayView({super.key});

  @override
  State<HowToPlayView> createState() => _HowToPlayViewState();
}

class _HowToPlayViewState extends State<HowToPlayView> {
  late final ScrollController _scrollController;
  final ValueNotifier<bool> _isAppBarVisible = ValueNotifier<bool>(true);

  static const List<RuleCategory> _categories = [
    RuleCategory(
      title: 'الفكرة والأدوار',
      stepIndexes: [0, 1],
    ),
    RuleCategory(
      title: 'طريقة اللعب والسؤال',
      stepIndexes: [2, 3, 4, 5],
    ),
    RuleCategory(
      title: 'التخمين والتصويت',
      stepIndexes: [6, 7, 8, 9],
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Top Spacing so content starts below the app bar
              SliverToBoxAdapter(
                child: SizedBox(height: context.p(90)),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.p(18),
                  vertical: context.p(12),
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(_categories.length, (index) {
                            final isLast = index == _categories.length - 1;
                            return HowToPlayCategorySection(
                              category: _categories[index],
                              isLast: isLast,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
            child: const ColoredBox(
              color: AppColors.background,
              child: CustomAppBar(
                title: AppStrings.howToPlay,
                showBackButton: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
