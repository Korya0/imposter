import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitions {
  AppTransitions._();

  static const Duration _duration = Duration(milliseconds: 300);
  static const Duration _reverseDuration = Duration(milliseconds: 250);

  static CustomTransitionPage<void> slideFromRight({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration ?? _duration,
      reverseTransitionDuration: reverseDuration ?? _reverseDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static CustomTransitionPage<void> fade({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration ?? _duration,
      reverseTransitionDuration: reverseDuration ?? _reverseDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}
