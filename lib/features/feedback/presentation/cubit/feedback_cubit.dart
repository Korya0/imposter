import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/constants/app_strings.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/feedback/data/models/feedback_request_model.dart';
import 'package:imposter/features/feedback/data/repositories/i_feedback_repository.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._feedbackRepository) : super(FeedbackInitial());
  final IFeedbackRepository _feedbackRepository;

  Future<void> submitFeedback({
    required String content,
    String? contact,
  }) async {
    if (content.trim().isEmpty) {
      emit(FeedbackError(AppStrings.feedbackEmptyError));
      return;
    }

    emit(FeedbackLoading());

    final request = FeedbackRequestModel(content: content, contact: contact);
    final result = await _feedbackRepository.submitFeedback(request);

    switch (result) {
      case Success():
        emit(FeedbackSuccess());
      case FailureResult(:final failure):
        emit(FeedbackError(failure.message));
    }
  }

  void reset() => emit(FeedbackInitial());
}
