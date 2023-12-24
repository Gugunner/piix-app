///This class is a model for a message problem.
class MessageProblem {
  MessageProblem({
    this.message,
  });

  String? message;

  factory MessageProblem.fromJson(Map<String, dynamic> json) => MessageProblem(
        message: json['message'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        'message': message ?? null,
      };
}
