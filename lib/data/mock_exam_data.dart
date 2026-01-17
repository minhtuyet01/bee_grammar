class MockExam {
  final String id;
  final String title;
  final String description;
  final int totalQuestions;
  final int timeLimit; // seconds
  final List<String> topics;
  final List<String> difficulty;
  final int order;

  const MockExam({
    required this.id,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.timeLimit,
    required this.topics,
    required this.difficulty,
    required this.order,
  });
}

class MockExamData {
  static const List<MockExam> exams = [
    MockExam(
      id: 'mock_1',
      title: 'Đề 1: Cơ bản A1-A2',
      description: 'Kiểm tra kiến thức ngữ pháp cơ bản cho người mới bắt đầu',
      totalQuestions: 20,
      timeLimit: 1800, // 30 minutes
      topics: ['cat_1', 'cat_2'],
      difficulty: ['easy', 'medium'],
      order: 1,
    ),
    MockExam(
      id: 'mock_2',
      title: 'Đề 2: Trung cấp B1',
      description: 'Kiểm tra kiến thức ngữ pháp trung cấp',
      totalQuestions: 25,
      timeLimit: 2400, // 40 minutes
      topics: ['cat_1', 'cat_2', 'cat_3'],
      difficulty: ['medium'],
      order: 2,
    ),
    MockExam(
      id: 'mock_3',
      title: 'Đề 3: Nâng cao B2',
      description: 'Kiểm tra kiến thức ngữ pháp nâng cao',
      totalQuestions: 30,
      timeLimit: 3000, // 50 minutes
      topics: ['cat_2', 'cat_3', 'cat_4'],
      difficulty: ['medium', 'hard'],
      order: 3,
    ),
    MockExam(
      id: 'mock_4',
      title: 'Đề 4: Tổng hợp A1-B1',
      description: 'Tổng hợp kiến thức từ cơ bản đến trung cấp',
      totalQuestions: 30,
      timeLimit: 2700, // 45 minutes
      topics: ['cat_1', 'cat_2', 'cat_3'],
      difficulty: ['easy', 'medium'],
      order: 4,
    ),
    MockExam(
      id: 'mock_5',
      title: 'Đề 5: Tổng hợp B1-B2',
      description: 'Tổng hợp kiến thức trung cấp và nâng cao',
      totalQuestions: 35,
      timeLimit: 3300, // 55 minutes
      topics: ['cat_2', 'cat_3', 'cat_4', 'cat_5'],
      difficulty: ['medium', 'hard'],
      order: 5,
    ),
    MockExam(
      id: 'mock_6',
      title: 'Đề 6: Toàn diện A1-C1',
      description: 'Kiểm tra toàn diện tất cả kiến thức ngữ pháp',
      totalQuestions: 40,
      timeLimit: 3600, // 60 minutes
      topics: ['cat_1', 'cat_2', 'cat_3', 'cat_4', 'cat_5'],
      difficulty: ['easy', 'medium', 'hard'],
      order: 6,
    ),
  ];

  static MockExam? getById(String id) {
    try {
      return exams.firstWhere((exam) => exam.id == id);
    } catch (e) {
      return null;
    }
  }
}
