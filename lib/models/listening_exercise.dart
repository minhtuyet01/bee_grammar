import 'listening_question.dart';

class ListeningExercise {
  final String id;
  final String title;
  final String audioUrl;
  final String transcript;
  final int duration; // seconds
  final String level; // A1, A2, B1, B2, C1, C2
  final String topic; // travel, work, study, etc.
  final List<ListeningQuestion> questions;

  ListeningExercise({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.transcript,
    required this.duration,
    required this.level,
    required this.topic,
    required this.questions,
  });

  factory ListeningExercise.fromJson(Map<String, dynamic> json) {
    return ListeningExercise(
      id: json['id'] as String,
      title: json['title'] as String,
      audioUrl: json['audioUrl'] as String,
      transcript: json['transcript'] as String,
      duration: json['duration'] as int,
      level: json['level'] as String,
      topic: json['topic'] as String,
      questions: (json['questions'] as List)
          .map((q) => ListeningQuestion.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'audioUrl': audioUrl,
      'transcript': transcript,
      'duration': duration,
      'level': level,
      'topic': topic,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
