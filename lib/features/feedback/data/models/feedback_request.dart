class FeedbackRequest {
  const FeedbackRequest({
    required this.content,
    this.contact,
  });
  final String content;
  final String? contact;
}
