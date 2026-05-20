import 'package:imposter/core/error/result.dart';
import 'package:imposter/features/feedback/data/models/feedback_request_model.dart';

abstract class IFeedbackRepository {
  Future<Result<void>> submitFeedback(FeedbackRequestModel request);
}
