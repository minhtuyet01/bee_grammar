class ListeningAttempt {
  final String id;
  final String exerciseId;
  final String userId;
  final Map<String, String> answers; // questionId -> answer
  final int score;
  final DateTime completedAt;

  ListeningAttempt({
    required this.id,
    required this.exerciseId,
    required this.userId,
    required this.answers,
    required this.score,
    required this.completedAt,
  });

  factory ListeningAttempt.fromJson(Map<String, dynamic> json) {
    return ListeningAttempt(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      userId: json['userId'] as String,
      answers: Map<String, String>.from(json['answers'] as Map),
      score: json['score'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'userId': userId,
      'answers': answers,
      'score': score,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  int get totalQuestions => answers.length;
  
  double get percentage => totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;
  
  String get grade {
    final percent = percentage;
    if (percent >= 90) return 'Xuất sắc';
    if (percent >= 80) return 'Giỏi';
    if (percent >= 70) return 'Khá';
    if (percent >= 60) return 'Trung bình';
    return 'Cần cố gắng';
  }
}
