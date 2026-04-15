import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Optimized Arabic (RTL) transitions: Side-to-Side and Bottom-to-Top.
class AppTransitions {
  AppTransitions._();

  static const Duration _snappyDuration = Duration(milliseconds: 250);

  /// Forward: Slides from Left to Right (Arabic Logical Forward)
  static CustomTransitionPage<void> forward({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: _snappyDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(-1, 0), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  /// Up: Slides from Bottom to Top (Vertical movement)
  static CustomTransitionPage<void> up({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: _snappyDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(0, 1), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        );
      },
    );
  }

  /// Fade: Smooth transition (Reserved for Splash and special cases)
  static CustomTransitionPage<void> fade({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  /// Instant: No transition
  static CustomTransitionPage<void> instant({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
  }
}
