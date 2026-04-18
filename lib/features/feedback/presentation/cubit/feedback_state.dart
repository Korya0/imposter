part of 'feedback_cubit.dart';

sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackSuccess extends FeedbackState {}

final class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError(this.message);
}
