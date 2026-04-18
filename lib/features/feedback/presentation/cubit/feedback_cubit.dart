import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/feedback/data/models/feedback_request.dart';
import 'package:imposter/features/feedback/data/repositories/feedback_repository_impl.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepositoryImpl _feedbackRepository;

  FeedbackCubit(this._feedbackRepository) : super(FeedbackInitial());

  Future<void> submitFeedback({
    required String content,
    String? contact,
  }) async {
    if (content.isEmpty) return;
    
    emit(FeedbackLoading());

    final request = FeedbackRequest(content: content, contact: contact);
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
