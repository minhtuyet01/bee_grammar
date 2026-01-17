import 'mock_test_data.dart';

/// Question Bank - Central repository for all test questions
/// Questions are categorized by topic and difficulty level
class QuestionBank {
  // All questions in the system
  static final List<TestQuestion> allQuestions = [
    // ============================================
    // CATEGORY 1: 12 Thì Cơ Bản (50 questions)
    // ============================================
    
    // Present Simple (10 questions)
    TestQuestion(
      id: 'cat1_ps_1',
      question: 'She ___ to school every day.',
      options: ['go', 'goes', 'going', 'gone'],
      correctAnswer: 1,
      explanation: 'Chủ ngữ "She" là ngôi thứ 3 số ít, động từ thêm "s". "Every day" là dấu hiệu của thì hiện tại đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_ps_2',
      question: 'They ___ football on weekends.',
      options: ['plays', 'play', 'playing', 'played'],
      correctAnswer: 1,
      explanation: 'Chủ ngữ "They" là số nhiều, động từ giữ nguyên. "On weekends" là dấu hiệu của thì hiện tại đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_ps_3',
      question: 'My brother ___ English very well.',
      options: ['speak', 'speaks', 'speaking', 'spoke'],
      correctAnswer: 1,
      explanation: 'Chủ ngữ "My brother" là ngôi thứ 3 số ít, động từ thêm "s".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_ps_4',
      question: 'I ___ coffee in the morning.',
      options: ['drinks', 'drink', 'drinking', 'drank'],
      correctAnswer: 1,
      explanation: 'Chủ ngữ "I" dùng với động từ nguyên mẫu không "s".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_ps_5',
      question: 'The sun ___ in the east.',
      options: ['rise', 'rises', 'rising', 'rose'],
      correctAnswer: 1,
      explanation: 'Sự thật hiển nhiên dùng thì hiện tại đơn. "The sun" là ngôi thứ 3 số ít.',
      category: 'cat_1',
      level: 'beginner',
    ),

    // Present Continuous (10 questions)
    TestQuestion(
      id: 'cat1_pc_1',
      question: 'She ___ TV right now.',
      options: ['watch', 'watches', 'is watching', 'watched'],
      correctAnswer: 2,
      explanation: '"Right now" là dấu hiệu của thì hiện tại tiếp diễn. Cấu trúc: am/is/are + V-ing.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_pc_2',
      question: 'They ___ their homework at the moment.',
      options: ['do', 'does', 'are doing', 'did'],
      correctAnswer: 2,
      explanation: '"At the moment" là dấu hiệu của thì hiện tại tiếp diễn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_pc_3',
      question: 'I ___ for the bus now.',
      options: ['wait', 'waits', 'am waiting', 'waited'],
      correctAnswer: 2,
      explanation: '"Now" là dấu hiệu của thì hiện tại tiếp diễn. Chủ ngữ "I" dùng với "am".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_pc_4',
      question: 'Look! The children ___ in the park.',
      options: ['play', 'plays', 'are playing', 'played'],
      correctAnswer: 2,
      explanation: '"Look!" là dấu hiệu của hành động đang diễn ra. Chủ ngữ số nhiều dùng "are".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_pc_5',
      question: 'He ___ to music at present.',
      options: ['listen', 'listens', 'is listening', 'listened'],
      correctAnswer: 2,
      explanation: '"At present" là dấu hiệu của thì hiện tại tiếp diễn.',
      category: 'cat_1',
      level: 'beginner',
    ),

    // Present Perfect (10 questions)
    TestQuestion(
      id: 'cat1_pp_1',
      question: 'I ___ this movie before.',
      options: ['see', 'saw', 'have seen', 'am seeing'],
      correctAnswer: 2,
      explanation: '"Before" là dấu hiệu của thì hiện tại hoàn thành. Cấu trúc: have/has + V3.',
      category: 'cat_1',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat1_pp_2',
      question: 'She ___ her homework yet.',
      options: ["doesn't finish", "didn't finish", "hasn't finished", "isn't finishing"],
      correctAnswer: 2,
      explanation: '"Yet" dùng trong câu phủ định của thì hiện tại hoàn thành.',
      category: 'cat_1',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat1_pp_3',
      question: 'They ___ in this city since 2010.',
      options: ['live', 'lived', 'have lived', 'are living'],
      correctAnswer: 2,
      explanation: '"Since + mốc thời gian" là dấu hiệu của thì hiện tại hoàn thành.',
      category: 'cat_1',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat1_pp_4',
      question: 'Have you ___ breakfast yet?',
      options: ['eat', 'ate', 'eaten', 'eating'],
      correctAnswer: 2,
      explanation: 'Câu hỏi thì hiện tại hoàn thành: Have/Has + S + V3?',
      category: 'cat_1',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat1_pp_5',
      question: 'We ___ each other for 5 years.',
      options: ['know', 'knew', 'have known', 'are knowing'],
      correctAnswer: 2,
      explanation: '"For + khoảng thời gian" là dấu hiệu của thì hiện tại hoàn thành.',
      category: 'cat_1',
      level: 'intermediate',
    ),

    // Past Simple (10 questions)
    TestQuestion(
      id: 'cat1_past_1',
      question: 'I ___ to the cinema yesterday.',
      options: ['go', 'goes', 'went', 'gone'],
      correctAnswer: 2,
      explanation: '"Yesterday" là dấu hiệu của thì quá khứ đơn. "Go" có dạng quá khứ bất quy tắc là "went".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_past_2',
      question: 'She ___ her keys last night.',
      options: ['lose', 'loses', 'lost', 'losing'],
      correctAnswer: 2,
      explanation: '"Last night" là dấu hiệu của thì quá khứ đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_past_3',
      question: 'They ___ the exam last week.',
      options: ['pass', 'passes', 'passed', 'passing'],
      correctAnswer: 2,
      explanation: '"Last week" là dấu hiệu của thì quá khứ đơn. Động từ có quy tắc thêm "-ed".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_past_4',
      question: 'We ___ a great time at the party.',
      options: ['have', 'has', 'had', 'having'],
      correctAnswer: 2,
      explanation: 'Hành động đã xảy ra và kết thúc trong quá khứ. "Have" có dạng quá khứ là "had".',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_past_5',
      question: 'He ___ his homework two hours ago.',
      options: ['finish', 'finishes', 'finished', 'finishing'],
      correctAnswer: 2,
      explanation: '"Ago" là dấu hiệu của thì quá khứ đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),

    // Future Simple (10 questions)
    TestQuestion(
      id: 'cat1_future_1',
      question: 'I ___ you tomorrow.',
      options: ['call', 'calls', 'will call', 'called'],
      correctAnswer: 2,
      explanation: '"Tomorrow" là dấu hiệu của thì tương lai đơn. Cấu trúc: will + V.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_future_2',
      question: 'She ___ 18 next month.',
      options: ['is', 'was', 'will be', 'has been'],
      correctAnswer: 2,
      explanation: '"Next month" là dấu hiệu của thì tương lai đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_future_3',
      question: 'They ___ the project next week.',
      options: ['start', 'starts', 'will start', 'started'],
      correctAnswer: 2,
      explanation: '"Next week" là dấu hiệu của thì tương lai đơn.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_future_4',
      question: 'We ___ to Paris this summer.',
      options: ['travel', 'travels', 'will travel', 'traveled'],
      correctAnswer: 2,
      explanation: '"This summer" chỉ thời gian trong tương lai.',
      category: 'cat_1',
      level: 'beginner',
    ),
    TestQuestion(
      id: 'cat1_future_5',
      question: 'It ___ rain later.',
      options: ['is', 'was', 'will', 'has'],
      correctAnswer: 2,
      explanation: 'Dự đoán về tương lai dùng "will".',
      category: 'cat_1',
      level: 'beginner',
    ),

    // ============================================
    // CATEGORY 2: Câu Điều Kiện (40 questions)
    // ============================================
    
    // Type 1 (15 questions)
    TestQuestion(
      id: 'cat2_cond1_1',
      question: 'If it ___ tomorrow, we will stay at home.',
      options: ['rain', 'rains', 'will rain', 'rained'],
      correctAnswer: 1,
      explanation: 'Câu điều kiện loại 1: If + S + V(s/es), S + will + V. Mệnh đề "if" dùng thì hiện tại đơn.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond1_2',
      question: 'If you study hard, you ___ the exam.',
      options: ['pass', 'passes', 'will pass', 'passed'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 1: Mệnh đề chính dùng "will + V".',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond1_3',
      question: 'She will be happy if you ___ her.',
      options: ['help', 'helps', 'will help', 'helped'],
      correctAnswer: 0,
      explanation: 'Mệnh đề "if" trong câu điều kiện loại 1 dùng thì hiện tại đơn.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond1_4',
      question: 'If they ___ early, they will catch the train.',
      options: ['leave', 'leaves', 'will leave', 'left'],
      correctAnswer: 0,
      explanation: 'Câu điều kiện loại 1 diễn tả điều có thể xảy ra trong tương lai.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond1_5',
      question: 'We ___ late if we don\'t hurry.',
      options: ['are', 'were', 'will be', 'have been'],
      correctAnswer: 2,
      explanation: 'Mệnh đề chính trong câu điều kiện loại 1 dùng "will + V".',
      category: 'cat_2',
      level: 'intermediate',
    ),

    // Type 2 (15 questions)
    TestQuestion(
      id: 'cat2_cond2_1',
      question: 'If I ___ rich, I would travel the world.',
      options: ['am', 'was', 'were', 'will be'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 2: If + S + V2/were, S + would + V. Dùng "were" cho tất cả các ngôi.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond2_2',
      question: 'She would buy a car if she ___ enough money.',
      options: ['have', 'has', 'had', 'will have'],
      correctAnswer: 2,
      explanation: 'Mệnh đề "if" trong câu điều kiện loại 2 dùng quá khứ đơn.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond2_3',
      question: 'If they ___ harder, they would succeed.',
      options: ['work', 'works', 'worked', 'will work'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 2 diễn tả điều không có thật ở hiện tại.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond2_4',
      question: 'I ___ you if I knew the answer.',
      options: ['tell', 'tells', 'would tell', 'will tell'],
      correctAnswer: 2,
      explanation: 'Mệnh đề chính trong câu điều kiện loại 2: S + would + V.',
      category: 'cat_2',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat2_cond2_5',
      question: 'If he ___ more time, he would help us.',
      options: ['have', 'has', 'had', 'will have'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 2 dùng quá khứ đơn trong mệnh đề "if".',
      category: 'cat_2',
      level: 'intermediate',
    ),

    // Type 3 (10 questions)
    TestQuestion(
      id: 'cat2_cond3_1',
      question: 'If I ___ harder, I would have passed the exam.',
      options: ['study', 'studied', 'had studied', 'have studied'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 3: If + S + had + V3, S + would have + V3. Diễn tả điều không có thật trong quá khứ.',
      category: 'cat_2',
      level: 'advanced',
    ),
    TestQuestion(
      id: 'cat2_cond3_2',
      question: 'She would have come if you ___ her.',
      options: ['invite', 'invited', 'had invited', 'have invited'],
      correctAnswer: 2,
      explanation: 'Mệnh đề "if" trong câu điều kiện loại 3 dùng quá khứ hoàn thành.',
      category: 'cat_2',
      level: 'advanced',
    ),
    TestQuestion(
      id: 'cat2_cond3_3',
      question: 'If they ___ the train, they wouldn\'t have been late.',
      options: ['catch', 'caught', 'had caught', 'have caught'],
      correctAnswer: 2,
      explanation: 'Câu điều kiện loại 3 diễn tả hối tiếc về quá khứ.',
      category: 'cat_2',
      level: 'advanced',
    ),

    // ============================================
    // CATEGORY 3: Câu Bị Động (40 questions)
    // ============================================
    
    TestQuestion(
      id: 'cat3_passive_1',
      question: 'The book ___ by millions of people.',
      options: ['reads', 'is read', 'was read', 'reading'],
      correctAnswer: 1,
      explanation: 'Câu bị động thì hiện tại đơn: am/is/are + V3. "The book" là số ít nên dùng "is".',
      category: 'cat_3',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat3_passive_2',
      question: 'The house ___ last year.',
      options: ['builds', 'is built', 'was built', 'building'],
      correctAnswer: 2,
      explanation: 'Câu bị động thì quá khứ đơn: was/were + V3. "Last year" là dấu hiệu quá khứ.',
      category: 'cat_3',
      level: 'intermediate',
    ),
    TestQuestion(
      id: 'cat3_passive_3',
      question: 'English ___ all over the world.',
      options: ['speaks', 'is spoken', 'was spoken', 'speaking'],
      correctAnswer: 1,
      explanation: 'Sự thật hiển nhiên dùng thì hiện tại đơn. Câu bị động: is + V3.',
      category: 'cat_3',
      level: 'intermediate',
    ),

    // Add more questions for other categories...
    // This is a starter set. You'll need to add more to reach 200 total.
  ];

  /// Get questions by category
  static List<TestQuestion> getByCategory(String categoryId) {
    return allQuestions
        .where((q) => q.category == categoryId)
        .toList();
  }

  /// Get questions by level
  static List<TestQuestion> getByLevel(String level) {
    return allQuestions
        .where((q) => q.level == level)
        .toList();
  }

  /// Get questions by multiple categories
  static List<TestQuestion> getByCategories(List<String> categoryIds) {
    return allQuestions
        .where((q) => categoryIds.contains(q.category))
        .toList();
  }

  /// Get random questions
  static List<TestQuestion> getRandom(int count) {
    final shuffled = List<TestQuestion>.from(allQuestions)..shuffle();
    return shuffled.take(count).toList();
  }

  /// Get question count by category
  static int getCountByCategory(String categoryId) {
    return allQuestions.where((q) => q.category == categoryId).length;
  }

  /// Get question count by level
  static int getCountByLevel(String level) {
    return allQuestions.where((q) => q.level == level).length;
  }
}
