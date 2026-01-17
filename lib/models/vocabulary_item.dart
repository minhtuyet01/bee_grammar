/// Vocabulary item for spaced repetition learning
class VocabularyItem {
  final String id;
  final String word;
  final String translation; // Dịch tiếng Việt
  final String phonetic; // Phiên âm IPA
  final String audioUrl;
  final String? imageUrl;
  final String exampleSentence;
  final String exampleTranslation;
  final String unitId;
  final DateTime? lastReviewed;
  final int reviewCount;
  final DateTime? nextReview; // Spaced repetition
  final int correctCount;
  final int incorrectCount;

  VocabularyItem({
    required this.id,
    required this.word,
    required this.translation,
    required this.phonetic,
    required this.audioUrl,
    this.imageUrl,
    required this.exampleSentence,
    required this.exampleTranslation,
    required this.unitId,
    this.lastReviewed,
    this.reviewCount = 0,
    this.nextReview,
    this.correctCount = 0,
    this.incorrectCount = 0,
  });

  /// Calculate next review date based on spaced repetition algorithm
  DateTime calculateNextReview(bool wasCorrect) {
    final now = DateTime.now();
    
    if (!wasCorrect) {
      // Review again tomorrow if incorrect
      return now.add(const Duration(days: 1));
    }
    
    // Spaced repetition intervals
    if (correctCount == 0) {
      return now.add(const Duration(days: 1));
    } else if (correctCount == 1) {
      return now.add(const Duration(days: 3));
    } else if (correctCount == 2) {
      return now.add(const Duration(days: 7));
    } else if (correctCount == 3) {
      return now.add(const Duration(days: 14));
    } else {
      return now.add(const Duration(days: 30));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'translation': translation,
        'phonetic': phonetic,
        'audioUrl': audioUrl,
        'imageUrl': imageUrl,
        'exampleSentence': exampleSentence,
        'exampleTranslation': exampleTranslation,
        'unitId': unitId,
        'lastReviewed': lastReviewed?.toIso8601String(),
        'reviewCount': reviewCount,
        'nextReview': nextReview?.toIso8601String(),
        'correctCount': correctCount,
        'incorrectCount': incorrectCount,
      };

  factory VocabularyItem.fromJson(Map<String, dynamic> json) => VocabularyItem(
        id: json['id'],
        word: json['word'],
        translation: json['translation'],
        phonetic: json['phonetic'],
        audioUrl: json['audioUrl'],
        imageUrl: json['imageUrl'],
        exampleSentence: json['exampleSentence'],
        exampleTranslation: json['exampleTranslation'],
        unitId: json['unitId'],
        lastReviewed: json['lastReviewed'] != null ? DateTime.parse(json['lastReviewed']) : null,
        reviewCount: json['reviewCount'] ?? 0,
        nextReview: json['nextReview'] != null ? DateTime.parse(json['nextReview']) : null,
        correctCount: json['correctCount'] ?? 0,
        incorrectCount: json['incorrectCount'] ?? 0,
      );

  VocabularyItem copyWith({
    DateTime? lastReviewed,
    int? reviewCount,
    DateTime? nextReview,
    int? correctCount,
    int? incorrectCount,
  }) {
    return VocabularyItem(
      id: id,
      word: word,
      translation: translation,
      phonetic: phonetic,
      audioUrl: audioUrl,
      imageUrl: imageUrl,
      exampleSentence: exampleSentence,
      exampleTranslation: exampleTranslation,
      unitId: unitId,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReview: nextReview ?? this.nextReview,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
    );
  }
}
