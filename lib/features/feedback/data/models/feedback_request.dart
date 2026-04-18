class FeedbackRequest {
  final String content;
  final String? contact;

  const FeedbackRequest({
    required this.content,
    this.contact,
  });
}
