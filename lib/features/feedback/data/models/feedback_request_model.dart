class FeedbackRequestModel {
  const FeedbackRequestModel({
    required this.content,
    this.contact,
  });
  final String content;
  final String? contact;
}
