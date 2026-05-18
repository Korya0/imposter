part of 'feedback_cubit.dart';

sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackSuccess extends FeedbackState {}

final class FeedbackError extends FeedbackState {
  FeedbackError(this.message);
  final String message;
}
