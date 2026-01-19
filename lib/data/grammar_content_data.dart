import 'package:flutter/material.dart';
import '../models/grammar_lesson.dart';

/// Mock data for Grammar Content System
class GrammarContentData {
  // 5 Categories
  static List<GrammarCategory> getCategories() {
    return [
      const GrammarCategory(
        id: 'cat_1',
        title: 'I. Các Thì Trong Tiếng Anh',
        description: 'Dùng để xác định thời gian xảy ra của hành động hoặc trạng thái (quá khứ, hiện tại, tương lai) và mức độ hoàn thành của chúng.',
        icon: Icons.access_time,
        color: Colors.blue,
        order: 1,
        lessonIds: [
          'lesson_1', 'lesson_2', 'lesson_5', 'lesson_1_6', // Present
          'lesson_3', 'lesson_3_1', 'lesson_3_2', 'lesson_3_3', // Past
          'lesson_4', 'lesson_4_1', 'lesson_4_2', 'lesson_4_3', // Future
        ],
      ),
      const GrammarCategory(
        id: 'cat_2',
        title: 'II. Cấu Trúc Câu Trong Tiếng Anh',
        description: 'Dùng để sắp xếp từ đúng quy tắc nhằm diễn đạt ý nghĩa rõ ràng và chính xác.',
        icon: Icons.format_list_bulleted,
        color: Colors.green,
        order: 2,
        lessonIds: ['lesson_6', 'lesson_7', 'lesson_8', 'lesson_9', 'lesson_10', 'lesson_11', 'lesson_12', 'lesson_13'],
      ),
      const GrammarCategory(
        id: 'cat_3',
        title: 'III. Các Từ Loại',
        description: 'Dùng để xác định chức năng của từ trong câu, giúp câu đúng ngữ pháp và dễ hiểu.',
        icon: Icons.text_fields,
        color: Colors.orange,
        order: 3,
        lessonIds: ['lesson_14', 'lesson_15', 'lesson_16', 'lesson_17', 'lesson_18', 'lesson_19', 'lesson_20', 'lesson_21', 'lesson_22'],
      ),
      const GrammarCategory(
        id: 'cat_4',
        title: 'IV. Các Dạng Câu Hỏi',
        description: 'Dùng để hỏi thông tin, xác nhận, lựa chọn hoặc kiểm tra sự hiểu biết trong giao tiếp.',
        icon: Icons.star,
        color: Colors.purple,
        order: 4,
        lessonIds: ['lesson_23', 'lesson_24', 'lesson_25', 'lesson_26', 'lesson_27'],
      ),
      const GrammarCategory(
        id: 'cat_5',
        title: 'V. Cấu Trúc Ngữ Pháp Tiếng Anh Cơ Bản',
        description: 'Dùng để diễn đạt đúng ý nghĩa và cách dùng cố định của động từ, tính từ hoặc cụm từ trong câu.',
        icon: Icons.chat_bubble,
        color: Colors.teal,
        order: 5,
        lessonIds: ['lesson_28', 'lesson_29', 'lesson_30', 'lesson_31', 'lesson_32', 'lesson_33', 'lesson_34', 'lesson_35', 'lesson_36', 'lesson_37', 'lesson_38', 'lesson_39', 'lesson_40', 'lesson_41', 'lesson_42', 'lesson_43', 'lesson_44', 'lesson_45', 'lesson_46', 'lesson_47', 'lesson_48', 'lesson_49', 'lesson_50', 'lesson_51', 'lesson_52', 'lesson_53', 'lesson_54', 'lesson_55', 'lesson_56', 'lesson_57', 'lesson_58', 'lesson_59', 'lesson_60', 'lesson_61', 'lesson_62', 'lesson_63', 'lesson_64'],
      ),
    ];
  }

  // Get lessons by category
  static List<GrammarLesson> getLessonsByCategory(String categoryId) {
    final allLessons = getAllLessons();
    return allLessons.where((l) => l.categoryId == categoryId).toList();
  }

  // Get all 25 lessons
  static List<GrammarLesson> getAllLessons() {
    return [
      // CATEGORY 1: CÁC THÌ TRONG TIẾNG ANH
      // Present Tenses
      _createLesson1_PresentSimple(),
      _createLesson2_PresentContinuous(),
      _createLesson5_PresentPerfect(),
      _createLesson1_6_PresentPerfectContinuous(),
      
      // Past Tenses
      _createLesson3_PastSimple(),
      _createLesson3_1_PastContinuous(),
      _createLesson3_2_PastPerfect(),
      _createLesson3_3_PastPerfectContinuous(),
      
      // Future Tenses
      _createLesson4_Future(),
      _createLesson4_1_FutureContinuous(),
      _createLesson4_2_FuturePerfect(),
      _createLesson4_3_FuturePerfectContinuous(),
      
      // CATEGORY 2: CẤU TRÚC CÂU (8 bài mới)
      _createLesson6_Comparatives(),
      _createLesson7_Conditionals(),
      _createLesson8_WishSentences(),
      _createLesson9_ActivePassive(),
      _createLesson10_Subjunctive(),
      _createLesson11_Imperative(),
      _createLesson12_DirectIndirect(),
      _createLesson13_RelativeClauses(),
      
      // CATEGORY 3: CÁC TỪ LOẠI (9 bài mới)
      _createLesson14_Pronouns(),
      _createLesson15_Nouns(),
      _createLesson16_Adjectives(),
      _createLesson17_Verbs(),
      _createLesson18_Adverbs(),
      _createLesson19_Quantifiers(),
      _createLesson20_Prepositions(),
      _createLesson21_Articles(),
      _createLesson22_Conjunctions(),
      
      // CATEGORY 4: CÁC DẠNG CÂU HỎI (5 bài mới)
      _createLesson23_QuestionWords(),
      _createLesson24_WHQuestions(),
      _createLesson25_YesNoQuestions(),
      _createLesson26_ChoiceQuestions(),
      _createLesson27_TagQuestions(),
      
      // CATEGORY 5: CẤU TRÚC NGỮ PHÁP CƠ BẢN (37 bài mới)
      _createLesson28_Enough(),
      _createLesson29_Suggest(),
      _createLesson30_Hope(),
      _createLesson31_UsedTo(),
      _createLesson32_Mind(),
      _createLesson33_WouldYouLike(),
      _createLesson34_AsIfAsThough(),
      _createLesson35_Although(),
      _createLesson36_InSpiteOf(),
      _createLesson37_BecauseOf(),
      _createLesson38_SoSuchToo(),
      _createLesson39_AsWellAs(),
      _createLesson40_NotOnlyButAlso(),
      _createLesson41_WouldRather(),
      _createLesson42_Prefer(),
      _createLesson43_Refuse(),
      _createLesson44_Let(),
      _createLesson45_Lets(),
      _createLesson46_Difficult(),
      _createLesson47_Promise(),
      _createLesson48_Avoid(),
      _createLesson49_Advise(),
      _createLesson50_After(),
      _createLesson51_Asked(),
      _createLesson52_Enjoy(),
      _createLesson53_Must(),
      _createLesson54_AsMuchAs(),
      _createLesson55_WhenWhile(),
      _createLesson56_Find(),
      _createLesson57_Remember(),
      _createLesson58_Unless(),
      _createLesson59_HadBetter(),
      _createLesson60_Despite(),
      _createLesson61_ItWasNotUntil(),
      _createLesson62_Need(),
      _createLesson63_Regret(),
      _createLesson64_Stop(),
    ];
  }

  // LESSON 1: Present Simple
  static GrammarLesson _createLesson1_PresentSimple() {
    return const GrammarLesson(
      id: 'lesson_1',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Đơn (Present Simple)',
      objective: 'Học cách diễn tả thói quen, sự thật hiển nhiên và hành động lặp đi lặp lại',
      theory: 'Thì hiện tại đơn – Simple Present Tense dùng để diễn tả một hành động diễn ra lặp đi lặp lại theo thói quen, phong tục hay một sự thật hiển nhiên.',
      formulas: [
        '📌 ĐỘNG TỪ THƯỜNG:',
        '• Khẳng định: S + V(s/es) + O',
        '  Ví dụ: She goes to work at 7 am everyday.',
        '• Phủ định: S + do not (don\'t) / does not (doesn\'t) + V-infi',
        '  Ví dụ: I don\'t like to eat fish.',
        '• Nghi vấn: Do/Does + S + V-infi?',
        '  Ví dụ: Do you often play badminton?',
        '',
        '📌 ĐỘNG TỪ "TO BE":',
        '• Khẳng định: S + be (am/is/are) + O',
        '  Ví dụ: My mother is a teacher.',
        '• Phủ định: S + be (am/is/are) + not + O',
        '  Ví dụ: He is not a thief.',
        '• Nghi vấn: Am/Is/Are + S + O?',
        '  Ví dụ: Is he a doctor?',
      ],
      notes: null,
      usages: [
        'Diễn tả một chân lý, một sự thật',
        'Diễn tả một hành động thường xuyên xảy ra và một thói quen ở hiện tại',
        'Diễn tả một sự thật (tuổi tác, nghề nghiệp, đặc điểm, tính cách, cách sinh hoạt, thói quen, một khả năng) của một người hoặc vật',
        'Diễn tả một năng lực của con người',
        'Diễn tả một kế hoạch đã được sắp xếp cho tương lai (lịch tàu, xe, máy bay, lịch học, lịch trình du lịch)',
      ],
      examples: [
        GrammarExample(
          english: 'Washington DC is the capital of America.',
          vietnamese: 'Washington DC là thủ đô của Mỹ.',
          note: 'Chân lý, sự thật',
        ),
        GrammarExample(
          english: 'She drinks fruit juice everyday.',
          vietnamese: 'Cô ấy uống nước trái cây mỗi ngày.',
          note: 'Thói quen hàng ngày',
        ),
        GrammarExample(
          english: 'My grandmother is 75 years old.',
          vietnamese: 'Bà của tôi 75 tuổi.',
          note: 'Sự thật về tuổi tác',
        ),
        GrammarExample(
          english: 'He plays chess very well.',
          vietnamese: 'Anh ấy chơi cờ rất giỏi.',
          note: 'Năng lực',
        ),
        GrammarExample(
          english: 'Our appointment starts at 8 o\'clock.',
          vietnamese: 'Cuộc họp của chúng ta sẽ bắt đầu lúc 8 giờ.',
          note: 'Kế hoạch đã sắp xếp',
        ),
      ],
      recognitionSigns: [
        'Có các dạng động từ thường và "be" như trong các cấu trúc trên',
        'Chỉ thời gian: every day, every week, every weekend, every month, every year',
        'Chỉ tần suất: rarely, once/twice/three times/four times, sometimes, often, usually, always',
      ],
      commonMistakes: [
        '❌ He go to work → ✅ He goes to work (Thiếu s/es với ngôi thứ 3)',
        '❌ She don\'t like → ✅ She doesn\'t like (Dùng sai trợ động từ)',
        '❌ They goes → ✅ They go (Thêm s/es với số nhiều)',
        '❌ I am go → ✅ I go (Không dùng to be với động từ thường)',
      ],
      exercises: [
        // Multiple Choice - 4 câu
        GrammarExerciseItem(
          id: 'ex1_1',
          type: ExerciseType.multipleChoice,
          question: 'She _____ to school every day.',
          options: ['go', 'goes', 'going', 'to go'],
          correctAnswer: 'goes',
          explanation: 'Ngôi thứ 3 số ít: go → goes',
        ),
        GrammarExerciseItem(
          id: 'ex1_2',
          type: ExerciseType.multipleChoice,
          question: 'They _____ English.',
          options: ['speaks', 'speak', 'speaking', 'to speak'],
          correctAnswer: 'speak',
          explanation: 'Chủ ngữ số nhiều dùng động từ nguyên mẫu',
        ),
        GrammarExerciseItem(
          id: 'ex1_3',
          type: ExerciseType.multipleChoice,
          question: 'I _____ coffee every morning.',
          options: ['drink', 'drinks', 'drinking', 'am drink'],
          correctAnswer: 'drink',
          explanation: 'Chủ ngữ "I" dùng động từ nguyên mẫu',
        ),
        GrammarExerciseItem(
          id: 'ex1_4',
          type: ExerciseType.multipleChoice,
          question: 'He _____ in Hanoi.',
          options: ['live', 'lives', 'living', 'to live'],
          correctAnswer: 'lives',
          explanation: 'Ngôi thứ 3 số ít: live → lives',
        ),
        
        // Drag & Drop - 2 câu
        GrammarExerciseItem(
          id: 'ex1_5',
          type: ExerciseType.dragAndDrop,
          question: 'Sắp xếp thành câu đúng:',
          wordBank: ['She', 'goes', 'to', 'school', 'every', 'day'],
          correctAnswer: 'She goes to school every day',
          explanation: 'Thì hiện tại đơn: S + V(s/es)',
        ),
        GrammarExerciseItem(
          id: 'ex1_6',
          type: ExerciseType.dragAndDrop,
          question: 'Sắp xếp thành câu đúng:',
          wordBank: ['I', 'drink', 'coffee', 'every', 'morning'],
          correctAnswer: 'I drink coffee every morning',
          explanation: 'Thì hiện tại đơn với "I"',
        ),
        
        // Fill in the Blank - 1 câu
        GrammarExerciseItem(
          id: 'ex1_7',
          type: ExerciseType.fillInBlank,
          question: 'They _____ (live) in Hanoi.',
          correctAnswer: 'live',
          explanation: 'Số nhiều dùng động từ nguyên mẫu',
        ),
      ],
      order: 1,
    );
  }

  // LESSON 2: Present Continuous
  static GrammarLesson _createLesson2_PresentContinuous() {
    return const GrammarLesson(
      id: 'lesson_2',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Tiếp Diễn (Present Continuous)',
      objective: 'Học cách diễn tả hành động đang xảy ra tại thời điểm nói',
      theory: 'Thì hiện tại tiếp diễn – Present Continuous dùng để diễn tả những sự việc xảy ra ngay lúc chúng ta nói hay xung quanh thời điểm chúng ta nói và hành động đó vẫn chưa chấm dứt và còn tiếp tục xảy ra.',
      formulas: [
        '• Khẳng định: S + am/is/are + V-ing',
        '  Ví dụ: She is doing her homework now.',
        '• Phủ định: S + am/is/are + not + V-ing',
        '  Ví dụ: I am not going out tonight.',
        '• Nghi vấn: Am/Is/Are + S + V-ing?',
        '  Ví dụ: Is he studying English?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động đang diễn ra tại thời điểm nói',
        'Diễn tả hành động đang diễn ra xung quanh thời điểm nói nhưng không phải ngay tại thời điểm nói',
        'Diễn tả một hành động sẽ xảy ra ở trong tương lai gần',
        'Diễn tả một hành động thường xảy ra lặp đi lặp lại và được dùng với phó từ ALWAYS',
      ],
      examples: [
        GrammarExample(
          english: 'Our mother is doing her housework.',
          vietnamese: 'Mẹ của chúng tôi đang làm việc nhà.',
          note: 'Hành động đang xảy ra tại thời điểm nói',
        ),
        GrammarExample(
          english: 'I\'m reading a very good book these days.',
          vietnamese: 'Dạo này tôi đang đọc một cuốn sách rất hay.',
          note: 'Hành động xung quanh thời điểm nói',
        ),
        GrammarExample(
          english: 'We are working overtime tomorrow.',
          vietnamese: 'Ngày mai chúng tôi sẽ làm thêm giờ.',
          note: 'Hành động trong tương lai gần',
        ),
        GrammarExample(
          english: 'Merry is always forgetting to bring her document when she goes to school.',
          vietnamese: 'Merry luôn quên mang tài liệu học khi đến trường.',
          note: 'Hành động lặp lại với ALWAYS',
        ),
      ],
      recognitionSigns: [
        'Sở hữu cấu trúc "be + V-ing" với "be" được thay đổi theo chủ ngữ',
        'Các từ diễn tả tần suất dày đặc: always, constantly, all the time',
        'Những mốc thời gian trong tương lai, thường là mốc thời gian gần với thời điểm nói: this weekend, tonight, at the end of this year',
        'Các từ chỉ "hiện tại" (thời điểm nói): now, right now, at the/this moment',
        'Các từ chỉ khoảng thời gian xung quanh "hiện tại" (thời điểm nói): these days, currently, this week, this month',
      ],
      commonMistakes: [
        '❌ I am study → ✅ I am studying (Thiếu -ing)',
        '❌ She is cook → ✅ She is cooking',
        '❌ They is playing → ✅ They are playing (Sai to be)',
        '❌ He working → ✅ He is working (Thiếu to be)',
      ],
      exercises: [
        // Multiple Choice - 4 câu
        GrammarExerciseItem(
          id: 'ex2_1',
          type: ExerciseType.multipleChoice,
          question: 'She _____ a book now.',
          options: ['read', 'reads', 'is reading', 'was reading'],
          correctAnswer: 'is reading',
          explanation: 'Hiện tại tiếp diễn: am/is/are + V-ing',
        ),
        GrammarExerciseItem(
          id: 'ex2_2',
          type: ExerciseType.multipleChoice,
          question: 'They _____ football at the moment.',
          options: ['play', 'plays', 'are playing', 'were playing'],
          correctAnswer: 'are playing',
          explanation: 'Số nhiều: are + V-ing',
        ),
        GrammarExerciseItem(
          id: 'ex2_3',
          type: ExerciseType.multipleChoice,
          question: 'I _____ to music right now.',
          options: ['listen', 'listens', 'am listening', 'was listening'],
          correctAnswer: 'am listening',
          explanation: 'Chủ ngữ "I": am + V-ing',
        ),
        GrammarExerciseItem(
          id: 'ex2_4',
          type: ExerciseType.multipleChoice,
          question: 'He _____ TV now.',
          options: ['watch', 'watches', 'is watching', 'are watching'],
          correctAnswer: 'is watching',
          explanation: 'Ngôi thứ 3: is + V-ing',
        ),
        
        // Drag & Drop - 2 câu
        GrammarExerciseItem(
          id: 'ex2_5',
          type: ExerciseType.dragAndDrop,
          question: 'Sắp xếp thành câu đúng:',
          wordBank: ['She', 'is', 'reading', 'a', 'book', 'now'],
          correctAnswer: 'She is reading a book now',
          explanation: 'Hiện tại tiếp diễn: S + is + V-ing',
        ),
        GrammarExerciseItem(
          id: 'ex2_6',
          type: ExerciseType.dragAndDrop,
          question: 'Sắp xếp thành câu đúng:',
          wordBank: ['They', 'are', 'playing', 'football', 'now'],
          correctAnswer: 'They are playing football now',
          explanation: 'Số nhiều: are + V-ing',
        ),
        GrammarExerciseItem(
          id: 'ex2_7',
          type: ExerciseType.fillInBlank,
          question: 'We _____ (study) English now.',
          correctAnswer: 'are studying',
          explanation: 'Số nhiều: are + V-ing',
        ),
      ],
      order: 2,
    );
  }

  // Placeholder for remaining lessons (will create full content)
  static GrammarLesson _createLesson3_PastSimple() {
    return const GrammarLesson(
      id: 'lesson_3',
      categoryId: 'cat_1',
      title: 'Thì Quá Khứ Đơn (Past Simple)',
      objective: 'Học cách diễn tả hành động đã xảy ra và kết thúc trong quá khứ',
      theory: 'Thì quá khứ đơn – Simple Past Tense dùng để diễn tả một hành động, sự việc diễn ra và kết thúc trong quá khứ.',
      formulas: [
        '📌 ĐỘNG TỪ THƯỜNG:',
        '• Khẳng định: S + V2/ed + O',
        '  Ví dụ: She bought this dress yesterday.',
        '• Phủ định: S + did + not + V-infi + O',
        '  Ví dụ: I didn\'t leave the house last night.',
        '• Nghi vấn: Did + S + V-infi + O?',
        '  Ví dụ: Did you clean the house?',
        '',
        '📌 ĐỘNG TỪ "TO BE":',
        '• Khẳng định: S + was/were + O',
        '  Ví dụ: When I was a child, I used to read comic.',
        '• Phủ định: S + was/were + not + O',
        '  Ví dụ: The road was not clogged yesterday.',
        '• Nghi vấn: Was/Were + S + O?',
        '  Ví dụ: Were you happy with your exam last week?',
      ],
      notes: null,
      usages: [
        'Diễn tả hành động đã xảy ra và chấm dứt trong quá khứ',
        'Diễn tả một thói quen trong quá khứ, dùng với "used to"',
        'Dùng trong câu điều kiện loại 2 cho vế thứ nhất',
        'Diễn tả chuỗi hành động xảy ra liên tiếp',
      ],
      examples: [
        GrammarExample(
          english: 'I went to the theme park 3 days ago.',
          vietnamese: 'Tôi đi công viên giải trí cách đây 3 ngày.',
          note: 'Hành động đã kết thúc',
        ),
        GrammarExample(
          english: 'I used to participate in guitar club when I was young.',
          vietnamese: 'Lúc nhỏ tôi đã từng tham gia câu lạc bộ guitar.',
          note: 'Thói quen trong quá khứ',
        ),
        GrammarExample(
          english: 'If I was you, I would go to the dentist.',
          vietnamese: 'Nếu tôi là bạn, tôi sẽ đi nha sĩ.',
          note: 'Câu điều kiện loại 2',
        ),
        GrammarExample(
          english: 'I went home, opened the door and cooked the dinner.',
          vietnamese: 'Tôi về nhà, mở cửa và nấu một bữa ăn tối.',
          note: 'Chuỗi hành động liên tiếp',
        ),
      ],
      recognitionSigns: [
        'Có cụm từ chỉ thời gian trong quá khứ: yesterday, last week, last month, last year',
        'Dùng mệnh đề để chỉ một việc đã xảy ra trong quá khứ: When I graduated, When she visited the country',
      ],
      commonMistakes: [
        '❌ I go yesterday → ✅ I went yesterday',
        '❌ She didn\'t went → ✅ She didn\'t go',
        '❌ Did you went? → ✅ Did you go?',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex3_1', type: ExerciseType.multipleChoice, question: 'She _____ to school yesterday.', options: ['go','goes','went','gone'], correctAnswer: 'went', explanation: 'Quá khứ đơn: V2/ed'),
        GrammarExerciseItem(id: 'ex3_2', type: ExerciseType.multipleChoice, question: 'They _____ football last week.', options: ['play','plays','played','playing'], correctAnswer: 'played', explanation: 'Quá khứ đơn: V2/ed'),
        GrammarExerciseItem(id: 'ex3_3', type: ExerciseType.multipleChoice, question: 'I _____ a book yesterday.', options: ['read','reads','reading','to read'], correctAnswer: 'read', explanation: 'Quá khứ của read là read'),
        GrammarExerciseItem(id: 'ex3_4', type: ExerciseType.multipleChoice, question: 'He _____ TV last night.', options: ['watch','watches','watched','watching'], correctAnswer: 'watched', explanation: 'Quá khứ đơn: watched'),
        GrammarExerciseItem(id: 'ex3_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','went','to','school','yesterday'], correctAnswer: 'She went to school yesterday', explanation: 'Quá khứ đơn: S + V2/ed'),
        GrammarExerciseItem(id: 'ex3_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','played','football','last','week'], correctAnswer: 'I played football last week', explanation: 'Quá khứ đơn'),
        GrammarExerciseItem(id: 'ex3_7', type: ExerciseType.fillInBlank, question: 'They _____ (go) to the park yesterday.', correctAnswer: 'went', explanation: 'Quá khứ của go là went'),
      ],
      order: 3,
    );
  }

  static GrammarLesson _createLesson4_Future() {
    return const GrammarLesson(
      id: 'lesson_4',
      categoryId: 'cat_1',
      title: 'Thì Tương Lai Đơn (Future Simple)',
      objective: 'Học cách diễn tả hành động sẽ xảy ra trong tương lai',
      theory: 'Tương lai đơn – Simple Future được dùng khi không có kế hoạch hay quyết định làm gì nào trước khi chúng ta nói. Chúng ta quyết định tự phát tại thời điểm nói.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + will/shall + V-infi + O',
        '  Ví dụ: I believe John will be very successful.',
        '• Phủ định: S + will/shall + not + V-infi + O',
        '  Ví dụ: This table is very expensive. I will not buy it.',
        '• Nghi vấn: Will/Shall + S + V-infi + O?',
        '  Ví dụ: Will you buy these candies, mom?',
      ],
      notes: null,
      usages: [
        'Diễn tả một dự đoán không có căn cứ',
        'Diễn tả một quyết định, hoặc các kế hoạch được đưa ra ngay lập tức tại thời điểm nói',
        'Diễn tả một cảnh báo đe dọa',
        'Diễn tả một lời hứa sẽ làm gì hoặc không làm gì',
      ],
      examples: [
        GrammarExample(
          english: 'This cake tastes good! I will buy it for my son.',
          vietnamese: 'Cái bánh này ngon quá, tôi sẽ mua nó cho con trai tôi.',
          note: 'Quyết định tức thì',
        ),
        GrammarExample(
          english: 'I think that he will call me.',
          vietnamese: 'Tôi nghĩ anh ấy sẽ điện cho tôi.',
          note: 'Dự đoán không có căn cứ',
        ),
        GrammarExample(
          english: 'I believe John will be very successful.',
          vietnamese: 'Tôi tin John sẽ rất thành công.',
          note: 'Dự đoán',
        ),
      ],
      recognitionSigns: [
        'Trong câu có các từ như tomorrow, in + thời gian, next week, next month',
      ],
      commonMistakes: [
        '❌ I will going → ✅ I will go / I am going to go',
        '❌ She going to → ✅ She is going to',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex4_1', type: ExerciseType.multipleChoice, question: 'I _____ go to school tomorrow.', options: ['will','would','am','can'], correctAnswer: 'will', explanation: 'Tương lai: will + V'),
        GrammarExerciseItem(id: 'ex4_2', type: ExerciseType.multipleChoice, question: 'She _____ study English next week.', options: ['will','wills','is will','will to'], correctAnswer: 'will', explanation: 'Will + V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex4_3', type: ExerciseType.multipleChoice, question: 'They _____ going to visit Ha Long Bay.', options: ['is','am','are','be'], correctAnswer: 'are', explanation: 'Be going to: are'),
        GrammarExerciseItem(id: 'ex4_4', type: ExerciseType.multipleChoice, question: 'He _____ play football tomorrow.', options: ['will','wills','is','does'], correctAnswer: 'will', explanation: 'Will + V'),
        GrammarExerciseItem(id: 'ex4_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','will','go','to','school','tomorrow'], correctAnswer: 'I will go to school tomorrow', explanation: 'Tương lai: will + V'),
        GrammarExerciseItem(id: 'ex4_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','going','to','study','English'], correctAnswer: 'She is going to study English', explanation: 'Be going to'),
        GrammarExerciseItem(id: 'ex4_7', type: ExerciseType.fillInBlank, question: 'We _____ (visit) Hanoi next month.', correctAnswer: 'will visit', explanation: 'Will + V'),
      ],
      order: 4,
    );
  }

  // Past Continuous
  static GrammarLesson _createLesson3_1_PastContinuous() {
    return const GrammarLesson(
      id: 'lesson_3_1',
      categoryId: 'cat_1',
      title: 'Thì Quá Khứ Tiếp Diễn (Past Continuous)',
      objective: 'Học cách diễn tả hành động đang diễn ra tại một thời điểm trong quá khứ',
      theory: 'Thì quá khứ tiếp diễn – Past Continuous Tense dùng để diễn tả một hành động, sự việc đang diễn ra xung quanh một thời điểm trong quá khứ.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + was/were + V-ing',
        '  Ví dụ: I was studying at 8pm yesterday.',
        '• Phủ định: S + was/were + not + V-ing',
        '  Ví dụ: She wasn\'t sleeping at that time.',
        '• Nghi vấn: Was/Were + S + V-ing?',
        '  Ví dụ: Were you working at 9am?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động đang xảy ra thì bị một hành động khác cắt ngang',
        'Diễn tả hai hành động đang cùng diễn ra tại một thời điểm trong quá khứ',
        'Diễn tả một hành động đang diễn ra tại một thời điểm nhất định trong quá khứ',
      ],
      examples: [
        GrammarExample(
          english: 'While I was preparing for our project yesterday, my computer shut down.',
          vietnamese: 'Trong khi tôi đang chuẩn bị dự án hôm qua thì máy tính tắt.',
          note: 'Hành động bị cắt ngang',
        ),
        GrammarExample(
          english: 'I was sweeping the house while my sister was doing the laundry.',
          vietnamese: 'Tôi đang quét nhà trong khi chị tôi đang giặt quần áo.',
          note: 'Hai hành động cùng diễn ra',
        ),
        GrammarExample(
          english: 'At 8 a.m this morning, we were studying history.',
          vietnamese: 'Lúc 8 giờ sáng nay, chúng tôi đang học lịch sử.',
          note: 'Hành động tại thời điểm cụ thể',
        ),
      ],
      recognitionSigns: [
        'Câu chứa các cụm hoặc mệnh đề chỉ thời điểm trong quá khứ: last night, this morning, when she came, at 3am last Monday, at this time last night',
        'Câu phức 2 mệnh đề dùng với "while" hoặc "when"',
      ],
      commonMistakes: [
        '❌ I was study → ✅ I was studying (Thiếu -ing)',
        '❌ They was playing → ✅ They were playing (Sai to be)',
        '❌ She were cooking → ✅ She was cooking (Sai to be)',
        '❌ He working → ✅ He was working (Thiếu was)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex3_1_1', type: ExerciseType.multipleChoice, question: 'I _____ TV at 8pm yesterday.', options: ['watch','watched','was watching','were watching'], correctAnswer: 'was watching', explanation: 'Past Continuous: was/were + V-ing'),
        GrammarExerciseItem(id: 'ex3_1_2', type: ExerciseType.multipleChoice, question: 'They _____ football when it started raining.', options: ['play','played','was playing','were playing'], correctAnswer: 'were playing', explanation: 'Số nhiều: were + V-ing'),
        GrammarExerciseItem(id: 'ex3_1_3', type: ExerciseType.multipleChoice, question: 'She _____ dinner at 7pm.', options: ['cook','cooked','was cooking','were cooking'], correctAnswer: 'was cooking', explanation: 'Ngôi 3: was + V-ing'),
        GrammarExerciseItem(id: 'ex3_1_4', type: ExerciseType.multipleChoice, question: 'What _____ you doing at that time?', options: ['was','were','are','did'], correctAnswer: 'were', explanation: 'Câu hỏi: Were you...?'),
        GrammarExerciseItem(id: 'ex3_1_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','was','studying','at','8pm','yesterday'], correctAnswer: 'I was studying at 8pm yesterday', explanation: 'Was + V-ing'),
        GrammarExerciseItem(id: 'ex3_1_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['They','were','playing','football','when','it','rained'], correctAnswer: 'They were playing football when it rained', explanation: 'Were + V-ing'),
        GrammarExerciseItem(id: 'ex3_1_7', type: ExerciseType.fillInBlank, question: 'She _____ (cook) dinner at 7pm.', correctAnswer: 'was cooking', explanation: 'Was + V-ing'),
      ],
      order: 7,
    );
  }

  // Past Perfect
  static GrammarLesson _createLesson3_2_PastPerfect() {
    return const GrammarLesson(
      id: 'lesson_3_2',
      categoryId: 'cat_1',
      title: 'Thì Quá Khứ Hoàn Thành (Past Perfect)',
      objective: 'Học cách diễn tả hành động đã hoàn thành trước một thời điểm/hành động khác trong quá khứ',
      theory: 'Quá khứ hoàn thành – Past Perfect Tense dùng để diễn tả một hành động xảy ra trước một hành động khác trong quá khứ. Hành động nào xảy ra trước thì dùng thì quá khứ hoàn thành. Hành động xảy ra sau thì dùng thì quá khứ đơn.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + had + V3/ed',
        '  Ví dụ: I had finished my homework before dinner.',
        '• Phủ định: S + had + not + V3/ed',
        '  Ví dụ: She hadn\'t eaten breakfast before she left.',
        '• Nghi vấn: Had + S + V3/ed?',
        '  Ví dụ: Had you seen that movie before?',
      ],
      notes: null,
      usages: [
        'Diễn tả hành động xảy ra trước một hành động khác trong quá khứ',
        'Dùng trong câu điều kiện loại 3',
        'Diễn tả hành động đã hoàn thành trước một thời điểm trong quá khứ',
      ],
      examples: [
        GrammarExample(
          english: 'I had finished my homework before dinner.',
          vietnamese: 'Tôi đã hoàn thành bài tập trước bữa tối.',
          note: 'Hành động hoàn thành trước',
        ),
        GrammarExample(
          english: 'By 5pm yesterday, he had left his company.',
          vietnamese: 'Trước 5 giờ chiều hôm qua, anh ấy đã rời công ty.',
          note: 'Hoàn thành trước thời điểm',
        ),
        GrammarExample(
          english: 'If you had studied hard, you could have passed the exam.',
          vietnamese: 'Nếu bạn đã học chăm, bạn đã có thể qua kỳ thi.',
          note: 'Câu điều kiện loại 3',
        ),
        GrammarExample(
          english: 'She had already eaten when I arrived.',
          vietnamese: 'Cô ấy đã ăn rồi khi tôi đến.',
          note: 'Hành động trước hành động khác',
        ),
      ],
      recognitionSigns: [
        'Câu có dạng câu phức với: một mệnh đề dùng thì quá khứ hoàn thành, một mệnh đề dùng quá khứ đơn',
        'Các liên từ chỉ thời gian: before, after, by the time, as soon as, until then',
      ],
      commonMistakes: [
        '❌ I had went → ✅ I had gone (Sai dạng V3)',
        '❌ She have finished → ✅ She had finished (Sai trợ động từ)',
        '❌ They had ate → ✅ They had eaten (Sai V3)',
        '❌ He finished before I had arrived → ✅ He had finished before I arrived (Sai thứ tự thì)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex3_2_1', type: ExerciseType.multipleChoice, question: 'I _____ my homework before dinner.', options: ['finish','finished','had finished','have finished'], correctAnswer: 'had finished', explanation: 'Past Perfect: had + V3'),
        GrammarExerciseItem(id: 'ex3_2_2', type: ExerciseType.multipleChoice, question: 'She _____ already left when I arrived.', options: ['has','have','had','did'], correctAnswer: 'had', explanation: 'Had + V3'),
        GrammarExerciseItem(id: 'ex3_2_3', type: ExerciseType.multipleChoice, question: 'They _____ eaten before the party started.', options: ['has','have','had','did'], correctAnswer: 'had', explanation: 'Had + V3'),
        GrammarExerciseItem(id: 'ex3_2_4', type: ExerciseType.multipleChoice, question: 'By the time we arrived, the movie _____ started.', options: ['has','have','had','did'], correctAnswer: 'had', explanation: 'By the time + Past Perfect'),
        GrammarExerciseItem(id: 'ex3_2_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','had','finished','my','homework','before','dinner'], correctAnswer: 'I had finished my homework before dinner', explanation: 'Had + V3'),
        GrammarExerciseItem(id: 'ex3_2_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','had','left','when','I','arrived'], correctAnswer: 'She had left when I arrived', explanation: 'Had + V3'),
        GrammarExerciseItem(id: 'ex3_2_7', type: ExerciseType.fillInBlank, question: 'They _____ (eat) before the party started.', correctAnswer: 'had eaten', explanation: 'Had + V3'),
      ],
      order: 8,
    );
  }

  // Past Perfect Continuous
  static GrammarLesson _createLesson3_3_PastPerfectContinuous() {
    return const GrammarLesson(
      id: 'lesson_3_3',
      categoryId: 'cat_1',
      title: 'Thì Quá Khứ Hoàn Thành Tiếp Diễn (Past Perfect Continuous)',
      objective: 'Học cách diễn tả hành động đã và đang diễn ra trước một thời điểm trong quá khứ',
      theory: 'Quá khứ hoàn thành tiếp diễn – Past Perfect Continuous Tense dùng để diễn tả một hành động, sự việc đã đang xảy ra trong quá khứ và kết thúc trước một hành động cũng xảy ra trong quá khứ.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + had + been + V-ing',
        '  Ví dụ: I had been working for 2 hours before lunch.',
        '• Phủ định: S + had + not + been + V-ing',
        '  Ví dụ: She hadn\'t been studying before the test.',
        '• Nghi vấn: Had + S + been + V-ing?',
        '  Ví dụ: Had you been waiting long?',
      ],
      notes: null,
      usages: [
        'Diễn tả hành động xảy ra và kéo dài liên tục trước một thời điểm được xác định trong quá khứ',
        'Diễn tả hành động xảy ra và liên tục trước một hành động khác trong quá khứ',
        'Nhấn mạnh tính liên tục của hành động trong quá khứ',
      ],
      examples: [
        GrammarExample(
          english: 'My wife and I had been quarreling for an hour until 7pm.',
          vietnamese: 'Vợ chồng tôi đã cãi nhau được một tiếng cho đến 7 giờ tối.',
          note: 'Hành động liên tục đến thời điểm',
        ),
        GrammarExample(
          english: 'I had been eating candy until my teacher saw me.',
          vietnamese: 'Tôi đã ăn kẹo cho đến khi giáo viên nhìn thấy.',
          note: 'Hành động liên tục đến khi bị cắt ngang',
        ),
        GrammarExample(
          english: 'They had been playing for 30 minutes before it rained.',
          vietnamese: 'Họ đã chơi được 30 phút trước khi trời mưa.',
          note: 'Nhấn mạnh thời gian liên tục',
        ),
      ],
      recognitionSigns: [
        'Trong câu có các từ như by the time, until then, prior to that time, before, after',
        'Có khoảng thời gian với "for" hoặc "since"',
      ],
      commonMistakes: [
        '❌ I had been work → ✅ I had been working (Thiếu -ing)',
        '❌ She has been studying → ✅ She had been studying (Sai thì)',
        '❌ They had been ate → ✅ They had been eating (Sai dạng động từ)',
        '❌ He been working → ✅ He had been working (Thiếu had)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex3_3_1', type: ExerciseType.multipleChoice, question: 'I _____ for 2 hours before lunch.', options: ['work','had worked','had been working','have been working'], correctAnswer: 'had been working', explanation: 'Past Perfect Continuous: had been + V-ing'),
        GrammarExerciseItem(id: 'ex3_3_2', type: ExerciseType.multipleChoice, question: 'She _____ English for 3 years before she moved.', options: ['study','had studied','had been studying','has been studying'], correctAnswer: 'had been studying', explanation: 'Had been + V-ing'),
        GrammarExerciseItem(id: 'ex3_3_3', type: ExerciseType.multipleChoice, question: 'They _____ for an hour when I arrived.', options: ['wait','had waited','had been waiting','have been waiting'], correctAnswer: 'had been waiting', explanation: 'Had been + V-ing'),
        GrammarExerciseItem(id: 'ex3_3_4', type: ExerciseType.multipleChoice, question: 'How long _____ you been working before you quit?', options: ['has','have','had','did'], correctAnswer: 'had', explanation: 'Câu hỏi: Had you been...?'),
        GrammarExerciseItem(id: 'ex3_3_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','had','been','working','for','2','hours','before','lunch'], correctAnswer: 'I had been working for 2 hours before lunch', explanation: 'Had been + V-ing'),
        GrammarExerciseItem(id: 'ex3_3_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','had','been','studying','when','I','called'], correctAnswer: 'She had been studying when I called', explanation: 'Had been + V-ing'),
        GrammarExerciseItem(id: 'ex3_3_7', type: ExerciseType.fillInBlank, question: 'They _____ (wait) for an hour when I arrived.', correctAnswer: 'had been waiting', explanation: 'Had been + V-ing'),
      ],
      order: 9,
    );
  }

  // Present Perfect Continuous (moved here)
  static GrammarLesson _createLesson1_6_PresentPerfectContinuous() {
    return const GrammarLesson(
      id: 'lesson_1_6',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Hoàn Thành Tiếp Diễn (Present Perfect Continuous)',
      objective: 'Học cách diễn tả hành động bắt đầu trong quá khứ, vẫn đang tiếp diễn và nhấn mạnh tính liên tục',
      theory: 'Thì hiện tại hoàn thành tiếp diễn – Present Perfect Continuous Tense là thì diễn tả sự việc bắt đầu trong quá khứ và tiếp tục ở hiện tại có thể tiếp diễn ở tương lai sự việc đã kết thúc nhưng ảnh hưởng kết quả còn lưu lại hiện tại.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + have/has + been + V-ing',
        '  Ví dụ: I have been learning English for 12 years.',
        '• Phủ định: S + have/has + not + been + V-ing',
        '  Ví dụ: July hasn\'t been driving a car for 2 years.',
        '• Nghi vấn: Have/Has + S + been + V-ing?',
        '  Ví dụ: Have you been running all day?',
      ],
      notes: null,
      usages: [
        'Dùng để nhấn mạnh tính liên tục của một sự việc bắt đầu từ quá khứ và tiếp diễn đến hiện tại, ngụ ý hành động này gần như chưa từng bị ngắt quãng',
        'Diễn tả hành động bắt đầu rồi kéo dài trong quá khứ và vừa mới kết thúc ngay trước hiện tại nhưng hậu quả hay tác động của nó vẫn còn lại ở hiện tại',
      ],
      examples: [
        GrammarExample(
          english: 'My father have been working since 7 a.m. Now, he must be tired and hungry.',
          vietnamese: 'Ba của tôi làm việc suốt từ 7 giờ sáng. Bây giờ, ông ấy chắc rất mệt và đói bụng.',
          note: 'Nhấn mạnh tính liên tục',
        ),
        GrammarExample(
          english: 'It has been raining for 5 hours straight. It has just stopped and most of the streets are flooded now.',
          vietnamese: 'Trời mưa liên tục 5 tiếng. Vừa mới tạnh và hầu hết các đường phố đều ngập.',
          note: 'Hành động vừa kết thúc, hậu quả còn lại',
        ),
      ],
      recognitionSigns: [
        'Trong câu thường có các từ sau: already, just, not..yet, never, ever, since, for, so far, until now, recently, before',
      ],
      commonMistakes: [
        '❌ I have been work → ✅ I have been working (Thiếu -ing)',
        '❌ She has been studied → ✅ She has been studying',
        '❌ They has been playing → ✅ They have been playing (Sai trợ động từ)',
        '❌ He been working → ✅ He has been working (Thiếu has)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex1_6_1', type: ExerciseType.multipleChoice, question: 'I _____ English for 3 hours.', options: ['study','have studied','have been studying','has been studying'], correctAnswer: 'have been studying', explanation: 'Present Perfect Continuous: have been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_2', type: ExerciseType.multipleChoice, question: 'She _____ here since morning.', options: ['wait','has waited','has been waiting','have been waiting'], correctAnswer: 'has been waiting', explanation: 'Ngôi 3: has been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_3', type: ExerciseType.multipleChoice, question: 'They _____ football all day.', options: ['play','have played','have been playing','has been playing'], correctAnswer: 'have been playing', explanation: 'Số nhiều: have been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_4', type: ExerciseType.multipleChoice, question: 'How long _____ you been working here?', options: ['has','have','are','do'], correctAnswer: 'have', explanation: 'Câu hỏi: Have you been...?'),
        GrammarExerciseItem(id: 'ex1_6_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','been','studying','English','for','3','hours'], correctAnswer: 'I have been studying English for 3 hours', explanation: 'Have been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','has','been','waiting','since','morning'], correctAnswer: 'She has been waiting since morning', explanation: 'Has been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_7', type: ExerciseType.fillInBlank, question: 'They _____ (play) football all day.', correctAnswer: 'have been playing', explanation: 'Have been + V-ing'),
      ],
      order: 6,
    );
  }

  // Future Continuous
  static GrammarLesson _createLesson4_1_FutureContinuous() {
    return const GrammarLesson(
      id: 'lesson_4_1',
      categoryId: 'cat_1',
      title: 'Thì Tương Lai Tiếp Diễn (Future Continuous)',
      objective: 'Học cách diễn tả hành động sẽ đang diễn ra tại một thời điểm trong tương lai',
      theory: 'Tương lai tiếp diễn – Future Continuous Tense dùng để diễn tả một hành động, sự việc sẽ đang diễn ra tại một thời điểm cụ thể trong tương lai.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + will + be + V-ing',
        '  Ví dụ: I will be studying at 8pm tomorrow.',
        '• Phủ định: S + will + not + be + V-ing',
        '  Ví dụ: She won\'t be working next week.',
        '• Nghi vấn: Will + S + be + V-ing?',
        '  Ví dụ: Will you be sleeping at midnight?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động xảy ra trong tương lai tại thời điểm được xác định',
        'Diễn tả về một hành động đang xảy ra trong tương lai thì có hành động khác chen vào',
        'Diễn tả một hành động sẽ đang diễn ra trong một khoảng thời gian ở tương lai',
      ],
      examples: [
        GrammarExample(
          english: 'I will be visiting Hanoi at this time next Saturday.',
          vietnamese: 'Vào giờ này thứ Bảy tới, tôi sẽ đang thăm Hà Nội.',
          note: 'Hành động tại thời điểm cụ thể',
        ),
        GrammarExample(
          english: 'I will be waiting for you when the bus comes.',
          vietnamese: 'Tôi sẽ đang đợi bạn khi xe buýt đến.',
          note: 'Hành động đang diễn ra khi có hành động khác',
        ),
        GrammarExample(
          english: 'This time tomorrow, we will be flying to Paris.',
          vietnamese: 'Vào giờ này ngày mai, chúng ta sẽ đang bay đến Paris.',
          note: 'Hành động trong khoảng thời gian',
        ),
      ],
      recognitionSigns: [
        'Trong câu thường có các cụm từ: at this time tomorrow, next week, in the future, at 8pm tomorrow',
        'Có mốc thời gian cụ thể trong tương lai',
      ],
      commonMistakes: [
        '❌ I will be study → ✅ I will be studying (Thiếu -ing)',
        '❌ She will being working → ✅ She will be working (Sai cấu trúc)',
        '❌ They will are playing → ✅ They will be playing (Sai to be)',
        '❌ He be working → ✅ He will be working (Thiếu will)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex4_1_1', type: ExerciseType.multipleChoice, question: 'I _____ at 8pm tomorrow.', options: ['study','will study','will be studying','will studying'], correctAnswer: 'will be studying', explanation: 'Future Continuous: will be + V-ing'),
        GrammarExerciseItem(id: 'ex4_1_2', type: ExerciseType.multipleChoice, question: 'They _____ football at this time next week.', options: ['play','will play','will be playing','will playing'], correctAnswer: 'will be playing', explanation: 'Will be + V-ing'),
        GrammarExerciseItem(id: 'ex4_1_3', type: ExerciseType.multipleChoice, question: 'She _____ dinner at 7pm.', options: ['cook','will cook','will be cooking','will cooking'], correctAnswer: 'will be cooking', explanation: 'Will be + V-ing'),
        GrammarExerciseItem(id: 'ex4_1_4', type: ExerciseType.multipleChoice, question: '_____ you be working tomorrow?', options: ['Do','Does','Will','Are'], correctAnswer: 'Will', explanation: 'Câu hỏi: Will you be...?'),
        GrammarExerciseItem(id: 'ex4_1_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','will','be','studying','at','8pm','tomorrow'], correctAnswer: 'I will be studying at 8pm tomorrow', explanation: 'Will be + V-ing'),
        GrammarExerciseItem(id: 'ex4_1_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['They','will','be','playing','football','next','week'], correctAnswer: 'They will be playing football next week', explanation: 'Will be + V-ing'),
        GrammarExerciseItem(id: 'ex4_1_7', type: ExerciseType.fillInBlank, question: 'She _____ (cook) dinner at 7pm.', correctAnswer: 'will be cooking', explanation: 'Will be + V-ing'),
      ],
      order: 10,
    );
  }

  // Future Perfect
  static GrammarLesson _createLesson4_2_FuturePerfect() {
    return const GrammarLesson(
      id: 'lesson_4_2',
      categoryId: 'cat_1',
      title: 'Thì Tương Lai Hoàn Thành (Future Perfect)',
      objective: 'Học cách diễn tả hành động sẽ hoàn thành trước một thời điểm trong tương lai',
      theory: 'Tương lai hoàn thành – Future Perfect Tense dùng để diễn tả một hành động hay sự việc hoàn thành trước một thời điểm tương lai.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + will + have + V3/ed',
        '  Ví dụ: I will have finished by 5pm.',
        '• Phủ định: S + will + not + have + V3/ed',
        '  Ví dụ: She won\'t have completed the project.',
        '• Nghi vấn: Will + S + have + V3/ed?',
        '  Ví dụ: Will you have finished by then?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động trong tương lai sẽ kết thúc trước 1 hành động khác trong tương lai',
        'Diễn tả một hành động sẽ hoàn thành trước một thời điểm cụ thể trong tương lai',
        'Dự đoán một hành động sẽ hoàn thành vào một thời điểm trong tương lai',
      ],
      examples: [
        GrammarExample(
          english: 'She will have finished her homework before 9pm this evening.',
          vietnamese: 'Cô ấy sẽ hoàn thành bài tập trước 9 giờ tối nay.',
          note: 'Hoàn thành trước thời điểm',
        ),
        GrammarExample(
          english: 'By the end of this year, I will have learned English for 5 years.',
          vietnamese: 'Đến cuối năm nay, tôi sẽ học tiếng Anh được 5 năm.',
          note: 'Hoàn thành đến thời điểm',
        ),
        GrammarExample(
          english: 'They will have left by the time you arrive.',
          vietnamese: 'Họ sẽ đã rời đi trước khi bạn đến.',
          note: 'Hoàn thành trước hành động khác',
        ),
      ],
      recognitionSigns: [
        'Trong câu chứa by the time, by the end of + thời gian tương lai',
        'Có các cụm từ: by next week, by tomorrow, by 5pm',
      ],
      commonMistakes: [
        '❌ I will have finish → ✅ I will have finished (Thiếu V3)',
        '❌ She will has finished → ✅ She will have finished (Sai trợ động từ)',
        '❌ They will have went → ✅ They will have gone (Sai V3)',
        '❌ He have finished → ✅ He will have finished (Thiếu will)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex4_2_1', type: ExerciseType.multipleChoice, question: 'I _____ my homework by 5pm.', options: ['finish','will finish','will have finished','will have finish'], correctAnswer: 'will have finished', explanation: 'Future Perfect: will have + V3'),
        GrammarExerciseItem(id: 'ex4_2_2', type: ExerciseType.multipleChoice, question: 'She _____ the project by next week.', options: ['complete','will complete','will have completed','will has completed'], correctAnswer: 'will have completed', explanation: 'Will have + V3'),
        GrammarExerciseItem(id: 'ex4_2_3', type: ExerciseType.multipleChoice, question: 'They _____ by the time we arrive.', options: ['leave','will leave','will have left','will has left'], correctAnswer: 'will have left', explanation: 'Will have + V3'),
        GrammarExerciseItem(id: 'ex4_2_4', type: ExerciseType.multipleChoice, question: '_____ you have finished by tomorrow?', options: ['Do','Does','Will','Are'], correctAnswer: 'Will', explanation: 'Câu hỏi: Will you have...?'),
        GrammarExerciseItem(id: 'ex4_2_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','will','have','finished','by','5pm'], correctAnswer: 'I will have finished by 5pm', explanation: 'Will have + V3'),
        GrammarExerciseItem(id: 'ex4_2_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','will','have','completed','the','project','by','next','week'], correctAnswer: 'She will have completed the project by next week', explanation: 'Will have + V3'),
        GrammarExerciseItem(id: 'ex4_2_7', type: ExerciseType.fillInBlank, question: 'They _____ (leave) by the time we arrive.', correctAnswer: 'will have left', explanation: 'Will have + V3'),
      ],
      order: 11,
    );
  }

  // Future Perfect Continuous
  static GrammarLesson _createLesson4_3_FuturePerfectContinuous() {
    return const GrammarLesson(
      id: 'lesson_4_3',
      categoryId: 'cat_1',
      title: 'Thì Tương Lai Hoàn Thành Tiếp Diễn (Future Perfect Continuous)',
      objective: 'Học cách diễn tả hành động sẽ đã và đang diễn ra trước một thời điểm trong tương lai',
      theory: 'Tương lai hoàn thành tiếp diễn – Future Perfect Continuous Tense dùng để diễn tả một hành động, sự việc sẽ xảy ra và xảy ra liên tục trước một thời điểm nào đó trong tương lai.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + will + have + been + V-ing',
        '  Ví dụ: I will have been working for 2 hours by 5pm.',
        '• Phủ định: S + will + not + have + been + V-ing',
        '  Ví dụ: She won\'t have been studying for long.',
        '• Nghi vấn: Will + S + have + been + V-ing?',
        '  Ví dụ: Will you have been waiting long?',
      ],
      notes: null,
      usages: [
        'Nhấn mạnh khoảng thời gian của một hành động đang xảy ra trong tương lai và sẽ kết thúc trước một hành động khác trong tương lai',
        'Diễn tả một hành động sẽ đang diễn ra liên tục cho đến một thời điểm trong tương lai',
        'Dùng để nhấn mạnh tính liên tục của hành động trong tương lai',
      ],
      examples: [
        GrammarExample(
          english: 'I will have been studying English for 5 years by the end of next week.',
          vietnamese: 'Đến cuối tuần sau, tôi sẽ học tiếng Anh được 5 năm.',
          note: 'Nhấn mạnh khoảng thời gian',
        ),
        GrammarExample(
          english: 'By 2025, she will have been working here for 10 years.',
          vietnamese: 'Đến năm 2025, cô ấy sẽ làm việc ở đây được 10 năm.',
          note: 'Hành động liên tục đến thời điểm',
        ),
        GrammarExample(
          english: 'They will have been playing for 3 hours by the time we arrive.',
          vietnamese: 'Họ sẽ chơi được 3 tiếng khi chúng ta đến.',
          note: 'Liên tục đến khi có hành động khác',
        ),
      ],
      recognitionSigns: [
        'Trong câu có by the time, for + khoảng thời gian',
        'Có các cụm từ: by next year, by the end of, for 5 years',
      ],
      commonMistakes: [
        '❌ I will have been work → ✅ I will have been working (Thiếu -ing)',
        '❌ She will has been studying → ✅ She will have been studying (Sai trợ động từ)',
        '❌ They will have be playing → ✅ They will have been playing (Sai cấu trúc)',
        '❌ He have been working → ✅ He will have been working (Thiếu will)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex4_3_1', type: ExerciseType.multipleChoice, question: 'I _____ for 2 hours by 5pm.', options: ['work','will work','will have been working','will have working'], correctAnswer: 'will have been working', explanation: 'Future Perfect Continuous: will have been + V-ing'),
        GrammarExerciseItem(id: 'ex4_3_2', type: ExerciseType.multipleChoice, question: 'She _____ English for 5 years by next month.', options: ['study','will study','will have been studying','will has been studying'], correctAnswer: 'will have been studying', explanation: 'Will have been + V-ing'),
        GrammarExerciseItem(id: 'ex4_3_3', type: ExerciseType.multipleChoice, question: 'They _____ for 3 hours when we arrive.', options: ['play','will play','will have been playing','will has been playing'], correctAnswer: 'will have been playing', explanation: 'Will have been + V-ing'),
        GrammarExerciseItem(id: 'ex4_3_4', type: ExerciseType.multipleChoice, question: '_____ you have been working long?', options: ['Do','Does','Will','Are'], correctAnswer: 'Will', explanation: 'Câu hỏi: Will you have been...?'),
        GrammarExerciseItem(id: 'ex4_3_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','will','have','been','working','for','2','hours','by','5pm'], correctAnswer: 'I will have been working for 2 hours by 5pm', explanation: 'Will have been + V-ing'),
        GrammarExerciseItem(id: 'ex4_3_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','will','have','been','studying','for','5','years'], correctAnswer: 'She will have been studying for 5 years', explanation: 'Will have been + V-ing'),
        GrammarExerciseItem(id: 'ex4_3_7', type: ExerciseType.fillInBlank, question: 'They _____ (play) for 3 hours when we arrive.', correctAnswer: 'will have been playing', explanation: 'Will have been + V-ing'),
      ],
      order: 12,
    );
  }

  static GrammarLesson _createLesson5_PresentPerfect() {
    return const GrammarLesson(
      id: 'lesson_5',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Hoàn Thành (Present Perfect)',
      objective: 'Học cách diễn tả hành động đã xảy ra nhưng còn liên quan đến hiện tại',
      theory: 'Thì hiện tại hoàn thành – Present Perfect Tense là thì dùng để diễn tả một sự việc, một hành động đã bắt đầu từ trong quá khứ, kéo dài đến hiện tại và có thể tiếp tục diễn ra trong tương lai.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + have/has + V3/ed + O',
        '  Ví dụ: He has lived in Paris for ten years.',
        '• Phủ định: S + have/has + not + V3/ed',
        '  Ví dụ: He hasn\'t completed the assigned work.',
        '• Nghi vấn: Have/Has + S + V3/ed + O?',
        '  Ví dụ: Have you ever visited Vietnam?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động xảy ra trong quá khứ nhưng vẫn còn ở hiện tại và tương lai. Diễn tả sự lặp đi lặp lại của một hành động trong quá khứ. Thường dùng với từ "since" và "for"',
        'Diễn tả một hành động xảy ra và kết thúc trong quá khứ nhưng không nói rõ thời gian xảy ra',
        'Diễn tả một hành động vừa mới xảy ra',
        'Nói về kinh nghiệm hoặc trải nghiệm',
      ],
      examples: [
        GrammarExample(
          english: 'I have been an engineer since 2015.',
          vietnamese: 'Tôi là một kỹ sư từ năm 2015.',
          note: 'Hành động từ quá khứ đến hiện tại',
        ),
        GrammarExample(
          english: 'My sister has lost her key.',
          vietnamese: 'Em gái tôi đã làm mất chìa khóa.',
          note: 'Không nói rõ thời gian xảy ra',
        ),
        GrammarExample(
          english: 'I have just broken up with my girlfriend for 10 minutes.',
          vietnamese: 'Tôi vừa mới chia tay bạn gái được 10 phút.',
          note: 'Vừa mới xảy ra',
        ),
        GrammarExample(
          english: 'My summer vacation last year has been the best one I have ever had.',
          vietnamese: 'Kỳ nghỉ hè năm ngoái của tôi là một kỳ nghỉ tốt nhất mà tôi từng có.',
          note: 'Kinh nghiệm, trải nghiệm',
        ),
      ],
      recognitionSigns: [
        'Động từ nằm trong cấu trúc V3/Ved',
        'Thường có các từ sau: already, just, not..yet, never, ever, since, for, so far, until now, recently, before',
      ],
      commonMistakes: [
        '❌ I have go → ✅ I have gone (Thiếu V3)',
        '❌ She have seen → ✅ She has seen (Sai trợ động từ)',
        '❌ I have seen him yesterday → ✅ I saw him yesterday (Không dùng thời gian cụ thể)',
        '❌ He has went → ✅ He has gone (Sai dạng V3)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex5_1', type: ExerciseType.multipleChoice, question: 'I _____ English for 5 years.', options: ['learn','learns','have learned','has learned'], correctAnswer: 'have learned', explanation: 'Present Perfect: have + V3'),
        GrammarExerciseItem(id: 'ex5_2', type: ExerciseType.multipleChoice, question: 'She _____ that movie.', options: ['see','sees','have seen','has seen'], correctAnswer: 'has seen', explanation: 'Ngôi 3: has + V3'),
        GrammarExerciseItem(id: 'ex5_3', type: ExerciseType.multipleChoice, question: 'They _____ to Japan.', options: ['go','goes','have been','has been'], correctAnswer: 'have been', explanation: 'Số nhiều: have + V3'),
        GrammarExerciseItem(id: 'ex5_4', type: ExerciseType.multipleChoice, question: 'He _____ his homework.', options: ['finish','finishes','have finished','has finished'], correctAnswer: 'has finished', explanation: 'Has + V3'),
        GrammarExerciseItem(id: 'ex5_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','learned','English','for','5','years'], correctAnswer: 'I have learned English for 5 years', explanation: 'Present Perfect: have + V3'),
        GrammarExerciseItem(id: 'ex5_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','has','seen','that','movie'], correctAnswer: 'She has seen that movie', explanation: 'Has + V3'),
        GrammarExerciseItem(id: 'ex5_7', type: ExerciseType.fillInBlank, question: 'They _____ (be) to Japan.', correctAnswer: 'have been', explanation: 'Have + been'),
      ],
      order: 5,
    );
  }

  // Placeholder methods for remaining lessons
  static GrammarLesson _createLesson6_AffirmativeSentence() {
    return const GrammarLesson(
      id: 'lesson_6',
      categoryId: 'cat_2',
      title: 'Câu Khẳng Định (Affirmative Sentence)',
      objective: 'Học cách xây dựng câu khẳng định cơ bản trong tiếng Anh',
      theory: 'Câu khẳng định là câu dùng để diễn tả một sự thật, một hành động, một trạng thái hoặc một ý kiến mang tính khẳng định.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Với động từ thường: S + V(s/es) + O',
        '  Ví dụ: I love English.',
        '• Với động từ "to be": S + am/is/are + ...',
        '  Ví dụ: She is a teacher.',
      ],
      notes: null,
      usages: [
        'Diễn tả một sự thật, một thông tin',
        'Diễn tả một hành động, một sự việc',
        'Diễn tả một trạng thái, tình trạng',
        'Bày tỏ ý kiến, quan điểm',
      ],
      examples: [
        GrammarExample(
          english: 'I study English every day.',
          vietnamese: 'Tôi học tiếng Anh mỗi ngày.',
          note: 'Diễn tả hành động',
        ),
        GrammarExample(
          english: 'She is a student.',
          vietnamese: 'Cô ấy là một sinh viên.',
          note: 'Diễn tả sự thật',
        ),
        GrammarExample(
          english: 'We live in Hanoi.',
          vietnamese: 'Chúng tôi sống ở Hà Nội.',
          note: 'Diễn tả thông tin',
        ),
        GrammarExample(
          english: 'The weather is nice today.',
          vietnamese: 'Thời tiết hôm nay đẹp.',
          note: 'Diễn tả trạng thái',
        ),
        GrammarExample(
          english: 'I think English is important.',
          vietnamese: 'Tôi nghĩ tiếng Anh rất quan trọng.',
          note: 'Bày tỏ ý kiến',
        ),
      ],
      commonMistakes: [
        '❌ I am study → ✅ I study (Không dùng "am" với động từ thường)',
        '❌ She go to school → ✅ She goes to school (Thiếu s/es)',
        '❌ They is happy → ✅ They are happy (Sai động từ to be)',
        '❌ He like music → ✅ He likes music (Thiếu s)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex6_1', type: ExerciseType.multipleChoice, question: 'My sister _____ a doctor.', options: ['am','is','are','be'], correctAnswer: 'is', explanation: 'Ngôi 3: is'),
        GrammarExerciseItem(id: 'ex6_2', type: ExerciseType.multipleChoice, question: 'They _____ football.', options: ['play','plays','playing','to play'], correctAnswer: 'play', explanation: 'Số nhiều: V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex6_3', type: ExerciseType.multipleChoice, question: 'I _____ coffee.', options: ['drink','drinks','drinking','am drink'], correctAnswer: 'drink', explanation: 'I + V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex6_4', type: ExerciseType.multipleChoice, question: 'She _____ in a bank.', options: ['work','works','working','to work'], correctAnswer: 'works', explanation: 'Ngôi 3: works'),
        GrammarExerciseItem(id: 'ex6_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','a','doctor'], correctAnswer: 'She is a doctor', explanation: 'Câu khẳng định'),
        GrammarExerciseItem(id: 'ex6_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','study','English','every','day'], correctAnswer: 'I study English every day', explanation: 'Câu khẳng định'),
        GrammarExerciseItem(id: 'ex6_7', type: ExerciseType.fillInBlank, question: 'We _____ (be) students.', correctAnswer: 'are', explanation: 'We + are'),
      ],
      order: 6,
    );
  }

  static GrammarLesson _createLesson7_NegativeSentence() {
    return const GrammarLesson(
      id: 'lesson_7',
      categoryId: 'cat_2',
      title: 'Câu Phủ Định (Negative Sentence)',
      objective: 'Học cách xây dựng câu phủ định trong tiếng Anh',
      theory: 'Câu phủ định là câu dùng để phủ nhận một sự thật, một hành động, một trạng thái hoặc một ý kiến.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Với động từ thường: S + do/does/did + not + V',
        '  Ví dụ: I don\'t like coffee.',
        '• Với động từ "to be": S + am/is/are + not + ...',
        '  Ví dụ: He is not happy.',
      ],
      notes: null,
      usages: [
        'Phủ nhận một sự thật, thông tin',
        'Phủ nhận một hành động',
        'Phủ nhận một trạng thái',
        'Bày tỏ ý kiến phản đối',
      ],
      examples: [
        GrammarExample(
          english: 'I don\'t like spicy food.',
          vietnamese: 'Tôi không thích đồ ăn cay.',
          note: 'Phủ định sở thích',
        ),
        GrammarExample(
          english: 'She doesn\'t work on Sundays.',
          vietnamese: 'Cô ấy không làm việc vào Chủ nhật.',
          note: 'Phủ định hành động',
        ),
        GrammarExample(
          english: 'They are not students.',
          vietnamese: 'Họ không phải là sinh viên.',
          note: 'Phủ định với to be',
        ),
        GrammarExample(
          english: 'We don\'t have time.',
          vietnamese: 'Chúng tôi không có thời gian.',
          note: 'Phủ định sự sở hữu',
        ),
        GrammarExample(
          english: 'It isn\'t cold today.',
          vietnamese: 'Hôm nay không lạnh.',
          note: 'Phủ định trạng thái',
        ),
      ],
      commonMistakes: [
        '❌ I no like → ✅ I don\'t like (Thiếu trợ động từ)',
        '❌ She don\'t go → ✅ She doesn\'t go (Sai trợ động từ)',
        '❌ They not happy → ✅ They are not happy (Thiếu to be)',
        '❌ He doesn\'t goes → ✅ He doesn\'t go (Thừa s/es)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex7_1', type: ExerciseType.multipleChoice, question: 'I _____ like vegetables.', options: ['am not','don\'t','doesn\'t','not'], correctAnswer: 'don\'t', explanation: 'I + don\'t'),
        GrammarExerciseItem(id: 'ex7_2', type: ExerciseType.multipleChoice, question: 'She _____ a teacher.', options: ['isn\'t','doesn\'t','don\'t','not'], correctAnswer: 'isn\'t', explanation: 'Isn\'t + N'),
        GrammarExerciseItem(id: 'ex7_3', type: ExerciseType.multipleChoice, question: 'They _____ play football.', options: ['doesn\'t','don\'t','isn\'t','aren\'t'], correctAnswer: 'don\'t', explanation: 'Don\'t + V'),
        GrammarExerciseItem(id: 'ex7_4', type: ExerciseType.multipleChoice, question: 'He _____ coffee.', options: ['don\'t like','doesn\'t like','isn\'t like','not like'], correctAnswer: 'doesn\'t like', explanation: 'Doesn\'t + V'),
        GrammarExerciseItem(id: 'ex7_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','don\'t','like','coffee'], correctAnswer: 'I don\'t like coffee', explanation: 'Phủ định'),
        GrammarExerciseItem(id: 'ex7_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','isn\'t','a','teacher'], correctAnswer: 'She isn\'t a teacher', explanation: 'Phủ định'),
        GrammarExerciseItem(id: 'ex7_7', type: ExerciseType.fillInBlank, question: 'We _____ (not/be) busy.', correctAnswer: 'are not', explanation: 'Are not'),
      ],
      order: 7,
    );
  }

  static GrammarLesson _createLesson8_QuestionSentence() {
    return const GrammarLesson(
      id: 'lesson_8',
      categoryId: 'cat_2',
      title: 'Câu Nghi Vấn (Question Sentence)',
      objective: 'Học cách đặt câu hỏi Yes/No trong tiếng Anh',
      theory: 'Câu nghi vấn là câu dùng để hỏi thông tin, xác nhận hoặc kiểm tra một sự việc. Câu hỏi Yes/No có đáp án là "Yes" hoặc "No".',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Với động từ thường: Do/Does/Did + S + V?',
        '  Ví dụ: Do you like music?',
        '• Với động từ "to be": Am/Is/Are + S + ...?',
        '  Ví dụ: Is she a student?',
      ],
      notes: null,
      usages: [
        'Hỏi thông tin cần xác nhận',
        'Kiểm tra một sự việc',
        'Hỏi về sở thích, ý kiến',
        'Hỏi về trạng thái, tình huống',
      ],
      examples: [
        GrammarExample(
          english: 'Do you speak English?',
          vietnamese: 'Bạn có nói tiếng Anh không?',
          note: 'Hỏi về khả năng',
        ),
        GrammarExample(
          english: 'Is he your brother?',
          vietnamese: 'Anh ấy có phải là anh trai bạn không?',
          note: 'Xác nhận thông tin',
        ),
        GrammarExample(
          english: 'Does she work here?',
          vietnamese: 'Cô ấy có làm việc ở đây không?',
          note: 'Hỏi về hành động',
        ),
        GrammarExample(
          english: 'Are they students?',
          vietnamese: 'Họ có phải là sinh viên không?',
          note: 'Hỏi về danh tính',
        ),
        GrammarExample(
          english: 'Did you finish your homework?',
          vietnamese: 'Bạn đã hoàn thành bài tập chưa?',
          note: 'Hỏi về quá khứ',
        ),
      ],
      commonMistakes: [
        '❌ You like music? → ✅ Do you like music? (Thiếu trợ động từ)',
        '❌ Does he likes? → ✅ Does he like? (Thừa s/es)',
        '❌ Is they happy? → ✅ Are they happy? (Sai to be)',
        '❌ Do she work? → ✅ Does she work? (Sai trợ động từ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex8_1', type: ExerciseType.multipleChoice, question: '_____ you like pizza?', options: ['Do','Does','Are','Is'], correctAnswer: 'Do', explanation: 'You + Do'),
        GrammarExerciseItem(id: 'ex8_2', type: ExerciseType.multipleChoice, question: '_____ she a doctor?', options: ['Do','Does','Is','Are'], correctAnswer: 'Is', explanation: 'To be: Is'),
        GrammarExerciseItem(id: 'ex8_3', type: ExerciseType.multipleChoice, question: '_____ they play tennis?', options: ['Do','Does','Is','Are'], correctAnswer: 'Do', explanation: 'Số nhiều: Do'),
        GrammarExerciseItem(id: 'ex8_4', type: ExerciseType.multipleChoice, question: '_____ he work here?', options: ['Do','Does','Is','Are'], correctAnswer: 'Does', explanation: 'Ngôi 3: Does'),
        GrammarExerciseItem(id: 'ex8_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Do','you','like','pizza'], correctAnswer: 'Do you like pizza', explanation: 'Câu hỏi Yes/No'),
        GrammarExerciseItem(id: 'ex8_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Is','she','a','doctor'], correctAnswer: 'Is she a doctor', explanation: 'Câu hỏi với to be'),
        GrammarExerciseItem(id: 'ex8_7', type: ExerciseType.fillInBlank, question: '_____ you students?', correctAnswer: 'Are', explanation: 'Are + you'),
      ],
      order: 8,
    );
  }

  static GrammarLesson _createLesson9_ImperativeSentence() {
    return const GrammarLesson(
      id: 'lesson_9',
      categoryId: 'cat_2',
      title: 'Câu Mệnh Lệnh (Imperative Sentence)',
      objective: 'Học cách ra lệnh, yêu cầu, khuyên bảo trong tiếng Anh',
      theory: 'Câu mệnh lệnh là câu dùng để ra lệnh, yêu cầu, khuyên bảo, hoặc hướng dẫn ai đó làm gì. Câu mệnh lệnh không có chủ ngữ rõ ràng.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: V + O',
        '  Ví dụ: Open the door.',
        '• Phủ định: Don\'t + V + O',
        '  Ví dụ: Don\'t be late.',
        '• Lịch sự: Please + V + O',
        '  Ví dụ: Please sit down.',
      ],
      notes: null,
      usages: [
        'Ra lệnh, yêu cầu',
        'Khuyên bảo, nhắc nhở',
        'Hướng dẫn, chỉ dẫn',
        'Cấm đoán',
      ],
      examples: [
        GrammarExample(
          english: 'Close the window.',
          vietnamese: 'Đóng cửa sổ lại.',
          note: 'Ra lệnh',
        ),
        GrammarExample(
          english: 'Don\'t smoke here.',
          vietnamese: 'Đừng hút thuốc ở đây.',
          note: 'Cấm đoán',
        ),
        GrammarExample(
          english: 'Please be quiet.',
          vietnamese: 'Làm ơn im lặng.',
          note: 'Yêu cầu lịch sự',
        ),
        GrammarExample(
          english: 'Study hard.',
          vietnamese: 'Hãy học chăm chỉ.',
          note: 'Khuyên bảo',
        ),
        GrammarExample(
          english: 'Turn left at the corner.',
          vietnamese: 'Rẽ trái ở góc đường.',
          note: 'Hướng dẫn',
        ),
      ],
      commonMistakes: [
        '❌ You close the door → ✅ Close the door (Thừa chủ ngữ)',
        '❌ Not talk → ✅ Don\'t talk (Thiếu don\'t)',
        '❌ Please to sit → ✅ Please sit (Thừa "to")',
        '❌ Don\'t be not late → ✅ Don\'t be late (Thừa "not")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex9_1', type: ExerciseType.multipleChoice, question: '_____ the book.', options: ['Open','Opens','Opening','To open'], correctAnswer: 'Open', explanation: 'Mệnh lệnh: V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex9_2', type: ExerciseType.multipleChoice, question: '_____ run in the classroom.', options: ['Not','Don\'t','Doesn\'t','Isn\'t'], correctAnswer: 'Don\'t', explanation: 'Phủ định: Don\'t'),
        GrammarExerciseItem(id: 'ex9_3', type: ExerciseType.multipleChoice, question: 'Please _____ down.', options: ['sit','sits','sitting','to sit'], correctAnswer: 'sit', explanation: 'Please + V'),
        GrammarExerciseItem(id: 'ex9_4', type: ExerciseType.multipleChoice, question: '_____ quiet!', options: ['Be','Is','Are','Being'], correctAnswer: 'Be', explanation: 'Mệnh lệnh: Be'),
        GrammarExerciseItem(id: 'ex9_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Open','the','door'], correctAnswer: 'Open the door', explanation: 'Câu mệnh lệnh'),
        GrammarExerciseItem(id: 'ex9_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Don\'t','be','late'], correctAnswer: 'Don\'t be late', explanation: 'Mệnh lệnh phủ định'),
        GrammarExerciseItem(id: 'ex9_7', type: ExerciseType.fillInBlank, question: '_____ (listen) to me.', correctAnswer: 'Listen', explanation: 'V nguyên mẫu'),
      ],
      order: 9,
    );
  }

  static GrammarLesson _createLesson10_WHQuestions() {
    return const GrammarLesson(
      id: 'lesson_10',
      categoryId: 'cat_2',
      title: 'Câu Hỏi WH- (WH- Questions)',
      objective: 'Học cách đặt câu hỏi với từ để hỏi WH- trong tiếng Anh',
      theory: 'Câu hỏi WH- là câu hỏi bắt đầu bằng các từ để hỏi như What, Where, When, Who, Why, How. Câu hỏi này yêu cầu câu trả lời cụ thể, không phải Yes/No.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Với động từ thường: WH- + do/does/did + S + V?',
        '  Ví dụ: What do you do?',
        '• Với động từ "to be": WH- + am/is/are + S?',
        '  Ví dụ: Where is he?',
        '• Hỏi chủ ngữ: Who/What + V?',
        '  Ví dụ: Who teaches you English?',
      ],
      notes: null,
      usages: [
        'What: Hỏi về vật, sự việc, nghề nghiệp',
        'Where: Hỏi về địa điểm, nơi chốn',
        'When: Hỏi về thời gian',
        'Who: Hỏi về người',
        'Why: Hỏi về lý do',
        'How: Hỏi về cách thức, phương tiện',
      ],
      examples: [
        GrammarExample(
          english: 'What is your name?',
          vietnamese: 'Tên bạn là gì?',
          note: 'Hỏi về thông tin',
        ),
        GrammarExample(
          english: 'Where do you live?',
          vietnamese: 'Bạn sống ở đâu?',
          note: 'Hỏi về địa điểm',
        ),
        GrammarExample(
          english: 'When does the class start?',
          vietnamese: 'Lớp học bắt đầu khi nào?',
          note: 'Hỏi về thời gian',
        ),
        GrammarExample(
          english: 'Who is your teacher?',
          vietnamese: 'Ai là giáo viên của bạn?',
          note: 'Hỏi về người',
        ),
        GrammarExample(
          english: 'Why are you late?',
          vietnamese: 'Tại sao bạn đến muộn?',
          note: 'Hỏi về lý do',
        ),
        GrammarExample(
          english: 'How do you go to school?',
          vietnamese: 'Bạn đi học bằng gì?',
          note: 'Hỏi về phương tiện',
        ),
      ],
      commonMistakes: [
        '❌ What you do? → ✅ What do you do? (Thiếu trợ động từ)',
        '❌ Where is you live? → ✅ Where do you live? (Sai cấu trúc)',
        '❌ Who do teach you? → ✅ Who teaches you? (Thừa "do")',
        '❌ How you are? → ✅ How are you? (Sai trật tự)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex10_1', type: ExerciseType.multipleChoice, question: '_____ is your favorite color?', options: ['What','Where','When','Who'], correctAnswer: 'What', explanation: 'What: hỏi về vật'),
        GrammarExerciseItem(id: 'ex10_2', type: ExerciseType.multipleChoice, question: '_____ do you live?', options: ['What','Where','When','Who'], correctAnswer: 'Where', explanation: 'Where: hỏi địa điểm'),
        GrammarExerciseItem(id: 'ex10_3', type: ExerciseType.multipleChoice, question: '_____ are you sad?', options: ['What','Where','Why','Who'], correctAnswer: 'Why', explanation: 'Why: hỏi lý do'),
        GrammarExerciseItem(id: 'ex10_4', type: ExerciseType.multipleChoice, question: '_____ is she?', options: ['What','Where','When','Who'], correctAnswer: 'Who', explanation: 'Who: hỏi về người'),
        GrammarExerciseItem(id: 'ex10_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['What','is','your','name'], correctAnswer: 'What is your name', explanation: 'Câu hỏi WH-'),
        GrammarExerciseItem(id: 'ex10_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Where','do','you','live'], correctAnswer: 'Where do you live', explanation: 'WH- + do + S + V'),
        GrammarExerciseItem(id: 'ex10_7', type: ExerciseType.fillInBlank, question: '_____ does the movie start?', correctAnswer: 'When', explanation: 'When: hỏi thời gian'),
      ],
      order: 10,
    );
  }

  static GrammarLesson _createLesson11_Nouns() {
    return const GrammarLesson(
      id: 'lesson_11',
      categoryId: 'cat_3',
      title: 'Danh Từ (Noun)',
      objective: 'Học về danh từ và cách sử dụng danh từ đếm được, không đếm được',
      theory: 'Danh từ là từ chỉ tên người, sự vật, sự việc, địa điểm. Danh từ có thể đếm được (countable) hoặc không đếm được (uncountable).',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Danh từ đếm được: có số ít và số nhiều',
        '  Ví dụ: book → books, student → students',
        '• Danh từ không đếm được: không có số nhiều',
        '  Ví dụ: water, money, information',
        '• Số nhiều bất quy tắc:',
        '  Ví dụ: child → children, person → people',
      ],
      notes: null,
      usages: [
        'Làm chủ ngữ trong câu',
        'Làm tân ngữ sau động từ',
        'Đứng sau tính từ',
        'Đứng sau mạo từ a/an/the',
      ],
      examples: [
        GrammarExample(
          english: 'The book is on the table.',
          vietnamese: 'Cuốn sách ở trên bàn.',
          note: 'Danh từ đếm được số ít',
        ),
        GrammarExample(
          english: 'I need some water.',
          vietnamese: 'Tôi cần một ít nước.',
          note: 'Danh từ không đếm được',
        ),
        GrammarExample(
          english: 'She has three children.',
          vietnamese: 'Cô ấy có ba đứa con.',
          note: 'Danh từ số nhiều bất quy tắc',
        ),
        GrammarExample(
          english: 'There are many students in the class.',
          vietnamese: 'Có nhiều sinh viên trong lớp.',
          note: 'Danh từ đếm được số nhiều',
        ),
        GrammarExample(
          english: 'Money can\'t buy happiness.',
          vietnamese: 'Tiền không thể mua được hạnh phúc.',
          note: 'Danh từ không đếm được',
        ),
      ],
      commonMistakes: [
        '❌ two waters → ✅ two bottles of water (Không đếm được)',
        '❌ a information → ✅ some information (Không dùng a/an)',
        '❌ childs → ✅ children (Số nhiều bất quy tắc)',
        '❌ peoples → ✅ people (Đã là số nhiều)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex11_1', type: ExerciseType.multipleChoice, question: 'I have two _____.', options: ['book','books','a book','the book'], correctAnswer: 'books', explanation: 'Số nhiều: books'),
        GrammarExerciseItem(id: 'ex11_2', type: ExerciseType.multipleChoice, question: 'Can I have some _____?', options: ['water','waters','a water','the waters'], correctAnswer: 'water', explanation: 'Không đếm được'),
        GrammarExerciseItem(id: 'ex11_3', type: ExerciseType.multipleChoice, question: 'There are many _____ in the park.', options: ['child','childs','children','childrens'], correctAnswer: 'children', explanation: 'Số nhiều bất quy tắc'),
        GrammarExerciseItem(id: 'ex11_4', type: ExerciseType.multipleChoice, question: 'I saw three _____ at the bus stop.', options: ['person','persons','people','peoples'], correctAnswer: 'people', explanation: 'Person → people'),
        GrammarExerciseItem(id: 'ex11_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','two','books'], correctAnswer: 'I have two books', explanation: 'Danh từ số nhiều'),
        GrammarExerciseItem(id: 'ex11_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','needs','some','water'], correctAnswer: 'She needs some water', explanation: 'Danh từ không đếm được'),
        GrammarExerciseItem(id: 'ex11_7', type: ExerciseType.fillInBlank, question: 'She needs some _____ (information).', correctAnswer: 'information', explanation: 'Không đếm được'),
      ],
      order: 11,
    );
  }

  static GrammarLesson _createLesson12_Verbs() {
    return const GrammarLesson(
      id: 'lesson_12',
      categoryId: 'cat_3',
      title: 'Động Từ (Verb)',
      objective: 'Học về các loại động từ và cách chia động từ trong tiếng Anh',
      theory: 'Động từ là từ chỉ hành động, trạng thái hoặc sự tồn tại. Có 3 loại động từ chính: động từ thường, động từ to be, và động từ khuyết thiếu (modal verbs).',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Động từ thường: go, eat, study, work...',
        '  Ví dụ: I go to school.',
        '• Động từ "to be": am, is, are, was, were',
        '  Ví dụ: She is a teacher.',
        '• Modal verbs: can, must, should, will...',
        '  Ví dụ: I can swim.',
      ],
      notes: null,
      usages: [
        'Diễn tả hành động: run, eat, study',
        'Diễn tả trạng thái: be, seem, become',
        'Diễn tả sở hữu: have, own, possess',
        'Diễn tả cảm xúc: love, hate, like',
      ],
      examples: [
        GrammarExample(
          english: 'I study English every day.',
          vietnamese: 'Tôi học tiếng Anh mỗi ngày.',
          note: 'Động từ thường',
        ),
        GrammarExample(
          english: 'She is happy.',
          vietnamese: 'Cô ấy vui.',
          note: 'Động từ to be',
        ),
        GrammarExample(
          english: 'We can speak English.',
          vietnamese: 'Chúng tôi có thể nói tiếng Anh.',
          note: 'Modal verb',
        ),
        GrammarExample(
          english: 'He has a car.',
          vietnamese: 'Anh ấy có một chiếc xe.',
          note: 'Động từ sở hữu',
        ),
        GrammarExample(
          english: 'They love music.',
          vietnamese: 'Họ yêu âm nhạc.',
          note: 'Động từ cảm xúc',
        ),
      ],
      commonMistakes: [
        '❌ He go → ✅ He goes (Thiếu s/es với ngôi thứ 3)',
        '❌ I am go → ✅ I go (Không dùng am với động từ thường)',
        '❌ She can goes → ✅ She can go (Sau modal verb dùng V nguyên mẫu)',
        '❌ They is → ✅ They are (Sai động từ to be)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex12_1', type: ExerciseType.multipleChoice, question: 'She _____ to school every day.', options: ['go','goes','going','to go'], correctAnswer: 'goes', explanation: 'Ngôi 3: goes'),
        GrammarExerciseItem(id: 'ex12_2', type: ExerciseType.multipleChoice, question: 'They _____ students.', options: ['am','is','are','be'], correctAnswer: 'are', explanation: 'Số nhiều: are'),
        GrammarExerciseItem(id: 'ex12_3', type: ExerciseType.multipleChoice, question: 'I _____ swim.', options: ['can','cans','am can','can to'], correctAnswer: 'can', explanation: 'Modal verb'),
        GrammarExerciseItem(id: 'ex12_4', type: ExerciseType.multipleChoice, question: 'He _____ a car.', options: ['have','has','having','to have'], correctAnswer: 'has', explanation: 'Ngôi 3: has'),
        GrammarExerciseItem(id: 'ex12_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','goes','to','school'], correctAnswer: 'She goes to school', explanation: 'Động từ thường'),
        GrammarExerciseItem(id: 'ex12_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','can','swim'], correctAnswer: 'I can swim', explanation: 'Modal verb'),
        GrammarExerciseItem(id: 'ex12_7', type: ExerciseType.fillInBlank, question: 'We _____ (be) happy.', correctAnswer: 'are', explanation: 'We + are'),
      ],
      order: 12,
    );
  }

  static GrammarLesson _createLesson13_Adjectives() {
    return const GrammarLesson(
      id: 'lesson_13',
      categoryId: 'cat_3',
      title: 'Tính Từ (Adjective)',
      objective: 'Học về tính từ và cách sử dụng tính từ trong tiếng Anh',
      theory: 'Tính từ là từ dùng để miêu tả tính chất, đặc điểm của danh từ. Tính từ thường đứng trước danh từ hoặc sau động từ to be.',
      formulas: [
        '📌 VỊ TRÍ:',
        '• Trước danh từ: adj + noun',
        '  Ví dụ: a beautiful girl',
        '• Sau to be: S + be + adj',
        '  Ví dụ: She is beautiful.',
        '• Sau linking verbs: seem, look, feel...',
        '  Ví dụ: You look tired.',
      ],
      notes: null,
      usages: [
        'Miêu tả tính chất của người/vật',
        'Miêu tả kích thước, màu sắc',
        'Miêu tả cảm xúc, trạng thái',
        'Miêu tả số lượng, tuổi tác',
      ],
      examples: [
        GrammarExample(
          english: 'She is a smart student.',
          vietnamese: 'Cô ấy là một học sinh thông minh.',
          note: 'Tính từ trước danh từ',
        ),
        GrammarExample(
          english: 'The weather is nice today.',
          vietnamese: 'Thời tiết hôm nay đẹp.',
          note: 'Tính từ sau to be',
        ),
        GrammarExample(
          english: 'I have a red car.',
          vietnamese: 'Tôi có một chiếc xe màu đỏ.',
          note: 'Tính từ chỉ màu sắc',
        ),
        GrammarExample(
          english: 'He feels happy.',
          vietnamese: 'Anh ấy cảm thấy vui.',
          note: 'Tính từ sau linking verb',
        ),
        GrammarExample(
          english: 'This is an old house.',
          vietnamese: 'Đây là một ngôi nhà cũ.',
          note: 'Tính từ chỉ tuổi',
        ),
      ],
      commonMistakes: [
        '❌ a girl beautiful → ✅ a beautiful girl (Sai vị trí)',
        '❌ She is beauty → ✅ She is beautiful (Dùng danh từ thay tính từ)',
        '❌ very much big → ✅ very big (Sai cấu trúc)',
        '❌ He is a person kind → ✅ He is a kind person (Sai vị trí)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex13_1', type: ExerciseType.multipleChoice, question: 'She is a _____ girl.', options: ['beauty','beautiful','beautifully','beautify'], correctAnswer: 'beautiful', explanation: 'Trước danh từ: tính từ'),
        GrammarExerciseItem(id: 'ex13_2', type: ExerciseType.multipleChoice, question: 'The book is _____.', options: ['interest','interested','interesting','interestingly'], correctAnswer: 'interesting', explanation: 'Sau to be: tính từ'),
        GrammarExerciseItem(id: 'ex13_3', type: ExerciseType.multipleChoice, question: 'I have a _____ car.', options: ['new','newly','newness','newer'], correctAnswer: 'new', explanation: 'Trước danh từ: tính từ'),
        GrammarExerciseItem(id: 'ex13_4', type: ExerciseType.multipleChoice, question: 'She looks _____.', options: ['tire','tired','tiring','tiredly'], correctAnswer: 'tired', explanation: 'Sau linking verb: tính từ'),
        GrammarExerciseItem(id: 'ex13_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','a','beautiful','girl'], correctAnswer: 'She is a beautiful girl', explanation: 'Adj + Noun'),
        GrammarExerciseItem(id: 'ex13_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','weather','is','nice'], correctAnswer: 'The weather is nice', explanation: 'S + be + Adj'),
        GrammarExerciseItem(id: 'ex13_7', type: ExerciseType.fillInBlank, question: 'The weather is _____ (sun) today.', correctAnswer: 'sunny', explanation: 'sun → sunny'),
      ],
      order: 13,
    );
  }

  static GrammarLesson _createLesson14_Adverbs() {
    return const GrammarLesson(
      id: 'lesson_14',
      categoryId: 'cat_3',
      title: 'Trạng Từ (Adverb)',
      objective: 'Học về trạng từ và cách sử dụng trạng từ trong tiếng Anh',
      theory: 'Trạng từ là từ dùng để bổ nghĩa cho động từ, tính từ hoặc trạng từ khác. Trạng từ thường được tạo bằng cách thêm -ly vào tính từ.',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Trạng từ cách thức: quickly, slowly, carefully',
        '  Ví dụ: She runs quickly.',
        '• Trạng từ thời gian: yesterday, today, tomorrow',
        '  Ví dụ: I saw him yesterday.',
        '• Trạng từ tần suất: always, usually, often, sometimes',
        '  Ví dụ: I always study hard.',
      ],
      notes: null,
      usages: [
        'Bổ nghĩa cho động từ (chỉ cách thức)',
        'Bổ nghĩa cho tính từ (chỉ mức độ)',
        'Chỉ thời gian (when)',
        'Chỉ tần suất (how often)',
      ],
      examples: [
        GrammarExample(
          english: 'He speaks English fluently.',
          vietnamese: 'Anh ấy nói tiếng Anh lưu loát.',
          note: 'Trạng từ cách thức',
        ),
        GrammarExample(
          english: 'She is very beautiful.',
          vietnamese: 'Cô ấy rất đẹp.',
          note: 'Trạng từ bổ nghĩa cho tính từ',
        ),
        GrammarExample(
          english: 'I will call you tomorrow.',
          vietnamese: 'Tôi sẽ gọi cho bạn vào ngày mai.',
          note: 'Trạng từ thời gian',
        ),
        GrammarExample(
          english: 'We usually go to school by bus.',
          vietnamese: 'Chúng tôi thường đi học bằng xe buýt.',
          note: 'Trạng từ tần suất',
        ),
        GrammarExample(
          english: 'He drives carefully.',
          vietnamese: 'Anh ấy lái xe cẩn thận.',
          note: 'Trạng từ cách thức',
        ),
      ],
      commonMistakes: [
        '❌ He runs quick → ✅ He runs quickly (Thiếu -ly)',
        '❌ She is very much beautiful → ✅ She is very beautiful (Thừa "much")',
        '❌ I always am late → ✅ I am always late (Sai vị trí)',
        '❌ He speaks good English → ✅ He speaks English well (Dùng tính từ thay trạng từ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex14_1', type: ExerciseType.multipleChoice, question: 'She sings _____.', options: ['beautiful','beautifully','beauty','beautify'], correctAnswer: 'beautifully', explanation: 'Trạng từ: beautifully'),
        GrammarExerciseItem(id: 'ex14_2', type: ExerciseType.multipleChoice, question: 'I _____ go to the gym.', options: ['usual','usually','use','used'], correctAnswer: 'usually', explanation: 'Trạng từ tần suất'),
        GrammarExerciseItem(id: 'ex14_3', type: ExerciseType.multipleChoice, question: 'The test was _____ difficult.', options: ['very','much','many','more'], correctAnswer: 'very', explanation: 'very + adj'),
        GrammarExerciseItem(id: 'ex14_4', type: ExerciseType.multipleChoice, question: 'He speaks English _____.', options: ['good','well','goodly','better'], correctAnswer: 'well', explanation: 'Trạng từ: well'),
        GrammarExerciseItem(id: 'ex14_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','sings','beautifully'], correctAnswer: 'She sings beautifully', explanation: 'V + Adv'),
        GrammarExerciseItem(id: 'ex14_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','usually','go','home'], correctAnswer: 'I usually go home', explanation: 'Trạng từ tần suất'),
        GrammarExerciseItem(id: 'ex14_7', type: ExerciseType.fillInBlank, question: 'He drives _____ (careful).', correctAnswer: 'carefully', explanation: 'careful → carefully'),
      ],
      order: 14,
    );
  }

  static GrammarLesson _createLesson15_Pronouns() {
    return const GrammarLesson(
      id: 'lesson_15',
      categoryId: 'cat_3',
      title: 'Đại Từ (Pronoun)',
      objective: 'Học về các loại đại từ trong tiếng Anh',
      theory: 'Đại từ là từ dùng để thay thế cho danh từ. Có nhiều loại đại từ: nhân xưng, sở hữu, phản thân.',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Đại từ nhân xưng: I, you, he, she, it, we, they',
        '  Ví dụ: I am a student.',
        '• Đại từ tân ngữ: me, you, him, her, it, us, them',
        '  Ví dụ: She loves me.',
        '• Đại từ sở hữu: my, your, his, her, its, our, their',
        '  Ví dụ: This is my book.',
      ],
      notes: null,
      usages: [
        'Thay thế cho danh từ để tránh lặp lại',
        'Làm chủ ngữ trong câu',
        'Làm tân ngữ sau động từ',
        'Chỉ sự sở hữu',
      ],
      examples: [
        GrammarExample(
          english: 'I love you.',
          vietnamese: 'Tôi yêu bạn.',
          note: 'Đại từ nhân xưng + tân ngữ',
        ),
        GrammarExample(
          english: 'This is my book.',
          vietnamese: 'Đây là cuốn sách của tôi.',
          note: 'Đại từ sở hữu',
        ),
        GrammarExample(
          english: 'She teaches us English.',
          vietnamese: 'Cô ấy dạy chúng tôi tiếng Anh.',
          note: 'Đại từ tân ngữ',
        ),
        GrammarExample(
          english: 'He did it himself.',
          vietnamese: 'Anh ấy tự làm điều đó.',
          note: 'Đại từ phản thân',
        ),
        GrammarExample(
          english: 'Their house is big.',
          vietnamese: 'Ngôi nhà của họ lớn.',
          note: 'Đại từ sở hữu',
        ),
      ],
      commonMistakes: [
        '❌ Me am a student → ✅ I am a student (Dùng sai đại từ)',
        '❌ This is I book → ✅ This is my book (Dùng sai dạng)',
        '❌ She love I → ✅ She loves me (Dùng sai tân ngữ)',
        '❌ He book → ✅ His book (Thiếu đại từ sở hữu)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex15_1', type: ExerciseType.multipleChoice, question: '_____ am a teacher.', options: ['Me','I','My','Mine'], correctAnswer: 'I', explanation: 'Chủ ngữ: I'),
        GrammarExerciseItem(id: 'ex15_2', type: ExerciseType.multipleChoice, question: 'She loves _____.', options: ['I','me','my','mine'], correctAnswer: 'me', explanation: 'Tân ngữ: me'),
        GrammarExerciseItem(id: 'ex15_3', type: ExerciseType.multipleChoice, question: 'This is _____ book.', options: ['I','me','my','mine'], correctAnswer: 'my', explanation: 'Sở hữu: my'),
        GrammarExerciseItem(id: 'ex15_4', type: ExerciseType.multipleChoice, question: 'The book is _____.', options: ['I','me','my','mine'], correctAnswer: 'mine', explanation: 'Đại từ sở hữu: mine'),
        GrammarExerciseItem(id: 'ex15_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','love','my','family'], correctAnswer: 'I love my family', explanation: 'I + my'),
        GrammarExerciseItem(id: 'ex15_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','helps','me'], correctAnswer: 'She helps me', explanation: 'Tân ngữ: me'),
        GrammarExerciseItem(id: 'ex15_7', type: ExerciseType.fillInBlank, question: '_____ (he) name is John.', correctAnswer: 'His', explanation: 'he → His'),
      ],
      order: 15,
    );
  }

  static GrammarLesson _createLesson16_Articles() {
    return const GrammarLesson(
      id: 'lesson_16',
      categoryId: 'cat_3',
      title: 'Mạo Từ (Articles: a, an, the)',
      objective: 'Học cách sử dụng mạo từ a, an, the trong tiếng Anh',
      theory: 'Mạo từ là từ đứng trước danh từ. Có 2 loại: mạo từ không xác định (a/an) và mạo từ xác định (the).',
      formulas: [
        '📌 CÁCH DÙNG:',
        '• a: trước danh từ số ít bắt đầu bằng phụ âm',
        '  Ví dụ: a book, a car, a student',
        '• an: trước danh từ số ít bắt đầu bằng nguyên âm',
        '  Ví dụ: an apple, an egg, an hour',
        '• the: chỉ vật cụ thể, duy nhất, đã được nhắc đến',
        '  Ví dụ: the sun, the moon, the book (on the table)',
      ],
      notes: null,
      usages: [
        'a/an: dùng cho vật không xác định, lần đầu nhắc đến',
        'the: dùng cho vật xác định, duy nhất',
        'the: dùng cho vật đã được nhắc đến',
        'Không dùng mạo từ: danh từ số nhiều, không đếm được (nói chung)',
      ],
      examples: [
        GrammarExample(
          english: 'I have a cat.',
          vietnamese: 'Tôi có một con mèo.',
          note: 'Dùng "a" - lần đầu nhắc',
        ),
        GrammarExample(
          english: 'She is an engineer.',
          vietnamese: 'Cô ấy là một kỹ sư.',
          note: 'Dùng "an" - bắt đầu bằng nguyên âm',
        ),
        GrammarExample(
          english: 'The cat is sleeping.',
          vietnamese: 'Con mèo đang ngủ.',
          note: 'Dùng "the" - đã nhắc đến',
        ),
        GrammarExample(
          english: 'The sun rises in the east.',
          vietnamese: 'Mặt trời mọc ở phía đông.',
          note: 'Dùng "the" - duy nhất',
        ),
        GrammarExample(
          english: 'I like coffee.',
          vietnamese: 'Tôi thích cà phê.',
          note: 'Không dùng mạo từ - nói chung',
        ),
      ],
      commonMistakes: [
        '❌ a apple → ✅ an apple (Bắt đầu bằng nguyên âm)',
        '❌ I like the coffee → ✅ I like coffee (Nói chung)',
        '❌ He is teacher → ✅ He is a teacher (Thiếu mạo từ)',
        '❌ The books are interesting → ✅ Books are interesting (Nói chung)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex16_1', type: ExerciseType.multipleChoice, question: 'I have _____ dog.', options: ['a','an','the','no article'], correctAnswer: 'a', explanation: 'a + phụ âm'),
        GrammarExerciseItem(id: 'ex16_2', type: ExerciseType.multipleChoice, question: 'She is _____ honest person.', options: ['a','an','the','no article'], correctAnswer: 'an', explanation: 'an + h câm'),
        GrammarExerciseItem(id: 'ex16_3', type: ExerciseType.multipleChoice, question: '_____ sun is bright.', options: ['A','An','The','No article'], correctAnswer: 'The', explanation: 'the + duy nhất'),
        GrammarExerciseItem(id: 'ex16_4', type: ExerciseType.multipleChoice, question: 'I like _____ coffee.', options: ['a','an','the','no article'], correctAnswer: 'no article', explanation: 'Nói chung: không mạo từ'),
        GrammarExerciseItem(id: 'ex16_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','a','dog'], correctAnswer: 'I have a dog', explanation: 'a + danh từ'),
        GrammarExerciseItem(id: 'ex16_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','sun','is','bright'], correctAnswer: 'The sun is bright', explanation: 'the + duy nhất'),
        GrammarExerciseItem(id: 'ex16_7', type: ExerciseType.fillInBlank, question: 'I need _____ umbrella.', correctAnswer: 'an', explanation: 'an + nguyên âm'),
      ],
      order: 16,
    );
  }

  
  static GrammarLesson _createLesson17_PassiveVoice() {
    return const GrammarLesson(
      id: 'lesson_17',
      categoryId: 'cat_4',
      title: 'Câu Bị Động (Passive Voice)',
      objective: 'Học cách chuyển câu chủ động sang câu bị động',
      theory: 'Câu bị động là câu nhấn mạnh vào đối tượng chịu tác động của hành động thay vì người thực hiện hành động.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Hiện tại đơn: S + am/is/are + V3/ed',
        '  Ví dụ: The book is read by me.',
        '• Quá khứ đơn: S + was/were + V3/ed',
        '  Ví dụ: The letter was written yesterday.',
        '• Tương lai: S + will be + V3/ed',
        '  Ví dỡ: The house will be built next year.',
      ],
      notes: null,
      usages: [
        'Nhấn mạnh vào đối tượng chịu tác động',
        'Không biết hoặc không quan tâm người thực hiện',
        'Nói về sự việc một cách khách quan',
        'Trong văn viết trang trọng, khoa học',
      ],
      examples: [
        GrammarExample(
          english: 'English is spoken all over the world.',
          vietnamese: 'Tiếng Anh được nói trên toàn thế giới.',
          note: 'Hiện tại đơn bị động',
        ),
        GrammarExample(
          english: 'The car was repaired yesterday.',
          vietnamese: 'Chiếc xe đã được sửa hôm qua.',
          note: 'Quá khứ đơn bị động',
        ),
        GrammarExample(
          english: 'The project will be completed next month.',
          vietnamese: 'Dự án sẽ được hoàn thành vào tháng sau.',
          note: 'Tương lai bị động',
        ),
        GrammarExample(
          english: 'This room is cleaned every day.',
          vietnamese: 'Phòng này được dọn mỗi ngày.',
          note: 'Nhấn mạnh đối tượng',
        ),
        GrammarExample(
          english: 'The cake was made by my mother.',
          vietnamese: 'Chiếc bánh được làm bởi mẹ tôi.',
          note: 'Có "by" chỉ người thực hiện',
        ),
      ],
      commonMistakes: [
        '❌ The book is read → ✅ The book is being read (Thiếu "being" cho hiện tại tiếp diễn)',
        '❌ It was build → ✅ It was built (Sai dạng V3)',
        '❌ The house is build → ✅ The house is built (Sai dạng động từ)',
        '❌ English spoken → ✅ English is spoken (Thiếu to be)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex17_1', type: ExerciseType.multipleChoice, question: 'The letter _____ yesterday.', options: ['is written','was written','writes','wrote'], correctAnswer: 'was written', explanation: 'Quá khứ bị động'),
        GrammarExerciseItem(id: 'ex17_2', type: ExerciseType.multipleChoice, question: 'English _____ all over the world.', options: ['speak','speaks','is spoken','was spoken'], correctAnswer: 'is spoken', explanation: 'Hiện tại bị động'),
        GrammarExerciseItem(id: 'ex17_3', type: ExerciseType.multipleChoice, question: 'The house _____ next year.', options: ['will build','will be built','is built','was built'], correctAnswer: 'will be built', explanation: 'Tương lai bị động'),
        GrammarExerciseItem(id: 'ex17_4', type: ExerciseType.multipleChoice, question: 'This room _____ every day.', options: ['clean','cleans','is cleaned','was cleaned'], correctAnswer: 'is cleaned', explanation: 'Hiện tại bị động'),
        GrammarExerciseItem(id: 'ex17_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','book','is','read'], correctAnswer: 'The book is read', explanation: 'Bị động hiện tại'),
        GrammarExerciseItem(id: 'ex17_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['English','is','spoken','here'], correctAnswer: 'English is spoken here', explanation: 'Câu bị động'),
        GrammarExerciseItem(id: 'ex17_7', type: ExerciseType.fillInBlank, question: 'The car _____ (repair) now.', correctAnswer: 'is being repaired', explanation: 'Hiện tại tiếp diễn bị động'),
      ],
      order: 17,
    );
  }

  static GrammarLesson _createLesson18_ConditionalType1() {
    return const GrammarLesson(
      id: 'lesson_18',
      categoryId: 'cat_4',
      title: 'Câu Điều Kiện Loại 1 (Conditional Type 1)',
      objective: 'Học cách diễn tả điều kiện có thể xảy ra trong tương lai',
      theory: 'Câu điều kiện loại 1 diễn tả một điều kiện có thể xảy ra ở hiện tại hoặc tương lai và kết quả có thể xảy ra.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• If + S + V(s/es), S + will + V',
        '  Ví dụ: If it rains, I will stay home.',
        '• S + will + V + if + S + V(s/es)',
        '  Ví dụ: I will stay home if it rains.',
        '• Có thể dùng: can, may, must thay will',
        '  Ví dụ: If you study hard, you can pass the exam.',
      ],
      notes: null,
      usages: [
        'Diễn tả điều kiện có thể xảy ra',
        'Diễn tả kết quả có thể xảy ra',
        'Đưa ra lời khuyên, cảnh báo',
        'Nói về sự thật hiển nhiên',
      ],
      examples: [
        GrammarExample(
          english: 'If you study hard, you will pass the exam.',
          vietnamese: 'Nếu bạn học chăm chỉ, bạn sẽ đậu kỳ thi.',
          note: 'Điều kiện có thể xảy ra',
        ),
        GrammarExample(
          english: 'If it rains tomorrow, we won\'t go out.',
          vietnamese: 'Nếu ngày mai mưa, chúng ta sẽ không đi ra ngoài.',
          note: 'Kết quả trong tương lai',
        ),
        GrammarExample(
          english: 'If you don\'t hurry, you will miss the bus.',
          vietnamese: 'Nếu bạn không nhanh lên, bạn sẽ lỡ xe buýt.',
          note: 'Cảnh báo',
        ),
        GrammarExample(
          english: 'If you heat water to 100°C, it boils.',
          vietnamese: 'Nếu bạn đun nước đến 100°C, nó sôi.',
          note: 'Sự thật hiển nhiên',
        ),
        GrammarExample(
          english: 'You can borrow my book if you need it.',
          vietnamese: 'Bạn có thể mượn sách của tôi nếu bạn cần.',
          note: 'Dùng "can" thay "will"',
        ),
      ],
      commonMistakes: [
        '❌ If it will rain → ✅ If it rains (Không dùng will sau if)',
        '❌ If I have money, I buy → ✅ If I have money, I will buy (Thiếu will)',
        '❌ If he come → ✅ If he comes (Thiếu s/es)',
        '❌ I will go if I will have time → ✅ I will go if I have time (Thừa will)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex18_1', type: ExerciseType.multipleChoice, question: 'If it _____ tomorrow, we will cancel the trip.', options: ['rain','rains','will rain','rained'], correctAnswer: 'rains', explanation: 'If + hiện tại đơn'),
        GrammarExerciseItem(id: 'ex18_2', type: ExerciseType.multipleChoice, question: 'If you study hard, you _____ the exam.', options: ['pass','passes','will pass','passed'], correctAnswer: 'will pass', explanation: 'will + V'),
        GrammarExerciseItem(id: 'ex18_3', type: ExerciseType.multipleChoice, question: 'We _____ late if we don\'t hurry.', options: ['are','will be','were','be'], correctAnswer: 'will be', explanation: 'will be'),
        GrammarExerciseItem(id: 'ex18_4', type: ExerciseType.multipleChoice, question: 'If I have time, I _____ you.', options: ['help','helps','will help','helped'], correctAnswer: 'will help', explanation: 'will + V'),
        GrammarExerciseItem(id: 'ex18_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['If','it','rains','I','will','stay','home'], correctAnswer: 'If it rains I will stay home', explanation: 'Câu điều kiện loại 1'),
        GrammarExerciseItem(id: 'ex18_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','will','call','you','if','I','arrive'], correctAnswer: 'I will call you if I arrive', explanation: 'Điều kiện loại 1'),
        GrammarExerciseItem(id: 'ex18_7', type: ExerciseType.fillInBlank, question: 'If she _____ (come), I will be happy.', correctAnswer: 'comes', explanation: 'come → comes'),
      ],
      order: 18,
    );
  }

  static GrammarLesson _createLesson19_Comparatives() {
    return const GrammarLesson(
      id: 'lesson_19',
      categoryId: 'cat_4',
      title: 'So Sánh Hơn và Nhất (Comparatives and Superlatives)',
      objective: 'Học cách so sánh giữa 2 hoặc nhiều đối tượng',
      theory: 'So sánh hơn dùng để so sánh 2 đối tượng. So sánh nhất dùng để so sánh 3 đối tượng trở lên.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Tính từ ngắn (1 âm tiết): adj + er / the + adj + est',
        '  Ví dụ: tall → taller → the tallest',
        '• Tính từ dài (2+ âm tiết): more + adj / the most + adj',
        '  Ví dụ: beautiful → more beautiful → the most beautiful',
        '• Bất quy tắc: good → better → the best',
        '  bad → worse → the worst',
      ],
      notes: null,
      usages: [
        'So sánh hơn: so sánh 2 đối tượng',
        'So sánh nhất: so sánh 3+ đối tượng',
        'So sánh bằng: as + adj + as',
        'So sánh không bằng: not as + adj + as',
      ],
      examples: [
        GrammarExample(
          english: 'She is taller than her sister.',
          vietnamese: 'Cô ấy cao hơn chị gái.',
          note: 'So sánh hơn - tính từ ngắn',
        ),
        GrammarExample(
          english: 'This book is more interesting than that one.',
          vietnamese: 'Cuốn sách này thú vị hơn cuốn kia.',
          note: 'So sánh hơn - tính từ dài',
        ),
        GrammarExample(
          english: 'He is the tallest student in the class.',
          vietnamese: 'Anh ấy là học sinh cao nhất lớp.',
          note: 'So sánh nhất',
        ),
        GrammarExample(
          english: 'This is the most beautiful place I\'ve ever seen.',
          vietnamese: 'Đây là nơi đẹp nhất tôi từng thấy.',
          note: 'So sánh nhất - tính từ dài',
        ),
        GrammarExample(
          english: 'She is as tall as her brother.',
          vietnamese: 'Cô ấy cao bằng anh trai.',
          note: 'So sánh bằng',
        ),
      ],
      commonMistakes: [
        '❌ more tall → ✅ taller (Tính từ ngắn dùng -er)',
        '❌ the most tall → ✅ the tallest (Tính từ ngắn dùng -est)',
        '❌ gooder → ✅ better (Bất quy tắc)',
        '❌ more better → ✅ better (Không dùng "more" với bất quy tắc)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex19_1', type: ExerciseType.multipleChoice, question: 'She is _____ than me.', options: ['tall','taller','more tall','the tallest'], correctAnswer: 'taller', explanation: 'So sánh hơn: taller'),
        GrammarExerciseItem(id: 'ex19_2', type: ExerciseType.multipleChoice, question: 'This is _____ book in the library.', options: ['interesting','more interesting','most interesting','the most interesting'], correctAnswer: 'the most interesting', explanation: 'So sánh nhất'),
        GrammarExerciseItem(id: 'ex19_3', type: ExerciseType.multipleChoice, question: 'Today is _____ than yesterday.', options: ['good','better','best','the best'], correctAnswer: 'better', explanation: 'good → better'),
        GrammarExerciseItem(id: 'ex19_4', type: ExerciseType.multipleChoice, question: 'He is the _____ student.', options: ['smart','smarter','smartest','most smart'], correctAnswer: 'smartest', explanation: 'So sánh nhất: smartest'),
        GrammarExerciseItem(id: 'ex19_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','taller','than','me'], correctAnswer: 'She is taller than me', explanation: 'So sánh hơn'),
        GrammarExerciseItem(id: 'ex19_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','is','the','tallest','boy'], correctAnswer: 'He is the tallest boy', explanation: 'So sánh nhất'),
        GrammarExerciseItem(id: 'ex19_7', type: ExerciseType.fillInBlank, question: 'This car is _____ (expensive) than that one.', correctAnswer: 'more expensive', explanation: 'more + adj dài'),
      ],
      order: 19,
    );
  }

  static GrammarLesson _createLesson20_ThereIsAre() {
    return const GrammarLesson(
      id: 'lesson_20',
      categoryId: 'cat_4',
      title: 'There is / There are',
      objective: 'Học cách diễn tả sự tồn tại của người/vật',
      theory: '"There is/are" dùng để diễn tả sự tồn tại hoặc sự có mặt của người hoặc vật ở một nơi nào đó.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• There is + danh từ số ít / không đếm được',
        '  Ví dụ: There is a book on the table.',
        '• There are + danh từ số nhiều',
        '  Ví dụ: There are books on the table.',
        '• Phủ định: There isn\'t / There aren\'t',
        '  Ví dụ: There isn\'t any milk.',
      ],
      notes: null,
      usages: [
        'Diễn tả sự tồn tại',
        'Giới thiệu thông tin mới',
        'Miêu tả một nơi chốn',
        'Nói về số lượng',
      ],
      examples: [
        GrammarExample(
          english: 'There is a cat in the garden.',
          vietnamese: 'Có một con mèo trong vườn.',
          note: 'Số ít - dùng "is"',
        ),
        GrammarExample(
          english: 'There are many students in the class.',
          vietnamese: 'Có nhiều học sinh trong lớp.',
          note: 'Số nhiều - dùng "are"',
        ),
        GrammarExample(
          english: 'There isn\'t any water in the bottle.',
          vietnamese: 'Không có nước trong chai.',
          note: 'Phủ định với "isn\'t"',
        ),
        GrammarExample(
          english: 'Is there a bank near here?',
          vietnamese: 'Có ngân hàng nào gần đây không?',
          note: 'Câu hỏi',
        ),
        GrammarExample(
          english: 'There are some books on the shelf.',
          vietnamese: 'Có vài cuốn sách trên kệ.',
          note: 'Dùng "some" trong câu khẳng định',
        ),
      ],
      commonMistakes: [
        '❌ There is books → ✅ There are books (Sai số)',
        '❌ There have a book → ✅ There is a book (Dùng "have" thay "is")',
        '❌ It is a book → ✅ There is a book (Dùng "it" thay "there")',
        '❌ There are a book → ✅ There is a book (Sai số)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex20_1', type: ExerciseType.multipleChoice, question: '_____ a book on the table.', options: ['There is','There are','It is','They are'], correctAnswer: 'There is', explanation: 'Số ít: There is'),
        GrammarExerciseItem(id: 'ex20_2', type: ExerciseType.multipleChoice, question: '_____ many students in the class.', options: ['There is','There are','It is','They are'], correctAnswer: 'There are', explanation: 'Số nhiều: There are'),
        GrammarExerciseItem(id: 'ex20_3', type: ExerciseType.multipleChoice, question: '_____ any milk in the fridge?', options: ['Is there','Are there','There is','There are'], correctAnswer: 'Is there', explanation: 'Câu hỏi: Is there'),
        GrammarExerciseItem(id: 'ex20_4', type: ExerciseType.multipleChoice, question: '_____ a cat in the garden.', options: ['There is','There are','It is','They are'], correctAnswer: 'There is', explanation: 'There is'),
        GrammarExerciseItem(id: 'ex20_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['There','is','a','book'], correctAnswer: 'There is a book', explanation: 'There is/are'),
        GrammarExerciseItem(id: 'ex20_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['There','are','many','students'], correctAnswer: 'There are many students', explanation: 'There are'),
        GrammarExerciseItem(id: 'ex20_7', type: ExerciseType.fillInBlank, question: '_____ (not/be) any apples.', correctAnswer: 'There aren\'t', explanation: 'Phủ định: There aren\'t'),
      ],
      order: 20,
    );
  }

  static GrammarLesson _createLesson21_ModalVerbs() {
    return const GrammarLesson(
      id: 'lesson_21',
      categoryId: 'cat_4',
      title: 'Modal Verbs (can, must, should)',
      objective: 'Học cách sử dụng các động từ khuyết thiếu cơ bản',
      theory: 'Modal verbs là các động từ khuyết thiếu dùng để diễn tả khả năng, sự bắt buộc, lời khuyên. Sau modal verb luôn là động từ nguyên mẫu.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• can: S + can + V (khả năng)',
        '  Ví dụ: I can swim.',
        '• must: S + must + V (bắt buộc)',
        '  Ví dụ: You must study hard.',
        '• should: S + should + V (nên, khuyên)',
        '  Ví dụ: You should see a doctor.',
      ],
      notes: null,
      usages: [
        'can: diễn tả khả năng, xin phép',
        'must: diễn tả sự bắt buộc, nghĩa vụ',
        'should: diễn tả lời khuyên',
        'may: diễn tả sự cho phép, khả năng',
      ],
      examples: [
        GrammarExample(
          english: 'I can speak English.',
          vietnamese: 'Tôi có thể nói tiếng Anh.',
          note: 'Khả năng',
        ),
        GrammarExample(
          english: 'You must wear a helmet.',
          vietnamese: 'Bạn phải đội mũ bảo hiểm.',
          note: 'Bắt buộc',
        ),
        GrammarExample(
          english: 'You should eat more vegetables.',
          vietnamese: 'Bạn nên ăn nhiều rau hơn.',
          note: 'Lời khuyên',
        ),
        GrammarExample(
          english: 'Can I use your phone?',
          vietnamese: 'Tôi có thể dùng điện thoại của bạn không?',
          note: 'Xin phép',
        ),
        GrammarExample(
          english: 'She can\'t swim.',
          vietnamese: 'Cô ấy không biết bơi.',
          note: 'Phủ định khả năng',
        ),
      ],
      commonMistakes: [
        '❌ I can to swim → ✅ I can swim (Thừa "to")',
        '❌ He cans swim → ✅ He can swim (Thừa "s")',
        '❌ You should to study → ✅ You should study (Thừa "to")',
        '❌ She musts go → ✅ She must go (Thừa "s")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex21_1', type: ExerciseType.multipleChoice, question: 'I _____ swim.', options: ['can','cans','can to','to can'], correctAnswer: 'can', explanation: 'can + V'),
        GrammarExerciseItem(id: 'ex21_2', type: ExerciseType.multipleChoice, question: 'You _____ study hard.', options: ['must','musts','must to','to must'], correctAnswer: 'must', explanation: 'must + V'),
        GrammarExerciseItem(id: 'ex21_3', type: ExerciseType.multipleChoice, question: 'You _____ see a doctor.', options: ['should','shoulds','should to','to should'], correctAnswer: 'should', explanation: 'should + V'),
        GrammarExerciseItem(id: 'ex21_4', type: ExerciseType.multipleChoice, question: 'She _____ speak French.', options: ['can','cans','is can','can to'], correctAnswer: 'can', explanation: 'Modal verb'),
        GrammarExerciseItem(id: 'ex21_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','can','swim'], correctAnswer: 'I can swim', explanation: 'can + V'),
        GrammarExerciseItem(id: 'ex21_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','should','study','hard'], correctAnswer: 'You should study hard', explanation: 'should + V'),
        GrammarExerciseItem(id: 'ex21_7', type: ExerciseType.fillInBlank, question: 'We _____ (must) finish this today.', correctAnswer: 'must', explanation: 'must + V'),
      ],
      order: 21,
    );
  }

  
  static GrammarLesson _createLesson22_WouldYouLike() {
    return const GrammarLesson(
      id: 'lesson_22',
      categoryId: 'cat_5',
      title: 'Would you like...?',
      objective: 'Học cách mời, đề nghị lịch sự trong tiếng Anh',
      theory: '"Would you like...?" là cấu trúc dùng để mời hoặc đề nghị một cách lịch sự, trang trọng.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Would you like + danh từ?',
        '  Ví dụ: Would you like some tea?',
        '• Would you like + to V?',
        '  Ví dụ: Would you like to go to the cinema?',
        '• Trả lời: Yes, please. / No, thank you.',
        '  Ví dụ: Yes, I\'d love to. / No, thanks.',
      ],
      notes: null,
      usages: [
        'Mời ai đó một cách lịch sự',
        'Đề nghị, gợi ý',
        'Hỏi về sở thích',
        'Trong giao tiếp trang trọng',
      ],
      examples: [
        GrammarExample(
          english: 'Would you like some coffee?',
          vietnamese: 'Bạn có muốn uống cà phê không?',
          note: 'Mời uống',
        ),
        GrammarExample(
          english: 'Would you like to join us?',
          vietnamese: 'Bạn có muốn tham gia cùng chúng tôi không?',
          note: 'Mời tham gia',
        ),
        GrammarExample(
          english: 'Would you like something to eat?',
          vietnamese: 'Bạn có muốn ăn gì không?',
          note: 'Mời ăn',
        ),
        GrammarExample(
          english: 'Yes, I\'d love to.',
          vietnamese: 'Vâng, tôi rất muốn.',
          note: 'Trả lời đồng ý',
        ),
        GrammarExample(
          english: 'No, thank you. I\'m fine.',
          vietnamese: 'Không, cảm ơn. Tôi ổn.',
          note: 'Trả lời từ chối',
        ),
      ],
      commonMistakes: [
        '❌ Do you like some tea? → ✅ Would you like some tea? (Dùng "do" thay "would")',
        '❌ Would you like go? → ✅ Would you like to go? (Thiếu "to")',
        '❌ Would you like a tea? → ✅ Would you like some tea? (Dùng "a" thay "some")',
        '❌ Yes, I like → ✅ Yes, please / Yes, I\'d love to (Trả lời không phù hợp)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex22_1', type: ExerciseType.multipleChoice, question: '_____ some water?', options: ['Do you like','Would you like','Are you like','You like'], correctAnswer: 'Would you like', explanation: 'Would you like'),
        GrammarExerciseItem(id: 'ex22_2', type: ExerciseType.multipleChoice, question: 'Would you like _____ to the party?', options: ['go','to go','going','goes'], correctAnswer: 'to go', explanation: 'to + V'),
        GrammarExerciseItem(id: 'ex22_3', type: ExerciseType.multipleChoice, question: 'Would you like _____ tea?', options: ['a','an','some','any'], correctAnswer: 'some', explanation: 'some trong lời mời'),
        GrammarExerciseItem(id: 'ex22_4', type: ExerciseType.multipleChoice, question: '_____ you like to join?', options: ['Do','Does','Would','Will'], correctAnswer: 'Would', explanation: 'Would you like'),
        GrammarExerciseItem(id: 'ex22_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Would','you','like','some','coffee'], correctAnswer: 'Would you like some coffee', explanation: 'Lời mời'),
        GrammarExerciseItem(id: 'ex22_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Would','you','like','to','go'], correctAnswer: 'Would you like to go', explanation: 'Would you like + to V'),
        GrammarExerciseItem(id: 'ex22_7', type: ExerciseType.fillInBlank, question: 'Yes, _____ (I/love).', correctAnswer: 'I\'d love to', explanation: 'I\'d love to'),
      ],
      order: 22,
    );
  }

  static GrammarLesson _createLesson23_HowAboutLets() {
    return const GrammarLesson(
      id: 'lesson_23',
      categoryId: 'cat_5',
      title: 'How about...? / Let\'s...',
      objective: 'Học cách gợi ý, rủ rêu trong tiếng Anh',
      theory: '"How about...?" và "Let\'s..." là các cấu trúc dùng để đưa ra gợi ý, rủ rêu ai đó làm gì.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• How about + V-ing?',
        '  Ví dụ: How about going to the cinema?',
        '• How about + danh từ?',
        '  Ví dụ: How about a cup of coffee?',
        '• Let\'s + V',
        '  Ví dụ: Let\'s go to the park.',
      ],
      notes: null,
      usages: [
        'Gợi ý một hoạt động',
        'Rủ rêu ai đó cùng làm',
        'Đề xuất một kế hoạch',
        'Trong giao tiếp thân mật',
      ],
      examples: [
        GrammarExample(
          english: 'How about going to the beach?',
          vietnamese: 'Thế nào về việc đi biển?',
          note: 'Gợi ý hoạt động',
        ),
        GrammarExample(
          english: 'Let\'s watch a movie.',
          vietnamese: 'Chúng ta hãy xem phim.',
          note: 'Rủ rêu',
        ),
        GrammarExample(
          english: 'How about some pizza?',
          vietnamese: 'Thế nào về pizza?',
          note: 'Gợi ý đồ ăn',
        ),
        GrammarExample(
          english: 'Let\'s have lunch together.',
          vietnamese: 'Chúng ta hãy ăn trưa cùng nhau.',
          note: 'Đề xuất',
        ),
        GrammarExample(
          english: 'How about meeting at 5 pm?',
          vietnamese: 'Thế nào về việc gặp lúc 5 giờ chiều?',
          note: 'Gợi ý thời gian',
        ),
      ],
      commonMistakes: [
        '❌ How about go? → ✅ How about going? (Thiếu -ing)',
        '❌ Let\'s to go → ✅ Let\'s go (Thừa "to")',
        '❌ How about to go? → ✅ How about going? (Dùng "to V" thay "V-ing")',
        '❌ Lets go → ✅ Let\'s go (Thiếu dấu phẩy)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex23_1', type: ExerciseType.multipleChoice, question: 'How about _____ to the park?', options: ['go','going','to go','goes'], correctAnswer: 'going', explanation: 'How about + V-ing'),
        GrammarExerciseItem(id: 'ex23_2', type: ExerciseType.multipleChoice, question: 'Let\'s _____ a movie.', options: ['watch','watching','to watch','watches'], correctAnswer: 'watch', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex23_3', type: ExerciseType.multipleChoice, question: 'How about _____ coffee?', options: ['a','an','some','any'], correctAnswer: 'some', explanation: 'some trong gợi ý'),
        GrammarExerciseItem(id: 'ex23_4', type: ExerciseType.multipleChoice, question: 'Let\'s _____ shopping.', options: ['go','going','to go','goes'], correctAnswer: 'go', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex23_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['How','about','going','swimming'], correctAnswer: 'How about going swimming', explanation: 'How about + V-ing'),
        GrammarExerciseItem(id: 'ex23_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Let\'s','watch','a','movie'], correctAnswer: 'Let\'s watch a movie', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex23_7', type: ExerciseType.fillInBlank, question: 'How about _____ (play) tennis?', correctAnswer: 'playing', explanation: 'How about + V-ing'),
      ],
      order: 23,
    );
  }

  static GrammarLesson _createLesson24_DoYouMind() {
    return const GrammarLesson(
      id: 'lesson_24',
      categoryId: 'cat_5',
      title: 'Do you mind if...?',
      objective: 'Học cách xin phép lịch sự trong tiếng Anh',
      theory: '"Do you mind if...?" là cấu trúc dùng để xin phép một cách lịch sự, trang trọng.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Do you mind if + S + V(s/es)?',
        '  Ví dụ: Do you mind if I open the window?',
        '• Would you mind if + S + V2/ed?',
        '  Ví dụ: Would you mind if I opened the window?',
        '• Trả lời: No, not at all. / Of course not.',
        '  Ví dụ: Yes, I do mind. (Từ chối)',
      ],
      notes: null,
      usages: [
        'Xin phép lịch sự',
        'Hỏi xem ai đó có phền không',
        'Trong giao tiếp trang trọng',
        'Thể hiện sự lịch sự, tôn trọng',
      ],
      examples: [
        GrammarExample(
          english: 'Do you mind if I sit here?',
          vietnamese: 'Bạn có phền nếu tôi ngồi đây không?',
          note: 'Xin phép ngồi',
        ),
        GrammarExample(
          english: 'Do you mind if I use your phone?',
          vietnamese: 'Bạn có phền nếu tôi dùng điện thoại của bạn không?',
          note: 'Xin phép dùng',
        ),
        GrammarExample(
          english: 'Would you mind if I opened the window?',
          vietnamese: 'Bạn có phền nếu tôi mở cửa sổ không?',
          note: 'Lịch sự hơn với "would"',
        ),
        GrammarExample(
          english: 'No, not at all.',
          vietnamese: 'Không, không hề.',
          note: 'Trả lời đồng ý',
        ),
        GrammarExample(
          english: 'Of course not. Go ahead.',
          vietnamese: 'Dĩ nhiên là không. Cứ tự nhiên.',
          note: 'Trả lời cho phép',
        ),
      ],
      commonMistakes: [
        '❌ Do you mind if I to sit? → ✅ Do you mind if I sit? (Thừa "to")',
        '❌ Do you mind I sit? → ✅ Do you mind if I sit? (Thiếu "if")',
        '❌ Yes, not at all → ✅ No, not at all (Đồng ý dùng "No")',
        '❌ Would you mind if I open? → ✅ Would you mind if I opened? (Dùng V2/ed sau "would")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex24_1', type: ExerciseType.multipleChoice, question: 'Do you mind if I _____ here?', options: ['sit','sits','sitting','to sit'], correctAnswer: 'sit', explanation: 'Do you mind if + V'),
        GrammarExerciseItem(id: 'ex24_2', type: ExerciseType.multipleChoice, question: 'Would you mind if I _____ the window?', options: ['open','opens','opened','opening'], correctAnswer: 'opened', explanation: 'Would you mind if + V2'),
        GrammarExerciseItem(id: 'ex24_3', type: ExerciseType.multipleChoice, question: '"Do you mind if I smoke?" - "_____, please don\'t."', options: ['No','Yes','Not','Never'], correctAnswer: 'Yes', explanation: 'Từ chối: Yes'),
        GrammarExerciseItem(id: 'ex24_4', type: ExerciseType.multipleChoice, question: 'Do you mind if I _____ your phone?', options: ['use','uses','used','using'], correctAnswer: 'use', explanation: 'Do you mind if + V'),
        GrammarExerciseItem(id: 'ex24_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Do','you','mind','if','I','sit','here'], correctAnswer: 'Do you mind if I sit here', explanation: 'Xin phép'),
        GrammarExerciseItem(id: 'ex24_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['No','not','at','all'], correctAnswer: 'No not at all', explanation: 'Đồng ý'),
        GrammarExerciseItem(id: 'ex24_7', type: ExerciseType.fillInBlank, question: 'Do you mind if I _____ (use) your pen?', correctAnswer: 'use', explanation: 'Do you mind if + V'),
      ],
      order: 24,
    );
  }

  static GrammarLesson _createLesson25_OtherSuggestions() {
    return const GrammarLesson(
      id: 'lesson_25',
      categoryId: 'cat_5',
      title: 'Các Cấu Trúc Gợi Ý Khác',
      objective: 'Học các cấu trúc gợi ý khác trong tiếng Anh',
      theory: 'Có nhiều cấu trúc khác nhau để đưa ra gợi ý, rủ rêu trong tiếng Anh.',
      formulas: [
        '📌 CÁC CẤU TRÚC:',
        '• Why don\'t we + V?',
        '  Ví dụ: Why don\'t we go to the park?',
        '• Shall we + V?',
        '  Ví dụ: Shall we have dinner together?',
        '• What about + V-ing?',
        '  Ví dụ: What about going shopping?',
      ],
      notes: null,
      usages: [
        'Why don\'t we: gợi ý mạnh mẽ',
        'Shall we: gợi ý lịch sự',
        'What about: gợi ý thân thiện',
        'Tất cả đều dùng để rủ rêu',
      ],
      examples: [
        GrammarExample(
          english: 'Why don\'t we take a break?',
          vietnamese: 'Tại sao chúng ta không nghỉ một chút?',
          note: 'Gợi ý nghỉ ngơi',
        ),
        GrammarExample(
          english: 'Shall we dance?',
          vietnamese: 'Chúng ta nhảy nhé?',
          note: 'Rủ rêu lịch sự',
        ),
        GrammarExample(
          english: 'What about having lunch?',
          vietnamese: 'Thế nào về việc ăn trưa?',
          note: 'Gợi ý ăn trưa',
        ),
        GrammarExample(
          english: 'Why don\'t we meet at 6?',
          vietnamese: 'Tại sao chúng ta không gặp lúc 6 giờ?',
          note: 'Gợi ý thời gian',
        ),
        GrammarExample(
          english: 'Shall we start the meeting?',
          vietnamese: 'Chúng ta bắt đầu cuộc họp nhé?',
          note: 'Gợi ý bắt đầu',
        ),
      ],
      commonMistakes: [
        '❌ Why don\'t we to go? → ✅ Why don\'t we go? (Thừa "to")',
        '❌ Shall we to start? → ✅ Shall we start? (Thừa "to")',
        '❌ What about go? → ✅ What about going? (Thiếu -ing)',
        '❌ Why we don\'t go? → ✅ Why don\'t we go? (Sai trật tự)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex25_1', type: ExerciseType.multipleChoice, question: 'Why don\'t we _____ to the beach?', options: ['go','going','to go','goes'], correctAnswer: 'go', explanation: 'Why don\'t we + V'),
        GrammarExerciseItem(id: 'ex25_2', type: ExerciseType.multipleChoice, question: 'Shall we _____ dinner together?', options: ['have','having','to have','has'], correctAnswer: 'have', explanation: 'Shall we + V'),
        GrammarExerciseItem(id: 'ex25_3', type: ExerciseType.multipleChoice, question: 'What about _____ a movie?', options: ['watch','watching','to watch','watches'], correctAnswer: 'watching', explanation: 'What about + V-ing'),
        GrammarExerciseItem(id: 'ex25_4', type: ExerciseType.multipleChoice, question: 'Why don\'t we _____ a taxi?', options: ['take','taking','to take','takes'], correctAnswer: 'take', explanation: 'Why don\'t we + V'),
        GrammarExerciseItem(id: 'ex25_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Why','don\'t','we','go','home'], correctAnswer: 'Why don\'t we go home', explanation: 'Why don\'t we + V'),
        GrammarExerciseItem(id: 'ex25_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Shall','we','dance'], correctAnswer: 'Shall we dance', explanation: 'Shall we + V'),
        GrammarExerciseItem(id: 'ex25_7', type: ExerciseType.fillInBlank, question: 'What about _____ (meet) at 5 pm?', correctAnswer: 'meeting', explanation: 'What about + V-ing'),
      ],
      order: 25,
    );
  }

  // ==================== CATEGORY 2: CẤU TRÚC CÂU ====================
  
  // LESSON 6: Câu so sánh
  static GrammarLesson _createLesson6_Comparatives() {
    return const GrammarLesson(
      id: 'lesson_6',
      categoryId: 'cat_2',
      title: 'Câu So Sánh (Comparatives and Superlatives)',
      objective: 'Nắm vững cách so sánh mức độ giữa hai hoặc nhiều người, vật, sự việc bằng tính từ và trạng từ',
      theory: 'Câu so sánh dùng để thể hiện sự khác biệt về mức độ, tính chất giữa các đối tượng. Có 3 loại: so sánh bằng (ngang nhau), so sánh hơn (vượt trội hơn), và so sánh nhất (vượt trội nhất trong nhóm).',
      formulas: [
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
        '  LOẠI SO SÁNH  │  TRƯỜNG HỢP            │  CÔNG THỨC',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
        '  So sánh bằng  │  Mọi trường hợp        │  S + V + as + Adj/Adv',
        '                │                        │  + as + ...',
        '                │  Ví dụ: She is as tall as her sister.',
        '────────────────────────────────────────────────────────────',
        '  So sánh hơn   │  Tính từ/Trạng từ ngắn │  S + V + Adj/Adv-er',
        '                │                        │  + than + O',
        '                │  Ví dụ: She is taller than me.',
        '                ├────────────────────────┼─────────────────────',
        '                │  Tính từ/Trạng từ dài  │  S + V + more +',
        '                │                        │  Adj/Adv + than + O',
        '                │  Ví dụ: This book is more interesting than that one.',
        '────────────────────────────────────────────────────────────',
        '  So sánh nhất  │  Tính từ/Trạng từ ngắn │  S + V + the +',
        '                │                        │  Adj/Adv-est',
        '                │  Ví dụ: He is the tallest in the class.',
        '                ├────────────────────────┼─────────────────────',
        '                │  Tính từ/Trạng từ dài  │  S + V + the most +',
        '                │                        │  Adj/Adv',
        '                │  Ví dụ: This is the most beautiful place.',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
        '',
        '┌──────────────────────────────────────────────────────────┐',
        '│ 📝 LƯU Ý QUY TẮC THÊM ĐUÔI                               │',
        '├──────────────────────────────────────────────────────────┤',
        '│ • Kết thúc bằng -y: Đổi thành -i rồi thêm er/est        │',
        '│   Ví dụ: happy → happier → happiest                     │',
        '│                                                          │',
        '│ • Kết thúc bằng -er, -ow: Thêm er/est                   │',
        '│   Ví dụ: clever → cleverer → cleverest                  │',
        '└──────────────────────────────────────────────────────────┘',
      ],
      usages: [
        'So sánh bằng: dùng để so sánh 2 người/vật ngang nhau',
        'So sánh hơn: dùng để so sánh 2 người/vật',
        'So sánh nhất: dùng để so sánh 3 người/vật trở lên',
      ],
      examples: [
        GrammarExample(english: 'He runs as fast as me.', vietnamese: 'Anh ấy chạy nhanh như tôi.', note: 'So sánh bằng'),
        GrammarExample(english: 'My house is bigger than yours.', vietnamese: 'Nhà tôi lớn hơn nhà bạn.', note: 'So sánh hơn - tính từ ngắn'),
        GrammarExample(english: 'This exam is more difficult than the last one.', vietnamese: 'Kỳ thi này khó hơn kỳ trước.', note: 'So sánh hơn - tính từ dài'),
        GrammarExample(english: 'She is the smartest student.', vietnamese: 'Cô ấy là học sinh thông minh nhất.', note: 'So sánh nhất'),
      ],
      recognitionSigns: ['Có từ: than, the most, more, as...as', 'Tính từ có đuôi -er, -est'],
      commonMistakes: [
        '❌ more better → ✅ better (good đã có dạng so sánh đặc biệt)',
        '❌ more tall → ✅ taller (tall là tính từ ngắn)',
        '❌ the most tall → ✅ the tallest',
        '❌ as tall than → ✅ as tall as',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex6_1', type: ExerciseType.multipleChoice, question: 'This book is _____ than that one.', options: ['interesting','more interesting','most interesting','the most interesting'], correctAnswer: 'more interesting', explanation: 'So sánh hơn với tính từ dài'),
        GrammarExerciseItem(id: 'ex6_2', type: ExerciseType.multipleChoice, question: 'She is the _____ girl in the class.', options: ['pretty','prettier','prettiest','most pretty'], correctAnswer: 'prettiest', explanation: 'So sánh nhất với tính từ ngắn'),
        GrammarExerciseItem(id: 'ex6_3', type: ExerciseType.multipleChoice, question: 'My car is _____ yours.', options: ['fast than','faster than','more fast than','fastest'], correctAnswer: 'faster than', explanation: 'So sánh hơn: adj-er + than'),
        GrammarExerciseItem(id: 'ex6_4', type: ExerciseType.multipleChoice, question: 'This is _____ expensive restaurant.', options: ['more','most','the most','the more'], correctAnswer: 'the most', explanation: 'So sánh nhất: the most + adj'),
        GrammarExerciseItem(id: 'ex6_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','taller','than','me'], correctAnswer: 'She is taller than me', explanation: 'So sánh hơn'),
        GrammarExerciseItem(id: 'ex6_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['This','is','the','most','beautiful','place'], correctAnswer: 'This is the most beautiful place', explanation: 'So sánh nhất'),
        GrammarExerciseItem(id: 'ex6_7', type: ExerciseType.fillInBlank, question: 'He is _____ (tall) than his brother.', correctAnswer: 'taller', explanation: 'Tính từ ngắn + er'),
      ],
      order: 6,
    );
  }

  // LESSON 7: Câu điều kiện
  static GrammarLesson _createLesson7_Conditionals() {
    return const GrammarLesson(
      id: 'lesson_7',
      categoryId: 'cat_2',
      title: 'Câu Điều Kiện (Conditional Sentences)',
      objective: 'Hiểu và sử dụng thành thạo 4 loại câu điều kiện để diễn tả các tình huống giả định và kết quả tương ứng',
      theory: 'Câu điều kiện diễn tả mối quan hệ giữa điều kiện và kết quả. Gồm mệnh đề IF (điều kiện) và mệnh đề chính (kết quả). Có 4 loại: Loại 0 (chân lý), Loại 1 (có thể xảy ra), Loại 2 (không có thật ở hiện tại), Loại 3 (không có thật ở quá khứ).',
      formulas: [
        '📌 LOẠI 0 (Sự thật hiển nhiên, chân lý):',
        '• If + S + V (hiện tại đơn), S + V (hiện tại đơn)',
        '  Ví dụ: If you heat water to 100°C, it boils.',
        '',
        '📌 LOẠI 1 (Có thể xảy ra ở hiện tại/tương lai):',
        '• If + S + V (hiện tại đơn), S + will + V',
        '  Ví dụ: If it rains, I will stay home.',
        '',
        '📌 LOẠI 2 (Không có thật ở hiện tại):',
        '• If + S + V2/ed (quá khứ đơn), S + would/could + V',
        '  Ví dụ: If I were rich, I would travel the world.',
        '',
        '📌 LOẠI 3 (Không có thật ở quá khứ):',
        '• If + S + had + V3 (quá khứ hoàn thành), S + would/could have + V3',
        '  Ví dụ: If I had studied, I would have passed.',
      ],
      usages: [
        'Loại 0: Sự thật hiển nhiên, chân lý',
        'Loại 1: Điều kiện có thể xảy ra trong tương lai',
        'Loại 2: Điều kiện không có thật ở hiện tại',
        'Loại 3: Điều kiện không có thật trong quá khứ',
      ],
      examples: [
        GrammarExample(english: 'If you heat ice, it melts.', vietnamese: 'Nếu bạn đun nóng nước đá, nó sẽ tan.', note: 'Loại 0 - Chân lý'),
        GrammarExample(english: 'If you study hard, you will pass the exam.', vietnamese: 'Nếu bạn học chăm, bạn sẽ đậu kỳ thi.', note: 'Loại 1'),
        GrammarExample(english: 'If I had a car, I would drive to work.', vietnamese: 'Nếu tôi có xe, tôi sẽ lái xe đi làm.', note: 'Loại 2'),
        GrammarExample(english: 'If she had called me, I would have helped her.', vietnamese: 'Nếu cô ấy đã gọi tôi, tôi đã giúp cô ấy.', note: 'Loại 3'),
      ],
      recognitionSigns: ['Có từ: if, unless, provided that', 'Có will, would, would have'],
      commonMistakes: [
        '❌ If I will have time → ✅ If I have time (không dùng will sau if)',
        '❌ If I was you → ✅ If I were you (dùng were với I/he/she/it)',
        '❌ If I would know → ✅ If I had known',
        '❌ If I studied, I will pass → ✅ If I study, I will pass (loại 1)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex7_1', type: ExerciseType.multipleChoice, question: 'If it _____ tomorrow, we will cancel the trip.', options: ['rain','rains','will rain','rained'], correctAnswer: 'rains', explanation: 'Câu điều kiện loại 1: If + hiện tại đơn'),
        GrammarExerciseItem(id: 'ex7_2', type: ExerciseType.multipleChoice, question: 'If I _____ rich, I would buy a house.', options: ['am','was','were','will be'], correctAnswer: 'were', explanation: 'Câu điều kiện loại 2: If + were'),
        GrammarExerciseItem(id: 'ex7_3', type: ExerciseType.multipleChoice, question: 'If she _____ harder, she would have passed.', options: ['studied','had studied','studies','will study'], correctAnswer: 'had studied', explanation: 'Câu điều kiện loại 3: If + had V3'),
        GrammarExerciseItem(id: 'ex7_4', type: ExerciseType.multipleChoice, question: 'I will help you if you _____ me.', options: ['ask','will ask','asked','would ask'], correctAnswer: 'ask', explanation: 'Loại 1: if + hiện tại đơn'),
        GrammarExerciseItem(id: 'ex7_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['If','it','rains','I','will','stay','home'], correctAnswer: 'If it rains I will stay home', explanation: 'Câu điều kiện loại 1'),
        GrammarExerciseItem(id: 'ex7_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['If','I','were','you','I','would','go'], correctAnswer: 'If I were you I would go', explanation: 'Câu điều kiện loại 2'),
        GrammarExerciseItem(id: 'ex7_7', type: ExerciseType.fillInBlank, question: 'If you _____ (study) hard, you will pass.', correctAnswer: 'study', explanation: 'Loại 1: hiện tại đơn'),
      ],
      order: 7,
    );
  }

  // LESSON 8: Câu ước với wish
  static GrammarLesson _createLesson8_WishSentences() {
    return const GrammarLesson(
      id: 'lesson_8',
      categoryId: 'cat_2',
      title: 'Câu Ước (Wish Sentences)',
      objective: 'Nắm vững cách diễn tả mong ước, ước muốn về điều không có thật ở hiện tại, quá khứ hoặc tương lai',
      theory: 'Câu ước (Wish) dùng để thể hiện mong muốn về điều không có thật hoặc trái ngược với thực tế. Động từ trong mệnh đề sau "wish" luôn lùi thì so với thời điểm ước. hiện tại hoặc quá khứ.',
      formulas: [
        '📌 ƯỚC Ở HIỆN TẠI:',
        '• S + wish + S + V2/ed',
        '  Ví dụ: I wish I were taller.',
        '',
        '📌 ƯỚC Ở QUÁ KHỨ:',
        '• S + wish + S + had + V3',
        '  Ví dụ: I wish I had studied harder.',
        '',
        '📌 ƯỚC Ở TƯƠNG LAI:',
        '• S + wish + S + would + V',
        '  Ví dụ: I wish it would stop raining.',
      ],
      usages: [
        'Wish + quá khứ đơn: ước điều không có thật ở hiện tại',
        'Wish + quá khứ hoàn thành: ước điều không có thật trong quá khứ',
        'Wish + would: ước điều có thể xảy ra trong tương lai',
      ],
      examples: [
        GrammarExample(english: 'I wish I had a car.', vietnamese: 'Tôi ước tôi có xe.', note: 'Ước hiện tại'),
        GrammarExample(english: 'I wish I had gone to the party.', vietnamese: 'Tôi ước tôi đã đi dự tiệc.', note: 'Ước quá khứ'),
        GrammarExample(english: 'I wish you would come with me.', vietnamese: 'Tôi ước bạn sẽ đi cùng tôi.', note: 'Ước tương lai'),
      ],
      recognitionSigns: ['Có từ: wish, if only', 'Động từ lùi thì so với thực tế'],
      commonMistakes: [
        '❌ I wish I am rich → ✅ I wish I were rich',
        '❌ I wish I have studied → ✅ I wish I had studied',
        '❌ I wish I can fly → ✅ I wish I could fly',
        '❌ I wish I was you → ✅ I wish I were you',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex8_1', type: ExerciseType.multipleChoice, question: 'I wish I _____ speak English fluently.', options: ['can','could','will','would'], correctAnswer: 'could', explanation: 'Wish + could (ước hiện tại)'),
        GrammarExerciseItem(id: 'ex8_2', type: ExerciseType.multipleChoice, question: 'She wishes she _____ to the party yesterday.', options: ['go','went','had gone','has gone'], correctAnswer: 'had gone', explanation: 'Wish + had V3 (ước quá khứ)'),
        GrammarExerciseItem(id: 'ex8_3', type: ExerciseType.multipleChoice, question: 'I wish it _____ stop raining.', options: ['will','would','can','could'], correctAnswer: 'would', explanation: 'Wish + would (ước tương lai)'),
        GrammarExerciseItem(id: 'ex8_4', type: ExerciseType.multipleChoice, question: 'I wish I _____ taller.', options: ['am','was','were','will be'], correctAnswer: 'were', explanation: 'Wish + were (ước hiện tại)'),
        GrammarExerciseItem(id: 'ex8_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','wish','I','had','a','car'], correctAnswer: 'I wish I had a car', explanation: 'Câu ước hiện tại'),
        GrammarExerciseItem(id: 'ex8_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','wish','I','had','studied','harder'], correctAnswer: 'I wish I had studied harder', explanation: 'Câu ước quá khứ'),
        GrammarExerciseItem(id: 'ex8_7', type: ExerciseType.fillInBlank, question: 'I wish I _____ (be) rich.', correctAnswer: 'were', explanation: 'Wish + were'),
      ],
      order: 8,
    );
  }

  // LESSON 9: Câu chủ động/bị động
  static GrammarLesson _createLesson9_ActivePassive() {
    return const GrammarLesson(
      id: 'lesson_9',
      categoryId: 'cat_2',
      title: 'Câu Chủ Động và Bị Động (Active and Passive Voice)',
      objective: 'Hiểu rõ sự khác biệt giữa câu chủ động và bị động, thành thạo cách chuyển đổi giữa hai dạng câu',
      theory: 'Câu chủ động: chủ ngữ thực hiện hành động. Câu bị động: chủ ngữ chịu tác động của hành động. Câu bị động nhấn mạnh đối tượng chịu ảnh hưởng hơn là người thực hiện.',
      formulas: [
        '📌 CÔNG THỨC GỐC:',
        '• Chủ động: S + V + O',
        '• Bị động: S (tân ngữ cũ) + be + V3 + by O (chủ ngữ cũ)',
        '',
        '📌 QUY TẮC CHUYỂN ĐỔI:',
        '1. Lấy Tân ngữ (O) câu chủ động → làm Chủ ngữ (S) câu bị động',
        '2. Xác định thì của động từ chính → chia động từ "to be" theo thì đó',
        '3. Động từ chính chuyển thành dạng Phân từ 2 (V_P2)',
        '4. Chủ ngữ (S) câu chủ động → làm tân ngữ sau "by" (hoặc bỏ nếu không xác định)',
        '',
        '📌 CÁC LOẠI CÂU:',
        '• Câu khẳng định: S + be + V3 + by + O',
        '  Ví dụ: The book is read by many people.',
        '• Câu hỏi: Be + S + V3 + by + O?',
        '  Ví dụ: Is the book read by many people?',
        '',
        '📌 CÁC THÌ THƯỜNG DÙNG:',
        '• Hiện tại đơn: am/is/are + V3',
        '• Quá khứ đơn: was/were + V3',
        '• Tương lai: will be + V3',
        '• Hiện tại hoàn thành: have/has been + V3',
      ],
      usages: [
        'Nhấn mạnh hành động và đối tượng chịu tác động',
        'Không biết hoặc không muốn nói ai làm',
        'Văn phong trang trọng, khoa học',
      ],
      examples: [
        GrammarExample(english: 'She writes a letter. → A letter is written by her.', vietnamese: 'Cô ấy viết một lá thư. → Một lá thư được viết bởi cô ấy.', note: 'Chuyển từ chủ động sang bị động'),
        GrammarExample(english: 'The book is read by many people.', vietnamese: 'Cuốn sách được đọc bởi nhiều người.', note: 'Bị động hiện tại'),
        GrammarExample(english: 'The house was built in 1990.', vietnamese: 'Ngôi nhà được xây năm 1990.', note: 'Bị động quá khứ'),
        GrammarExample(english: 'The work will be finished tomorrow.', vietnamese: 'Công việc sẽ được hoàn thành vào ngày mai.', note: 'Bị động tương lai'),
      ],
      recognitionSigns: ['Có be + V3', 'Có by + tân ngữ', 'Nhấn mạnh hành động'],
      commonMistakes: [
        '❌ The book is wrote → ✅ The book is written (dùng V3)',
        '❌ It built in 1990 → ✅ It was built in 1990 (thiếu be)',
        '❌ The letter is write by her → ✅ The letter is written by her',
        '❌ I am interested in → ✅ I am interested in (đúng)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex9_1', type: ExerciseType.multipleChoice, question: 'The book _____ by many students.', options: ['read','reads','is read','is reading'], correctAnswer: 'is read', explanation: 'Bị động: is + V3'),
        GrammarExerciseItem(id: 'ex9_2', type: ExerciseType.multipleChoice, question: 'The house _____ in 1990.', options: ['built','was built','is built','builds'], correctAnswer: 'was built', explanation: 'Bị động quá khứ: was + V3'),
        GrammarExerciseItem(id: 'ex9_3', type: ExerciseType.multipleChoice, question: 'The work _____ tomorrow.', options: ['will finish','will be finish','will be finished','is finished'], correctAnswer: 'will be finished', explanation: 'Bị động tương lai: will be + V3'),
        GrammarExerciseItem(id: 'ex9_4', type: ExerciseType.multipleChoice, question: 'English _____ all over the world.', options: ['speak','speaks','is spoken','is speaking'], correctAnswer: 'is spoken', explanation: 'Bị động hiện tại: is + V3'),
        GrammarExerciseItem(id: 'ex9_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','letter','is','written','by','her'], correctAnswer: 'The letter is written by her', explanation: 'Câu bị động'),
        GrammarExerciseItem(id: 'ex9_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','car','was','bought','yesterday'], correctAnswer: 'The car was bought yesterday', explanation: 'Bị động quá khứ'),
        GrammarExerciseItem(id: 'ex9_7', type: ExerciseType.fillInBlank, question: 'The cake _____ (make) by my mom.', correctAnswer: 'is made', explanation: 'Bị động: is + V3'),
      ],
      order: 9,
    );
  }

  // LESSON 10: Câu giả định
  static GrammarLesson _createLesson10_Subjunctive() {
    return const GrammarLesson(
      id: 'lesson_10',
      categoryId: 'cat_2',
      title: 'Câu Giả Định (Subjunctive Mood)',
      objective: 'Nắm vững cách sử dụng câu giả định để diễn tả yêu cầu, đề nghị, gợi ý một cách lịch sự và trang trọng',
      theory: 'Câu giả định dùng để thể hiện yêu cầu, đề nghị, gợi ý mang tính cầu khiến (không ép buộc). Đặc điểm: động từ sau "that" luôn ở dạng nguyên mẫu không "to", không chia theo ngôi.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• S + suggest/recommend/insist + that + S + (should) + V',
        '  Ví dụ: I suggest that he go now.',
        '• It is + adj + that + S + (should) + V',
        '  Ví dụ: It is important that she be here.',
        '',
        '📌 ĐỘNG TỪ THƯỜNG DÙNG:',
        'suggest, recommend, insist, demand, request, propose, require',
      ],
      usages: [
        'Diễn tả yêu cầu, đề nghị mạnh mẽ',
        'Diễn tả điều cần thiết, quan trọng',
        'Sau các động từ: suggest, recommend, insist',
      ],
      examples: [
        GrammarExample(english: 'I suggest that he study harder.', vietnamese: 'Tôi đề nghị anh ấy học chăm hơn.', note: 'Câu giả định với suggest'),
        GrammarExample(english: 'It is important that she be on time.', vietnamese: 'Quan trọng là cô ấy phải đúng giờ.', note: 'It is + adj + that'),
        GrammarExample(english: 'The doctor recommended that I rest.', vietnamese: 'Bác sĩ khuyên tôi nên nghỉ ngơi.', note: 'Recommend + that'),
      ],
      recognitionSigns: ['Có suggest, recommend, insist', 'Có It is + adj + that', 'Động từ nguyên mẫu không chia'],
      commonMistakes: [
        '❌ I suggest that he goes → ✅ I suggest that he go',
        '❌ It is important that she is → ✅ It is important that she be',
        '❌ I recommend that you studies → ✅ I recommend that you study',
        '❌ He insists that I am → ✅ He insists that I be',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex10_1', type: ExerciseType.multipleChoice, question: 'I suggest that he _____ harder.', options: ['study','studies','studied','studying'], correctAnswer: 'study', explanation: 'Giả định: suggest + that + V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex10_2', type: ExerciseType.multipleChoice, question: 'It is important that she _____ on time.', options: ['is','be','was','been'], correctAnswer: 'be', explanation: 'It is + adj + that + be'),
        GrammarExerciseItem(id: 'ex10_3', type: ExerciseType.multipleChoice, question: 'The teacher recommends that we _____ the book.', options: ['read','reads','reading','to read'], correctAnswer: 'read', explanation: 'Recommend + that + V'),
        GrammarExerciseItem(id: 'ex10_4', type: ExerciseType.multipleChoice, question: 'I insist that he _____ here.', options: ['come','comes','came','coming'], correctAnswer: 'come', explanation: 'Insist + that + V'),
        GrammarExerciseItem(id: 'ex10_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','suggest','that','he','go','now'], correctAnswer: 'I suggest that he go now', explanation: 'Câu giả định'),
        GrammarExerciseItem(id: 'ex10_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','is','important','that','she','be','here'], correctAnswer: 'It is important that she be here', explanation: 'It is + adj + that'),
        GrammarExerciseItem(id: 'ex10_7', type: ExerciseType.fillInBlank, question: 'I recommend that you _____ (study) more.', correctAnswer: 'study', explanation: 'Recommend + that + V'),
      ],
      order: 10,
    );
  }

  // LESSON 11: Câu mệnh lệnh
  static GrammarLesson _createLesson11_Imperative() {
    return const GrammarLesson(
      id: 'lesson_11',
      categoryId: 'cat_2',
      title: 'Câu Mệnh Lệnh (Imperative Sentences)',
      objective: 'Thành thạo cách sử dụng câu mệnh lệnh để ra lệnh, yêu cầu, đưa ra hướng dẫn hoặc lời khuyên',
      theory: 'Câu mệnh lệnh dùng để yêu cầu, ra lệnh, hướng dẫn hoặc đề nghị ai đó làm gì. Đặc điểm: bắt đầu bằng động từ nguyên mẫu, không có chủ ngữ (chủ ngữ ngầm định là "you").',
      formulas: [
        '📌 KHẲNG ĐỊNH:',
        '• V + O',
        '  Ví dụ: Open the door.',
        '• Please + V + O',
        '  Ví dụ: Please sit down.',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Don\'t + V',
        '  Ví dụ: Don\'t be late.',
        '',
        '📌 LỊCH SỰ:',
        '• Let\'s + V (cùng làm)',
        '  Ví dụ: Let\'s go!',
      ],
      usages: [
        'Ra lệnh: Close the door!',
        'Yêu cầu lịch sự: Please help me.',
        'Hướng dẫn: Turn left at the corner.',
        'Đề nghị: Let\'s have lunch.',
      ],
      examples: [
        GrammarExample(english: 'Close the window.', vietnamese: 'Đóng cửa sổ lại.', note: 'Mệnh lệnh đơn giản'),
        GrammarExample(english: 'Please be quiet.', vietnamese: 'Làm ơn im lặng.', note: 'Mệnh lệnh lịch sự'),
        GrammarExample(english: 'Don\'t touch that!', vietnamese: 'Đừng chạm vào cái đó!', note: 'Mệnh lệnh phủ định'),
        GrammarExample(english: 'Let\'s go to the park.', vietnamese: 'Chúng ta đi công viên đi.', note: 'Đề nghị cùng làm'),
      ],
      recognitionSigns: ['Bắt đầu bằng động từ nguyên mẫu', 'Không có chủ ngữ', 'Có Don\'t, Please, Let\'s'],
      commonMistakes: [
        '❌ You close the door → ✅ Close the door (không cần chủ ngữ)',
        '❌ Not be late → ✅ Don\'t be late',
        '❌ Please to help me → ✅ Please help me (không có to)',
        '❌ Let\'s to go → ✅ Let\'s go',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex11_1', type: ExerciseType.multipleChoice, question: '_____ the door, please.', options: ['Close','Closes','Closing','To close'], correctAnswer: 'Close', explanation: 'Câu mệnh lệnh: V nguyên mẫu'),
        GrammarExerciseItem(id: 'ex11_2', type: ExerciseType.multipleChoice, question: '_____ be late!', options: ['Not','Don\'t','Doesn\'t','Didn\'t'], correctAnswer: 'Don\'t', explanation: 'Mệnh lệnh phủ định: Don\'t + V'),
        GrammarExerciseItem(id: 'ex11_3', type: ExerciseType.multipleChoice, question: '_____ go to the cinema.', options: ['Let\'s','Let','Lets','Let us to'], correctAnswer: 'Let\'s', explanation: 'Đề nghị: Let\'s + V'),
        GrammarExerciseItem(id: 'ex11_4', type: ExerciseType.multipleChoice, question: 'Please _____ me.', options: ['help','helps','helping','to help'], correctAnswer: 'help', explanation: 'Please + V'),
        GrammarExerciseItem(id: 'ex11_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Open','the','window'], correctAnswer: 'Open the window', explanation: 'Câu mệnh lệnh'),
        GrammarExerciseItem(id: 'ex11_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Don\'t','touch','that'], correctAnswer: 'Don\'t touch that', explanation: 'Mệnh lệnh phủ định'),
        GrammarExerciseItem(id: 'ex11_7', type: ExerciseType.fillInBlank, question: '_____ (be) quiet, please.', correctAnswer: 'Be', explanation: 'Câu mệnh lệnh với be'),
      ],
      order: 11,
    );
  }

  // LESSON 12: Câu trực tiếp, gián tiếp
  static GrammarLesson _createLesson12_DirectIndirect() {
    return const GrammarLesson(
      id: 'lesson_12',
      categoryId: 'cat_2',
      title: 'Câu Trực Tiếp và Gián Tiếp (Direct and Indirect Speech)',
      objective: 'Thành thạo cách chuyển đổi lời nói trực tiếp sang gián tiếp với các loại câu khác nhau',
      theory: 'Câu trực tiếp: trích dẫn nguyên văn lời nói. Câu gián tiếp: tường thuật lại nội dung lời nói. Khi chuyển đổi cần: lùi thì động từ, đổi đại từ nhân xưng, đổi trạng từ chỉ thời gian và nơi chốn.',
      formulas: [
        '📌 CÂU TRẦN THUẬT:',
        '• Trực tiếp: He said, "I am happy."',
        '• Gián tiếp: He said (that) he was happy.',
        '',
        '📌 CÂU HỎI:',
        '• Trực tiếp: She asked, "Where do you live?"',
        '• Gián tiếp: She asked where I lived.',
        '',
        '📌 CÂU MỆNH LỆNH:',
        '• Trực tiếp: He said, "Close the door."',
        '• Gián tiếp: He told me to close the door.',
        '',
        '📌 BẢNG LÙI THÌ:',
        '• Hiện tại đơn (Simple Present) → Quá khứ đơn (Simple Past)',
        '• Hiện tại tiếp diễn (Present Cont.) → Quá khứ tiếp diễn (Past Cont.)',
        '• Hiện tại hoàn thành (Present Perfect) → Quá khứ hoàn thành (Past Perfect)',
        '• Quá khứ đơn (Simple Past) → Quá khứ hoàn thành (Past Perfect)',
        '',
        '📌 BẢNG ĐỔI TRẠNG TỪ:',
        '• Today → That day',
        '• Now → Then',
        '• Yesterday → The day before',
        '• Here → There',
        '• This → That',
        '• These → Those',
      ],
      usages: [
        'Tường thuật lại lời nói: He said that...',
        'Tường thuật câu hỏi: She asked if/whether...',
        'Tường thuật mệnh lệnh: He told me to...',
        'Lùi thì: hiện tại → quá khứ',
      ],
      examples: [
        GrammarExample(english: 'She said, "I am tired." → She said she was tired.', vietnamese: 'Cô ấy nói cô ấy mệt.', note: 'Lùi thì'),
        GrammarExample(english: 'He asked, "Do you like coffee?" → He asked if I liked coffee.', vietnamese: 'Anh ấy hỏi tôi có thích cà phê không.', note: 'Câu hỏi Yes/No'),
        GrammarExample(english: 'She said, "Open the book." → She told me to open the book.', vietnamese: 'Cô ấy bảo tôi mở sách.', note: 'Mệnh lệnh'),
      ],
      recognitionSigns: ['Có said, told, asked', 'Có that, if, whether', 'Động từ lùi thì'],
      commonMistakes: [
        '❌ He said that he is happy → ✅ He said that he was happy (lùi thì)',
        '❌ She asked that I liked coffee → ✅ She asked if I liked coffee',
        '❌ He told to close → ✅ He told me to close (cần tân ngữ)',
        '❌ She said me → ✅ She told me (said không có tân ngữ trực tiếp)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex12_1', type: ExerciseType.multipleChoice, question: 'She said, "I am happy." → She said she _____ happy.', options: ['is','am','was','were'], correctAnswer: 'was', explanation: 'Lùi thì: am → was'),
        GrammarExerciseItem(id: 'ex12_2', type: ExerciseType.multipleChoice, question: 'He asked, "Do you like tea?" → He asked _____ I liked tea.', options: ['that','if','what','which'], correctAnswer: 'if', explanation: 'Câu hỏi Yes/No dùng if/whether'),
        GrammarExerciseItem(id: 'ex12_3', type: ExerciseType.multipleChoice, question: 'She said, "Close the door." → She told me _____ the door.', options: ['close','to close','closing','closed'], correctAnswer: 'to close', explanation: 'Mệnh lệnh: told + O + to V'),
        GrammarExerciseItem(id: 'ex12_4', type: ExerciseType.multipleChoice, question: 'He _____ that he was tired.', options: ['said','told','asked','spoke'], correctAnswer: 'said', explanation: 'Said + that'),
        GrammarExerciseItem(id: 'ex12_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','said','she','was','happy'], correctAnswer: 'She said she was happy', explanation: 'Câu gián tiếp'),
        GrammarExerciseItem(id: 'ex12_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','asked','if','I','liked','coffee'], correctAnswer: 'He asked if I liked coffee', explanation: 'Câu hỏi gián tiếp'),
        GrammarExerciseItem(id: 'ex12_7', type: ExerciseType.fillInBlank, question: 'She said, "I like music." → She said she _____ (like) music.', correctAnswer: 'liked', explanation: 'Lùi thì: like → liked'),
      ],
      order: 12,
    );
  }

  // LESSON 13: Mệnh đề quan hệ
  static GrammarLesson _createLesson13_RelativeClauses() {
    return const GrammarLesson(
      id: 'lesson_13',
      categoryId: 'cat_2',
      title: 'Mệnh Đề Quan Hệ (Relative Clauses)',
      objective: 'Nắm vững cách sử dụng đại từ quan hệ để nối câu và bổ sung thông tin cho danh từ',
      theory: 'Mệnh đề quan hệ là mệnh đề phụ dùng để bổ sung, làm rõ thông tin cho danh từ đứng trước nó. Được nối bằng các đại từ quan hệ: who (người), which (vật), that (người/vật), whose (sở hữu), where (nơi chốn), when (thời gian).',
      formulas: [
        '📌 ĐẠI TỪ QUAN HỆ:',
        '• WHO: thay cho người (chủ ngữ)',
        '  Ví dụ: The man who is standing there is my teacher.',
        '• WHICH: thay cho vật (chủ ngữ/tân ngữ)',
        '  Ví dụ: The book which I bought is interesting.',
        '• THAT: thay cho người/vật',
        '  Ví dụ: The car that I like is expensive.',
        '• WHOSE: sở hữu',
        '  Ví dụ: The girl whose bag is red is my sister.',
        '• WHERE: nơi chốn',
        '  Ví dụ: The place where I was born is beautiful.',
      ],
      usages: [
        'Who: thay cho người (chủ ngữ)',
        'Which: thay cho vật',
        'That: thay cho cả người và vật',
        'Whose: chỉ sở hữu',
        'Where/When: chỉ nơi chốn/thời gian',
      ],
      examples: [
        GrammarExample(english: 'The man who lives next door is a doctor.', vietnamese: 'Người đàn ông sống bên cạnh là bác sĩ.', note: 'Who thay cho người'),
        GrammarExample(english: 'The book which is on the table is mine.', vietnamese: 'Cuốn sách trên bàn là của tôi.', note: 'Which thay cho vật'),
        GrammarExample(english: 'The girl whose hair is long is my friend.', vietnamese: 'Cô gái có mái tóc dài là bạn tôi.', note: 'Whose chỉ sở hữu'),
        GrammarExample(english: 'The city where I was born is Hanoi.', vietnamese: 'Thành phố nơi tôi sinh ra là Hà Nội.', note: 'Where chỉ nơi chốn'),
      ],
      recognitionSigns: ['Có who, which, that, whose, where, when', 'Nối 2 mệnh đề về cùng danh từ'],
      commonMistakes: [
        '❌ The man which is tall → ✅ The man who is tall (người dùng who)',
        '❌ The book who I read → ✅ The book which/that I read (vật dùng which)',
        '❌ The girl who her bag → ✅ The girl whose bag (sở hữu dùng whose)',
        '❌ The place which I was born → ✅ The place where I was born',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex13_1', type: ExerciseType.multipleChoice, question: 'The man _____ is standing there is my teacher.', options: ['who','which','whose','where'], correctAnswer: 'who', explanation: 'Who thay cho người (chủ ngữ)'),
        GrammarExerciseItem(id: 'ex13_2', type: ExerciseType.multipleChoice, question: 'The book _____ I bought is interesting.', options: ['who','which','whose','where'], correctAnswer: 'which', explanation: 'Which thay cho vật'),
        GrammarExerciseItem(id: 'ex13_3', type: ExerciseType.multipleChoice, question: 'The girl _____ bag is red is my sister.', options: ['who','which','whose','where'], correctAnswer: 'whose', explanation: 'Whose chỉ sở hữu'),
        GrammarExerciseItem(id: 'ex13_4', type: ExerciseType.multipleChoice, question: 'The city _____ I was born is Hanoi.', options: ['who','which','whose','where'], correctAnswer: 'where', explanation: 'Where chỉ nơi chốn'),
        GrammarExerciseItem(id: 'ex13_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','man','who','is','tall','is','my','father'], correctAnswer: 'The man who is tall is my father', explanation: 'Mệnh đề quan hệ với who'),
        GrammarExerciseItem(id: 'ex13_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','book','which','I','read','is','good'], correctAnswer: 'The book which I read is good', explanation: 'Mệnh đề quan hệ với which'),
        GrammarExerciseItem(id: 'ex13_7', type: ExerciseType.fillInBlank, question: 'The girl _____ is singing is my friend.', correctAnswer: 'who', explanation: 'Who thay cho người'),
      ],
      order: 13,
    );
  }
  // ==================== CATEGORY 3: CÁC TỪ LOẠI ====================
  
  // LESSON 14: Đại từ
  static GrammarLesson _createLesson14_Pronouns() {
    return const GrammarLesson(
      id: 'lesson_14',
      categoryId: 'cat_3',
      title: 'Đại Từ (Pronouns)',
      objective: 'Nắm vững các loại đại từ và cách sử dụng chúng để thay thế danh từ, tránh lặp từ trong câu',
      theory: 'Đại từ là từ dùng để thay thế cho danh từ đã được nhắc đến, giúp câu văn ngắn gọn và tránh lặp lại. Có 7 loại đại từ chính: nhân xưng, sở hữu, phản thân, chỉ định, bất định, quan hệ, và nghi vấn.',
      formulas: [
        '📌 CÁC LOẠI ĐẠI TỪ:',
        '• Đại từ nhân xưng: I, you, he, she, it, we, they',
        '• Đại từ sở hữu: mine, yours, his, hers, ours, theirs',
        '• Đại từ phản thân: myself, yourself, himself, herself',
        '• Đại từ chỉ định: this, that, these, those',
        '• Đại từ bất định: someone, anyone, everyone, nobody',
      ],
      usages: [
        'Thay thế danh từ để tránh lặp lại',
        'Chỉ người, vật đã được nhắc đến',
        'Chỉ sở hữu, phản thân, chỉ định',
      ],
      examples: [
        GrammarExample(english: 'John is my friend. He is very kind.', vietnamese: 'John là bạn tôi. Anh ấy rất tốt bụng.', note: 'He thay cho John'),
        GrammarExample(english: 'This book is mine.', vietnamese: 'Cuốn sách này là của tôi.', note: 'Đại từ sở hữu'),
        GrammarExample(english: 'I did it myself.', vietnamese: 'Tôi tự làm điều đó.', note: 'Đại từ phản thân'),
        GrammarExample(english: 'Someone is calling you.', vietnamese: 'Ai đó đang gọi bạn.', note: 'Đại từ bất định'),
      ],
      recognitionSigns: ['Thay thế danh từ', 'Có I, you, he, she, mine, yours, myself'],
      commonMistakes: [
        '❌ Me like it → ✅ I like it (chủ ngữ dùng I)',
        '❌ This is my → ✅ This is mine (sở hữu dùng mine)',
        '❌ I wash me → ✅ I wash myself (phản thân)',
        '❌ He book → ✅ His book (sở hữu trước danh từ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex14_1', type: ExerciseType.multipleChoice, question: '_____ am a student.', options: ['I','Me','My','Mine'], correctAnswer: 'I', explanation: 'Chủ ngữ dùng I'),
        GrammarExerciseItem(id: 'ex14_2', type: ExerciseType.multipleChoice, question: 'This book is _____.', options: ['I','me','my','mine'], correctAnswer: 'mine', explanation: 'Đại từ sở hữu: mine'),
        GrammarExerciseItem(id: 'ex14_3', type: ExerciseType.multipleChoice, question: 'She did it _____.', options: ['her','hers','herself','she'], correctAnswer: 'herself', explanation: 'Đại từ phản thân'),
        GrammarExerciseItem(id: 'ex14_4', type: ExerciseType.multipleChoice, question: '_____ is calling you.', options: ['Anyone','Someone','Everyone','Nobody'], correctAnswer: 'Someone', explanation: 'Đại từ bất định'),
        GrammarExerciseItem(id: 'ex14_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','like','this','book'], correctAnswer: 'I like this book', explanation: 'Đại từ nhân xưng'),
        GrammarExerciseItem(id: 'ex14_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['This','is','mine'], correctAnswer: 'This is mine', explanation: 'Đại từ sở hữu'),
        GrammarExerciseItem(id: 'ex14_7', type: ExerciseType.fillInBlank, question: 'She loves _____ (she).', correctAnswer: 'herself', explanation: 'Đại từ phản thân'),
      ],
      order: 14,
    );
  }

  // LESSON 15: Danh từ
  static GrammarLesson _createLesson15_Nouns() {
    return const GrammarLesson(
      id: 'lesson_15',
      categoryId: 'cat_3',
      title: 'Danh Từ (Nouns)',
      objective: 'Hiểu rõ các loại danh từ và cách phân biệt danh từ đếm được, không đếm được, riêng và chung',
      theory: 'Danh từ là từ chỉ tên người, vật, địa điểm, sự vật, sự việc, hoặc khái niệm. Danh từ có thể đếm được (có số nhiều) hoặc không đếm được (không có số nhiều), có thể là tên riêng (viết hoa) hoặc tên chung.',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Danh từ đếm được: book, car, student (có số nhiều)',
        '• Danh từ không đếm được: water, money, information',
        '',
        '📌 SỐ NHIỀU:',
        '• Thêm -s: book → books',
        '• Thêm -es: box → boxes, class → classes',
        '• Đổi -y thành -ies: baby → babies',
        '• Bất quy tắc: man → men, child → children',
      ],
      usages: [
        'Chỉ người, vật, địa điểm',
        'Danh từ đếm được có số ít và số nhiều',
        'Danh từ không đếm được không có số nhiều',
      ],
      examples: [
        GrammarExample(english: 'I have two books.', vietnamese: 'Tôi có hai cuốn sách.', note: 'Danh từ đếm được số nhiều'),
        GrammarExample(english: 'I need some water.', vietnamese: 'Tôi cần một ít nước.', note: 'Danh từ không đếm được'),
        GrammarExample(english: 'There are many children in the park.', vietnamese: 'Có nhiều trẻ em trong công viên.', note: 'Số nhiều bất quy tắc'),
      ],
      recognitionSigns: ['Chỉ người, vật, địa điểm', 'Có a/an, the, số lượng'],
      commonMistakes: [
        '❌ two book → ✅ two books (số nhiều thêm s)',
        '❌ many water → ✅ much water (không đếm được dùng much)',
        '❌ a information → ✅ some information (không đếm được)',
        '❌ childs → ✅ children (bất quy tắc)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex15_1', type: ExerciseType.multipleChoice, question: 'I have two _____.', options: ['book','books','bookes','book\'s'], correctAnswer: 'books', explanation: 'Số nhiều thêm -s'),
        GrammarExerciseItem(id: 'ex15_2', type: ExerciseType.multipleChoice, question: 'I need some _____.', options: ['water','waters','a water','the waters'], correctAnswer: 'water', explanation: 'Danh từ không đếm được'),
        GrammarExerciseItem(id: 'ex15_3', type: ExerciseType.multipleChoice, question: 'There are many _____ here.', options: ['child','childs','children','childrens'], correctAnswer: 'children', explanation: 'Số nhiều bất quy tắc'),
        GrammarExerciseItem(id: 'ex15_4', type: ExerciseType.multipleChoice, question: 'She has three _____.', options: ['box','boxs','boxes','boxies'], correctAnswer: 'boxes', explanation: 'Thêm -es sau x'),
        GrammarExerciseItem(id: 'ex15_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','two','books'], correctAnswer: 'I have two books', explanation: 'Danh từ số nhiều'),
        GrammarExerciseItem(id: 'ex15_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['There','are','many','children'], correctAnswer: 'There are many children', explanation: 'Số nhiều bất quy tắc'),
        GrammarExerciseItem(id: 'ex15_7', type: ExerciseType.fillInBlank, question: 'I see three _____ (man).', correctAnswer: 'men', explanation: 'Số nhiều bất quy tắc'),
      ],
      order: 15,
    );
  }

  // LESSON 16: Tính từ
  static GrammarLesson _createLesson16_Adjectives() {
    return const GrammarLesson(
      id: 'lesson_16',
      categoryId: 'cat_3',
      title: 'Tính Từ (Adjectives)',
      objective: 'Nắm vững cách sử dụng tính từ để miêu tả, bổ nghĩa cho danh từ và đại từ',
      theory: 'Tính từ là từ dùng để miêu tả hoặc bổ sung thông tin cho danh từ/đại từ. Tính từ thường đứng trước danh từ hoặc sau động từ "to be". Có nhiều loại: miêu tả (beautiful), số lượng (many), chỉ định (this), sở hữu (my), nghi vấn (which).',
      formulas: [
        '📌 VỊ TRÍ:',
        '• Trước danh từ: a beautiful girl',
        '• Sau động từ to be: She is beautiful.',
        '• Sau động từ liên kết: look, seem, feel, taste, smell',
        '',
        '📌 THỨ TỰ TÍNH TỪ:',
        'Opinion - Size - Age - Shape - Color - Origin - Material',
        'Ví dụ: a beautiful big old round red Chinese wooden table',
      ],
      usages: [
        'Mô tả tính chất, đặc điểm của danh từ',
        'Đứng trước danh từ hoặc sau to be',
        'Không chia số nhiều',
      ],
      examples: [
        GrammarExample(english: 'She is a beautiful girl.', vietnamese: 'Cô ấy là một cô gái xinh đẹp.', note: 'Tính từ trước danh từ'),
        GrammarExample(english: 'The flower is beautiful.', vietnamese: 'Bông hoa thật đẹp.', note: 'Tính từ sau to be'),
        GrammarExample(english: 'She looks happy.', vietnamese: 'Cô ấy trông vui vẻ.', note: 'Sau động từ liên kết'),
      ],
      recognitionSigns: ['Mô tả danh từ', 'Đứng trước danh từ hoặc sau be/look/seem'],
      commonMistakes: [
        '❌ a girl beautiful → ✅ a beautiful girl (tính từ trước danh từ)',
        '❌ beautifuls girls → ✅ beautiful girls (tính từ không chia số nhiều)',
        '❌ She is beautifully → ✅ She is beautiful (sau be dùng tính từ)',
        '❌ a big beautiful house → ✅ a beautiful big house (thứ tự tính từ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex16_1', type: ExerciseType.multipleChoice, question: 'She is a _____ girl.', options: ['beauty','beautiful','beautifully','beautify'], correctAnswer: 'beautiful', explanation: 'Tính từ mô tả danh từ'),
        GrammarExerciseItem(id: 'ex16_2', type: ExerciseType.multipleChoice, question: 'The cake tastes _____.', options: ['good','well','goodly','goods'], correctAnswer: 'good', explanation: 'Sau taste dùng tính từ'),
        GrammarExerciseItem(id: 'ex16_3', type: ExerciseType.multipleChoice, question: 'I have _____ books.', options: ['beautiful','beautifuls','a beautiful','the beautiful'], correctAnswer: 'beautiful', explanation: 'Tính từ không chia số nhiều'),
        GrammarExerciseItem(id: 'ex16_4', type: ExerciseType.multipleChoice, question: 'She looks _____.', options: ['happy','happily','happiness','happier'], correctAnswer: 'happy', explanation: 'Sau look dùng tính từ'),
        GrammarExerciseItem(id: 'ex16_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','a','beautiful','girl'], correctAnswer: 'She is a beautiful girl', explanation: 'Tính từ trước danh từ'),
        GrammarExerciseItem(id: 'ex16_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','flower','is','beautiful'], correctAnswer: 'The flower is beautiful', explanation: 'Tính từ sau be'),
        GrammarExerciseItem(id: 'ex16_7', type: ExerciseType.fillInBlank, question: 'He is a _____ (tall) man.', correctAnswer: 'tall', explanation: 'Tính từ mô tả danh từ'),
      ],
      order: 16,
    );
  }

  // LESSON 17: Động từ
  static GrammarLesson _createLesson17_Verbs() {
    return const GrammarLesson(
      id: 'lesson_17',
      categoryId: 'cat_3',
      title: 'Động Từ (Verbs)',
      objective: 'Hiểu rõ các loại động từ và vai trò của chúng trong câu, phân biệt động từ thường, trợ động từ và động từ khiếm khuyết',
      theory: 'Động từ là từ diễn tả hành động, trạng thái hoặc sự tồn tại. Có nhiều loại: động từ thường (run, eat), động từ "to be" (am, is, are), động từ khiếm khuyết (can, must), động từ nối (seem, become), động từ trợ (do, have). Động từ là thành phần bắt buộc trong mọi câu.',
      formulas: [
        '📌 PHÂN LOẠI:',
        '• Động từ thường: run, eat, study, work',
        '• Động từ to be: am, is, are, was, were',
        '• Động từ khuyết thiếu: can, could, will, would, should, must',
        '',
        '📌 CHIA ĐỘNG TỪ:',
        '• Hiện tại đơn ngôi 3: He works (thêm s/es)',
        '• Quá khứ: worked, went, was',
        '• Phân từ: working, worked',
      ],
      usages: [
        'Diễn tả hành động: run, jump, eat',
        'Diễn tả trạng thái: be, seem, appear',
        'Động từ khuyết thiếu: can, must, should',
      ],
      examples: [
        GrammarExample(english: 'She works hard.', vietnamese: 'Cô ấy làm việc chăm chỉ.', note: 'Động từ thường'),
        GrammarExample(english: 'I am a student.', vietnamese: 'Tôi là học sinh.', note: 'Động từ to be'),
        GrammarExample(english: 'You should study.', vietnamese: 'Bạn nên học.', note: 'Động từ khuyết thiếu'),
      ],
      recognitionSigns: ['Chỉ hành động, trạng thái', 'Chia theo thì và ngôi'],
      commonMistakes: [
        '❌ He work → ✅ He works (ngôi 3 thêm s)',
        '❌ I can to go → ✅ I can go (sau modal không có to)',
        '❌ She is work → ✅ She works / She is working',
        '❌ I am agree → ✅ I agree (agree là động từ thường)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex17_1', type: ExerciseType.multipleChoice, question: 'She _____ hard every day.', options: ['work','works','working','worked'], correctAnswer: 'works', explanation: 'Ngôi 3 thêm -s'),
        GrammarExerciseItem(id: 'ex17_2', type: ExerciseType.multipleChoice, question: 'I _____ a student.', options: ['am','is','are','be'], correctAnswer: 'am', explanation: 'To be với I'),
        GrammarExerciseItem(id: 'ex17_3', type: ExerciseType.multipleChoice, question: 'You _____ study harder.', options: ['should','should to','are should','should be'], correctAnswer: 'should', explanation: 'Modal verb + V'),
        GrammarExerciseItem(id: 'ex17_4', type: ExerciseType.multipleChoice, question: 'They _____ football yesterday.', options: ['play','plays','played','playing'], correctAnswer: 'played', explanation: 'Quá khứ đơn'),
        GrammarExerciseItem(id: 'ex17_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','works','hard'], correctAnswer: 'She works hard', explanation: 'Động từ thường'),
        GrammarExerciseItem(id: 'ex17_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','can','swim'], correctAnswer: 'I can swim', explanation: 'Modal verb'),
        GrammarExerciseItem(id: 'ex17_7', type: ExerciseType.fillInBlank, question: 'He _____ (go) to school every day.', correctAnswer: 'goes', explanation: 'Ngôi 3 thêm -es'),
      ],
      order: 17,
    );
  }

  // LESSON 18: Trạng từ
  static GrammarLesson _createLesson18_Adverbs() {
    return const GrammarLesson(
      id: 'lesson_18',
      categoryId: 'cat_3',
      title: 'Trạng Từ (Adverbs)',
      objective: 'Nắm vững cách sử dụng trạng từ để bổ nghĩa cho động từ, tính từ hoặc trạng từ khác',
      theory: 'Trạng từ là từ dùng để bổ nghĩa cho động từ, tính từ hoặc trạng từ khác, cho biết cách thức (how), thời gian (when), nơi chốn (where), tần suất (how often), hoặc mức độ (how much). Nhiều trạng từ được tạo bằng cách thêm "-ly" vào tính từ.',
      formulas: [
        '📌 CÁCH TẠO:',
        '• Tính từ + ly: quick → quickly, slow → slowly',
        '• Bất quy tắc: good → well, fast → fast, hard → hard',
        '',
        '📌 VỊ TRÍ:',
        '• Sau động từ: She runs quickly.',
        '• Trước tính từ: very beautiful',
        '• Đầu câu: Yesterday, I went to school.',
      ],
      usages: [
        'Bổ nghĩa cho động từ: run quickly',
        'Bổ nghĩa cho tính từ: very beautiful',
        'Chỉ thời gian, nơi chốn, cách thức',
      ],
      examples: [
        GrammarExample(english: 'She runs quickly.', vietnamese: 'Cô ấy chạy nhanh.', note: 'Trạng từ bổ nghĩa động từ'),
        GrammarExample(english: 'He is very tall.', vietnamese: 'Anh ấy rất cao.', note: 'Trạng từ bổ nghĩa tính từ'),
        GrammarExample(english: 'Yesterday, I went home.', vietnamese: 'Hôm qua, tôi về nhà.', note: 'Trạng từ chỉ thời gian'),
      ],
      recognitionSigns: ['Có đuôi -ly', 'Bổ nghĩa động từ, tính từ', 'Chỉ cách thức, thời gian'],
      commonMistakes: [
        '❌ She runs quick → ✅ She runs quickly (trạng từ có -ly)',
        '❌ He is very much tall → ✅ He is very tall',
        '❌ I good speak English → ✅ I speak English well',
        '❌ She sings beautiful → ✅ She sings beautifully',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex18_1', type: ExerciseType.multipleChoice, question: 'She runs _____.', options: ['quick','quickly','quickness','quicker'], correctAnswer: 'quickly', explanation: 'Trạng từ có -ly'),
        GrammarExerciseItem(id: 'ex18_2', type: ExerciseType.multipleChoice, question: 'He is _____ tall.', options: ['very','much','many','lot'], correctAnswer: 'very', explanation: 'Very bổ nghĩa tính từ'),
        GrammarExerciseItem(id: 'ex18_3', type: ExerciseType.multipleChoice, question: 'She speaks English _____.', options: ['good','well','goodly','goods'], correctAnswer: 'well', explanation: 'Well là trạng từ của good'),
        GrammarExerciseItem(id: 'ex18_4', type: ExerciseType.multipleChoice, question: 'He works _____.', options: ['hard','hardly','harder','hardest'], correctAnswer: 'hard', explanation: 'Hard vừa là tính từ vừa là trạng từ'),
        GrammarExerciseItem(id: 'ex18_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','runs','quickly'], correctAnswer: 'She runs quickly', explanation: 'Trạng từ sau động từ'),
        GrammarExerciseItem(id: 'ex18_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','is','very','tall'], correctAnswer: 'He is very tall', explanation: 'Very trước tính từ'),
        GrammarExerciseItem(id: 'ex18_7', type: ExerciseType.fillInBlank, question: 'She sings _____ (beautiful).', correctAnswer: 'beautifully', explanation: 'Trạng từ: beautiful + ly'),
      ],
      order: 18,
    );
  }

  // LESSON 19: Lượng từ
  static GrammarLesson _createLesson19_Quantifiers() {
    return const GrammarLesson(
      id: 'lesson_19',
      categoryId: 'cat_3',
      title: 'Lượng Từ (Quantifiers)',
      objective: 'Hiểu rõ cách sử dụng lượng từ với danh từ đếm được và không đếm được',
      theory: 'Lượng từ là từ chỉ số lượng hoặc lượng của danh từ. Một số lượng từ chỉ dùng với danh từ đếm được (many, few), một số chỉ dùng với danh từ không đếm được (much, little), và một số dùng được với cả hai (some, any, a lot of). Việc chọn đúng lượng từ phụ thuộc vào loại danh từ.',
      formulas: [
        '📌 VỚI DANH TỪ ĐẾM ĐƯỢC:',
        '• many, a few, few, several, a number of',
        '  Ví dụ: many books, a few students',
        '',
        '📌 VỚI DANH TỪ KHÔNG ĐẾM ĐƯỢC:',
        '• much, a little, little, a great deal of',
        '  Ví dụ: much water, a little money',
        '',
        '📌 VỚI CẢ HAI:',
        '• some, any, a lot of, lots of, plenty of',
      ],
      usages: [
        'Many/much: nhiều (câu phủ định, nghi vấn)',
        'A lot of: nhiều (câu khẳng định)',
        'Some: một ít (câu khẳng định)',
        'Any: bất kỳ (câu phủ định, nghi vấn)',
      ],
      examples: [
        GrammarExample(english: 'I have many books.', vietnamese: 'Tôi có nhiều sách.', note: 'Many với danh từ đếm được'),
        GrammarExample(english: 'There is much water.', vietnamese: 'Có nhiều nước.', note: 'Much với danh từ không đếm được'),
        GrammarExample(english: 'I need some help.', vietnamese: 'Tôi cần một ít giúp đỡ.', note: 'Some trong câu khẳng định'),
        GrammarExample(english: 'Do you have any questions?', vietnamese: 'Bạn có câu hỏi nào không?', note: 'Any trong câu hỏi'),
      ],
      recognitionSigns: ['Chỉ số lượng', 'Có many, much, some, any, a lot of'],
      commonMistakes: [
        '❌ much books → ✅ many books (đếm được dùng many)',
        '❌ many water → ✅ much water (không đếm được dùng much)',
        '❌ I don\'t have some → ✅ I don\'t have any (phủ định dùng any)',
        '❌ a few water → ✅ a little water',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex19_1', type: ExerciseType.multipleChoice, question: 'I have _____ books.', options: ['many','much','a little','little'], correctAnswer: 'many', explanation: 'Danh từ đếm được dùng many'),
        GrammarExerciseItem(id: 'ex19_2', type: ExerciseType.multipleChoice, question: 'There is _____ water.', options: ['many','much','a few','few'], correctAnswer: 'much', explanation: 'Danh từ không đếm được dùng much'),
        GrammarExerciseItem(id: 'ex19_3', type: ExerciseType.multipleChoice, question: 'I need _____ help.', options: ['some','any','many','much'], correctAnswer: 'some', explanation: 'Câu khẳng định dùng some'),
        GrammarExerciseItem(id: 'ex19_4', type: ExerciseType.multipleChoice, question: 'Do you have _____ questions?', options: ['some','any','many','much'], correctAnswer: 'any', explanation: 'Câu hỏi dùng any'),
        GrammarExerciseItem(id: 'ex19_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','many','books'], correctAnswer: 'I have many books', explanation: 'Many với danh từ đếm được'),
        GrammarExerciseItem(id: 'ex19_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['There','is','much','water'], correctAnswer: 'There is much water', explanation: 'Much với danh từ không đếm được'),
        GrammarExerciseItem(id: 'ex19_7', type: ExerciseType.fillInBlank, question: 'I don\'t have _____ (some/any) money.', correctAnswer: 'any', explanation: 'Phủ định dùng any'),
      ],
      order: 19,
    );
  }

  // LESSON 20: Giới từ
  static GrammarLesson _createLesson20_Prepositions() {
    return const GrammarLesson(
      id: 'lesson_20',
      categoryId: 'cat_3',
      title: 'Giới Từ (Prepositions)',
      objective: 'Nắm vững cách sử dụng giới từ để chỉ thời gian, nơi chốn, hướng và mối quan hệ giữa các từ trong câu',
      theory: 'Giới từ là từ đứng trước danh từ/đại từ để chỉ mối quan hệ về thời gian (at, on, in), nơi chốn (at, on, in, under), hướng (to, from, into), hoặc cách thức (by, with). Giới từ thường tạo thành cụm giới từ và có vai trò quan trọng trong việc diễn đạt ý nghĩa chính xác.',
      formulas: [
        '📌 GIỚI TỪ THỜI GIAN:',
        '• at: at 5pm, at night, at Christmas',
        '• on: on Monday, on May 1st',
        '• in: in 2024, in May, in the morning',
        '',
        '📌 GIỚI TỪ NƠI CHỐN:',
        '• at: at home, at school, at the station',
        '• on: on the table, on the wall',
        '• in: in the room, in the box, in Vietnam',
      ],
      usages: [
        'At: giờ cụ thể, địa điểm nhỏ',
        'On: ngày, bề mặt',
        'In: tháng/năm, không gian kín',
        'To: hướng đến, for: cho ai',
      ],
      examples: [
        GrammarExample(english: 'I wake up at 6am.', vietnamese: 'Tôi thức dậy lúc 6 giờ sáng.', note: 'At với giờ'),
        GrammarExample(english: 'The meeting is on Monday.', vietnamese: 'Cuộc họp vào thứ Hai.', note: 'On với ngày'),
        GrammarExample(english: 'I was born in 1990.', vietnamese: 'Tôi sinh năm 1990.', note: 'In với năm'),
        GrammarExample(english: 'The book is on the table.', vietnamese: 'Cuốn sách ở trên bàn.', note: 'On với bề mặt'),
      ],
      recognitionSigns: ['Đứng trước danh từ', 'Chỉ thời gian, nơi chốn, hướng'],
      commonMistakes: [
        '❌ in 5pm → ✅ at 5pm (giờ dùng at)',
        '❌ at Monday → ✅ on Monday (ngày dùng on)',
        '❌ on 2024 → ✅ in 2024 (năm dùng in)',
        '❌ in the table → ✅ on the table (bề mặt dùng on)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex20_1', type: ExerciseType.multipleChoice, question: 'I wake up _____ 6am.', options: ['at','on','in','to'], correctAnswer: 'at', explanation: 'At với giờ'),
        GrammarExerciseItem(id: 'ex20_2', type: ExerciseType.multipleChoice, question: 'The meeting is _____ Monday.', options: ['at','on','in','to'], correctAnswer: 'on', explanation: 'On với ngày'),
        GrammarExerciseItem(id: 'ex20_3', type: ExerciseType.multipleChoice, question: 'I was born _____ 1990.', options: ['at','on','in','to'], correctAnswer: 'in', explanation: 'In với năm'),
        GrammarExerciseItem(id: 'ex20_4', type: ExerciseType.multipleChoice, question: 'The book is _____ the table.', options: ['at','on','in','to'], correctAnswer: 'on', explanation: 'On với bề mặt'),
        GrammarExerciseItem(id: 'ex20_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','go','to','school','at','7am'], correctAnswer: 'I go to school at 7am', explanation: 'At với giờ'),
        GrammarExerciseItem(id: 'ex20_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','book','is','on','the','table'], correctAnswer: 'The book is on the table', explanation: 'On với bề mặt'),
        GrammarExerciseItem(id: 'ex20_7', type: ExerciseType.fillInBlank, question: 'I live _____ (in/on/at) Vietnam.', correctAnswer: 'in', explanation: 'In với quốc gia'),
      ],
      order: 20,
    );
  }

  // LESSON 21: Mạo từ
  static GrammarLesson _createLesson21_Articles() {
    return const GrammarLesson(
      id: 'lesson_21',
      categoryId: 'cat_3',
      title: 'Mạo Từ (Articles)',
      objective: 'Hiểu rõ cách sử dụng mạo từ a/an/the và khi nào không dùng mạo từ',
      theory: 'Mạo từ là từ đứng trước danh từ để xác định danh từ đó. Có 3 loại: "a/an" (mạo từ không xác định - dùng với danh từ đếm được số ít lần đầu nhắc đến), "the" (mạo từ xác định - dùng với danh từ đã biết hoặc duy nhất), và không dùng mạo từ (với danh từ số nhiều chung chung, danh từ không đếm được).',
      formulas: [
        '📌 MẠO TỪ KHÔNG XÁC ĐỊNH:',
        '• a: trước phụ âm - a book, a car',
        '• an: trước nguyên âm - an apple, an hour',
        '',
        '📌 MẠO TỪ XÁC ĐỊNH:',
        '• the: danh từ đã xác định',
        '  Ví dụ: the book (cuốn sách đó)',
        '',
        '📌 KHÔNG DÙNG MẠO TỪ:',
        '• Danh từ số nhiều chung chung, danh từ không đếm được',
      ],
      usages: [
        'A/An: lần đầu nhắc đến, chưa xác định',
        'The: đã nhắc đến, đã xác định',
        'Không mạo từ: danh từ chung chung',
      ],
      examples: [
        GrammarExample(english: 'I have a book.', vietnamese: 'Tôi có một cuốn sách.', note: 'A - lần đầu nhắc'),
        GrammarExample(english: 'The book is interesting.', vietnamese: 'Cuốn sách đó thú vị.', note: 'The - đã xác định'),
        GrammarExample(english: 'I like books.', vietnamese: 'Tôi thích sách.', note: 'Không mạo từ - chung chung'),
        GrammarExample(english: 'She is an engineer.', vietnamese: 'Cô ấy là kỹ sư.', note: 'An trước nguyên âm'),
      ],
      recognitionSigns: ['Đứng trước danh từ', 'A/an/the'],
      commonMistakes: [
        '❌ a apple → ✅ an apple (nguyên âm dùng an)',
        '❌ a hour → ✅ an hour (h câm dùng an)',
        '❌ I like the books → ✅ I like books (chung chung không dùng the)',
        '❌ the Vietnam → ✅ Vietnam (tên nước không dùng the)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex21_1', type: ExerciseType.multipleChoice, question: 'I have _____ book.', options: ['a','an','the','no article'], correctAnswer: 'a', explanation: 'A trước phụ âm'),
        GrammarExerciseItem(id: 'ex21_2', type: ExerciseType.multipleChoice, question: 'She is _____ engineer.', options: ['a','an','the','no article'], correctAnswer: 'an', explanation: 'An trước nguyên âm'),
        GrammarExerciseItem(id: 'ex21_3', type: ExerciseType.multipleChoice, question: '_____ book is on the table.', options: ['A','An','The','No article'], correctAnswer: 'The', explanation: 'The - đã xác định'),
        GrammarExerciseItem(id: 'ex21_4', type: ExerciseType.multipleChoice, question: 'I like _____ music.', options: ['a','an','the','no article'], correctAnswer: 'no article', explanation: 'Danh từ không đếm được chung chung'),
        GrammarExerciseItem(id: 'ex21_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','a','book'], correctAnswer: 'I have a book', explanation: 'A trước danh từ'),
        GrammarExerciseItem(id: 'ex21_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','an','engineer'], correctAnswer: 'She is an engineer', explanation: 'An trước nguyên âm'),
        GrammarExerciseItem(id: 'ex21_7', type: ExerciseType.fillInBlank, question: 'I see _____ (a/an) elephant.', correctAnswer: 'an', explanation: 'An trước nguyên âm'),
      ],
      order: 21,
    );
  }

  // LESSON 22: Liên từ
  static GrammarLesson _createLesson22_Conjunctions() {
    return const GrammarLesson(
      id: 'lesson_22',
      categoryId: 'cat_3',
      title: 'Liên Từ (Conjunctions)',
      objective: 'Nắm vững cách sử dụng liên từ để nối từ, cụm từ và mệnh đề trong câu',
      theory: 'Liên từ là từ dùng để nối các từ, cụm từ hoặc mệnh đề lại với nhau. Có 3 loại chính: liên từ kết hợp (and, but, or - nối 2 phần ngang nhau), liên từ phụ thuộc (because, although, if - nối mệnh đề phụ với mệnh đề chính), và liên từ tương quan (both...and, either...or - dùng theo cặp).',
      formulas: [
        '📌 LIÊN TỪ KẾT HỢP:',
        '• and: và - I like tea and coffee.',
        '• but: nhưng - She is smart but lazy.',
        '• or: hoặc - Tea or coffee?',
        '• so: vì vậy - I was tired, so I went home.',
        '',
        '📌 LIÊN TỪ PHỤ THUỘC:',
        '• because: vì - I stayed home because it rained.',
        '• although: mặc dù - Although it rained, I went out.',
        '• when, while, if, unless',
      ],
      usages: [
        'And: nối 2 ý tương đương',
        'But: nối 2 ý đối lập',
        'Because: chỉ nguyên nhân',
        'Although: chỉ sự nhượng bộ',
      ],
      examples: [
        GrammarExample(english: 'I like tea and coffee.', vietnamese: 'Tôi thích trà và cà phê.', note: 'And nối 2 danh từ'),
        GrammarExample(english: 'She is smart but lazy.', vietnamese: 'Cô ấy thông minh nhưng lười.', note: 'But chỉ đối lập'),
        GrammarExample(english: 'I stayed home because it rained.', vietnamese: 'Tôi ở nhà vì trời mưa.', note: 'Because chỉ nguyên nhân'),
        GrammarExample(english: 'Although it rained, I went out.', vietnamese: 'Mặc dù trời mưa, tôi vẫn ra ngoài.', note: 'Although chỉ nhượng bộ'),
      ],
      recognitionSigns: ['Nối câu, nối từ', 'Có and, but, or, because, although'],
      commonMistakes: [
        '❌ Although...but → ✅ Although... / ...but (không dùng cả 2)',
        '❌ Because...so → ✅ Because... / ...so',
        '❌ I like and tea coffee → ✅ I like tea and coffee',
        '❌ She smart but lazy → ✅ She is smart but lazy (thiếu động từ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex22_1', type: ExerciseType.multipleChoice, question: 'I like tea _____ coffee.', options: ['and','but','or','so'], correctAnswer: 'and', explanation: 'And nối 2 ý tương đương'),
        GrammarExerciseItem(id: 'ex22_2', type: ExerciseType.multipleChoice, question: 'She is smart _____ lazy.', options: ['and','but','or','so'], correctAnswer: 'but', explanation: 'But chỉ đối lập'),
        GrammarExerciseItem(id: 'ex22_3', type: ExerciseType.multipleChoice, question: 'I stayed home _____ it rained.', options: ['and','but','because','so'], correctAnswer: 'because', explanation: 'Because chỉ nguyên nhân'),
        GrammarExerciseItem(id: 'ex22_4', type: ExerciseType.multipleChoice, question: '_____ it rained, I went out.', options: ['Because','So','Although','And'], correctAnswer: 'Although', explanation: 'Although chỉ nhượng bộ'),
        GrammarExerciseItem(id: 'ex22_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','like','tea','and','coffee'], correctAnswer: 'I like tea and coffee', explanation: 'And nối 2 danh từ'),
        GrammarExerciseItem(id: 'ex22_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','smart','but','lazy'], correctAnswer: 'She is smart but lazy', explanation: 'But chỉ đối lập'),
        GrammarExerciseItem(id: 'ex22_7', type: ExerciseType.fillInBlank, question: 'I was tired, _____ (so/because) I went home.', correctAnswer: 'so', explanation: 'So chỉ kết quả'),
      ],
      order: 22,
    );
  }
  // ==================== CATEGORY 4: CÁC DẠNG CÂU HỎI ====================
  
  // LESSON 23: Các từ để hỏi
  static GrammarLesson _createLesson23_QuestionWords() {
    return const GrammarLesson(
      id: 'lesson_23',
      categoryId: 'cat_4',
      title: 'Các Từ Để Hỏi (Question Words)',
      objective: 'Nắm vững các từ để hỏi (WH-words) và cách sử dụng chúng để hỏi về thông tin cụ thể',
      theory: 'Từ để hỏi (WH-words) là các từ bắt đầu bằng "Wh" (và "How") dùng để hỏi về thông tin cụ thể. Mỗi từ hỏi có mục đích riêng: Who (người), What (vật/sự việc), When (thời gian), Where (nơi chốn), Why (lý do), How (cách thức/mức độ), Which (lựa chọn), Whose (sở hữu).',
      formulas: [
        '📌 CÁC TỪ ĐỂ HỎI:',
        '• Who: Ai (hỏi về người)',
        '• What: Cái gì (hỏi về vật, sự việc)',
        '• When: Khi nào (hỏi về thời gian)',
        '• Where: Ở đâu (hỏi về địa điểm)',
        '• Why: Tại sao (hỏi về lý do)',
        '• How: Như thế nào (hỏi về cách thức)',
        '• Which: Cái nào (hỏi về sự lựa chọn)',
        '• Whose: Của ai (hỏi về sở hữu)',
      ],
      usages: [
        'Who: hỏi về người',
        'What: hỏi về vật, sự việc',
        'When: hỏi về thời gian',
        'Where: hỏi về địa điểm',
        'Why: hỏi về lý do',
        'How: hỏi về cách thức, số lượng',
      ],
      examples: [
        GrammarExample(english: 'Who is that? - That is my teacher.', vietnamese: 'Ai vậy? - Đó là giáo viên của tôi.', note: 'Who hỏi về người'),
        GrammarExample(english: 'What is this? - This is a book.', vietnamese: 'Đây là gì? - Đây là một cuốn sách.', note: 'What hỏi về vật'),
        GrammarExample(english: 'When do you go to school? - At 7am.', vietnamese: 'Bạn đi học khi nào? - Lúc 7 giờ sáng.', note: 'When hỏi về thời gian'),
        GrammarExample(english: 'Where do you live? - I live in Hanoi.', vietnamese: 'Bạn sống ở đâu? - Tôi sống ở Hà Nội.', note: 'Where hỏi về địa điểm'),
      ],
      recognitionSigns: ['Bắt đầu bằng Who, What, When, Where, Why, How', 'Hỏi về thông tin cụ thể'],
      commonMistakes: [
        '❌ Who are you live? → ✅ Where do you live? (địa điểm dùng where)',
        '❌ What you do? → ✅ What do you do? (thiếu trợ động từ)',
        '❌ When is your name? → ✅ What is your name? (tên dùng what)',
        '❌ How you are? → ✅ How are you? (đảo ngữ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex23_1', type: ExerciseType.multipleChoice, question: '_____ is that? - That is my friend.', options: ['Who','What','When','Where'], correctAnswer: 'Who', explanation: 'Who hỏi về người'),
        GrammarExerciseItem(id: 'ex23_2', type: ExerciseType.multipleChoice, question: '_____ do you live? - I live in Hanoi.', options: ['Who','What','When','Where'], correctAnswer: 'Where', explanation: 'Where hỏi về địa điểm'),
        GrammarExerciseItem(id: 'ex23_3', type: ExerciseType.multipleChoice, question: '_____ is your birthday? - In May.', options: ['Who','What','When','Where'], correctAnswer: 'When', explanation: 'When hỏi về thời gian'),
        GrammarExerciseItem(id: 'ex23_4', type: ExerciseType.multipleChoice, question: '_____ are you sad? - Because I failed the exam.', options: ['Who','What','Why','How'], correctAnswer: 'Why', explanation: 'Why hỏi về lý do'),
        GrammarExerciseItem(id: 'ex23_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Who','is','that'], correctAnswer: 'Who is that', explanation: 'Câu hỏi với who'),
        GrammarExerciseItem(id: 'ex23_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Where','do','you','live'], correctAnswer: 'Where do you live', explanation: 'Câu hỏi với where'),
        GrammarExerciseItem(id: 'ex23_7', type: ExerciseType.fillInBlank, question: '_____ (What/When) is your name?', correctAnswer: 'What', explanation: 'Hỏi tên dùng What'),
      ],
      order: 23,
    );
  }

  // LESSON 24: Câu hỏi dùng từ để hỏi
  static GrammarLesson _createLesson24_WHQuestions() {
    return const GrammarLesson(
      id: 'lesson_24',
      categoryId: 'cat_4',
      title: 'Câu Hỏi Wh-',
      objective: 'Nắm vững cách kết hợp từ để hỏi với các thì để tạo câu hỏi Wh- hoàn chỉnh',
      theory: 'Câu hỏi Wh- là câu hỏi bắt đầu bằng từ để hỏi (Who, What, When, Where, Why, How, Which, Whose) để hỏi về thông tin cụ thể. Cấu trúc: Wh-word + động từ trợ/"to be" + chủ ngữ + động từ chính? Không thể trả lời bằng Yes/No, phải trả lời bằng thông tin đầy đủ.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• WH-word + do/does/did + S + V?',
        '  Ví dụ: What do you do?',
        '• WH-word + is/am/are/was/were + S?',
        '  Ví dụ: Where is he?',
        '• WH-word + modal + S + V?',
        '  Ví dụ: What can you do?',
        '',
        '📌 ĐẶC BIỆT:',
        '• Who/What làm chủ ngữ: Who came? (không có do/does)',
      ],
      usages: [
        'Hỏi về thông tin cụ thể',
        'Đảo trợ động từ lên trước chủ ngữ',
        'Who/What làm chủ ngữ không cần trợ động từ',
      ],
      examples: [
        GrammarExample(english: 'What do you do? - I am a teacher.', vietnamese: 'Bạn làm nghề gì? - Tôi là giáo viên.', note: 'What + do'),
        GrammarExample(english: 'Where does she live? - She lives in Hanoi.', vietnamese: 'Cô ấy sống ở đâu? - Cô ấy sống ở Hà Nội.', note: 'Where + does'),
        GrammarExample(english: 'When did you come? - Yesterday.', vietnamese: 'Bạn đến khi nào? - Hôm qua.', note: 'When + did'),
        GrammarExample(english: 'Who came? - John came.', vietnamese: 'Ai đã đến? - John đã đến.', note: 'Who làm chủ ngữ'),
      ],
      recognitionSigns: ['Bắt đầu bằng WH-word', 'Có đảo trợ động từ', 'Hỏi thông tin cụ thể'],
      commonMistakes: [
        '❌ What you do? → ✅ What do you do? (thiếu trợ động từ)',
        '❌ Where does you live? → ✅ Where do you live? (you dùng do)',
        '❌ Who did come? → ✅ Who came? (Who chủ ngữ không cần did)',
        '❌ When you go? → ✅ When do you go?',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex24_1', type: ExerciseType.multipleChoice, question: 'What _____ you do? - I am a student.', options: ['do','does','did','are'], correctAnswer: 'do', explanation: 'You dùng do'),
        GrammarExerciseItem(id: 'ex24_2', type: ExerciseType.multipleChoice, question: 'Where _____ she live?', options: ['do','does','did','is'], correctAnswer: 'does', explanation: 'She dùng does'),
        GrammarExerciseItem(id: 'ex24_3', type: ExerciseType.multipleChoice, question: 'When _____ you come? - Yesterday.', options: ['do','does','did','are'], correctAnswer: 'did', explanation: 'Quá khứ dùng did'),
        GrammarExerciseItem(id: 'ex24_4', type: ExerciseType.multipleChoice, question: 'Who _____ here? - John is.', options: ['do','does','is','are'], correctAnswer: 'is', explanation: 'Who + be'),
        GrammarExerciseItem(id: 'ex24_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['What','do','you','do'], correctAnswer: 'What do you do', explanation: 'Câu hỏi WH'),
        GrammarExerciseItem(id: 'ex24_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Where','does','she','live'], correctAnswer: 'Where does she live', explanation: 'WH-question với does'),
        GrammarExerciseItem(id: 'ex24_7', type: ExerciseType.fillInBlank, question: 'When _____ (do/does) he go to school?', correctAnswer: 'does', explanation: 'He dùng does'),
      ],
      order: 24,
    );
  }

  // LESSON 25: Câu hỏi Yes/No
  static GrammarLesson _createLesson25_YesNoQuestions() {
    return const GrammarLesson(
      id: 'lesson_25',
      categoryId: 'cat_4',
      title: 'Câu Hỏi Yes/No',
      objective: 'Thành thạo cách tạo câu hỏi Yes/No với các thì khác nhau và cách trả lời ngắn gọn',
      theory: 'Câu hỏi Yes/No là câu hỏi chỉ cần trả lời "Có" hoặc "Không". Để tạo câu hỏi này, ta đảo động từ trợ/"to be" lên đầu câu (với "to be", modal verbs) hoặc thêm Do/Does/Did (với động từ thường). Trả lời ngắn: Yes, S + do/does/did/be/modal. No, S + don\'t/doesn\'t/didn\'t/be not/modal not.',
      formulas: [
        '📌 VỚI ĐỘNG TỪ THƯỜNG:',
        '• Do/Does/Did + S + V?',
        '  Ví dụ: Do you like coffee? - Yes, I do.',
        '',
        '📌 VỚI ĐỘNG TỪ TO BE:',
        '• Is/Am/Are/Was/Were + S?',
        '  Ví dụ: Are you a student? - Yes, I am.',
        '',
        '📌 VỚI MODAL VERBS:',
        '• Can/Could/Will/Would/Should + S + V?',
        '  Ví dụ: Can you swim? - Yes, I can.',
      ],
      usages: [
        'Hỏi để xác nhận thông tin',
        'Trả lời Yes hoặc No',
        'Đảo trợ động từ/to be/modal lên đầu',
      ],
      examples: [
        GrammarExample(english: 'Do you like coffee? - Yes, I do.', vietnamese: 'Bạn có thích cà phê không? - Có.', note: 'Câu hỏi với do'),
        GrammarExample(english: 'Is she a teacher? - No, she isn\'t.', vietnamese: 'Cô ấy có phải giáo viên không? - Không.', note: 'Câu hỏi với is'),
        GrammarExample(english: 'Can you swim? - Yes, I can.', vietnamese: 'Bạn có thể bơi không? - Có.', note: 'Câu hỏi với can'),
        GrammarExample(english: 'Did you go there? - No, I didn\'t.', vietnamese: 'Bạn có đi đó không? - Không.', note: 'Câu hỏi với did'),
      ],
      recognitionSigns: ['Bắt đầu bằng Do/Does/Did/Is/Are/Can', 'Trả lời Yes/No', 'Có đảo ngữ'],
      commonMistakes: [
        '❌ You like coffee? → ✅ Do you like coffee? (thiếu do)',
        '❌ Does you like it? → ✅ Do you like it? (you dùng do)',
        '❌ Are you like it? → ✅ Do you like it? (like là động từ thường)',
        '❌ Can you to swim? → ✅ Can you swim? (sau modal không có to)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex25_1', type: ExerciseType.multipleChoice, question: '_____ you like coffee?', options: ['Do','Does','Are','Is'], correctAnswer: 'Do', explanation: 'You + động từ thường dùng do'),
        GrammarExerciseItem(id: 'ex25_2', type: ExerciseType.multipleChoice, question: '_____ she a teacher?', options: ['Do','Does','Is','Are'], correctAnswer: 'Is', explanation: 'She + to be dùng is'),
        GrammarExerciseItem(id: 'ex25_3', type: ExerciseType.multipleChoice, question: '_____ you swim?', options: ['Do','Can','Are','Is'], correctAnswer: 'Can', explanation: 'Hỏi khả năng dùng can'),
        GrammarExerciseItem(id: 'ex25_4', type: ExerciseType.multipleChoice, question: '_____ he go there yesterday?', options: ['Do','Does','Did','Is'], correctAnswer: 'Did', explanation: 'Quá khứ dùng did'),
        GrammarExerciseItem(id: 'ex25_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Do','you','like','coffee'], correctAnswer: 'Do you like coffee', explanation: 'Yes/No question'),
        GrammarExerciseItem(id: 'ex25_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Is','she','a','teacher'], correctAnswer: 'Is she a teacher', explanation: 'Yes/No với to be'),
        GrammarExerciseItem(id: 'ex25_7', type: ExerciseType.fillInBlank, question: '_____ (Do/Does) he like music?', correctAnswer: 'Does', explanation: 'He dùng does'),
      ],
      order: 25,
    );
  }

  // LESSON 26: Câu hỏi lựa chọn
  static GrammarLesson _createLesson26_ChoiceQuestions() {
    return const GrammarLesson(
      id: 'lesson_26',
      categoryId: 'cat_4',
      title: 'Câu Hỏi Lựa Chọn (Choice Questions)',
      objective: 'Học cách đặt câu hỏi lựa chọn giữa các phương án',
      theory: 'Câu hỏi lựa chọn đưa ra 2 hoặc nhiều phương án để người nghe chọn, sử dụng "or" (hoặc).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Do/Does/Did + S + V + A or B?',
        '  Ví dụ: Do you like tea or coffee?',
        '• Is/Are + S + A or B?',
        '  Ví dụ: Is it black or white?',
        '• Which + N + do/does + S + V?',
        '  Ví dụ: Which color do you like?',
        '',
        '📌 TRẢ LỜI:',
        'Chọn một trong các phương án, không trả lời Yes/No',
      ],
      usages: [
        'Đưa ra lựa chọn giữa 2 hoặc nhiều phương án',
        'Sử dụng "or" để nối các lựa chọn',
        'Trả lời bằng cách chọn một phương án',
      ],
      examples: [
        GrammarExample(english: 'Do you like tea or coffee? - I like coffee.', vietnamese: 'Bạn thích trà hay cà phê? - Tôi thích cà phê.', note: 'Lựa chọn giữa 2 đồ uống'),
        GrammarExample(english: 'Is it black or white? - It\'s black.', vietnamese: 'Nó màu đen hay trắng? - Màu đen.', note: 'Lựa chọn màu sắc'),
        GrammarExample(english: 'Which do you prefer, tea or coffee? - Tea.', vietnamese: 'Bạn thích cái nào hơn, trà hay cà phê? - Trà.', note: 'Dùng which'),
        GrammarExample(english: 'Will you go by bus or by car? - By car.', vietnamese: 'Bạn sẽ đi bằng xe buýt hay ô tô? - Bằng ô tô.', note: 'Lựa chọn phương tiện'),
      ],
      recognitionSigns: ['Có "or" trong câu hỏi', 'Đưa ra 2+ lựa chọn', 'Không trả lời Yes/No'],
      commonMistakes: [
        '❌ You like tea and coffee? → ✅ Do you like tea or coffee? (dùng or, không dùng and)',
        '❌ Is it black and white? → ✅ Is it black or white?',
        '❌ Do you like tea or coffee? - Yes → ✅ I like tea/coffee (chọn 1 phương án)',
        '❌ Which you like? → ✅ Which do you like? (thiếu do)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex26_1', type: ExerciseType.multipleChoice, question: 'Do you like tea _____ coffee?', options: ['and','or','but','so'], correctAnswer: 'or', explanation: 'Câu hỏi lựa chọn dùng or'),
        GrammarExerciseItem(id: 'ex26_2', type: ExerciseType.multipleChoice, question: 'Is it black _____ white?', options: ['and','or','but','so'], correctAnswer: 'or', explanation: 'Lựa chọn dùng or'),
        GrammarExerciseItem(id: 'ex26_3', type: ExerciseType.multipleChoice, question: '_____ do you prefer, tea or coffee?', options: ['What','Which','Who','Where'], correctAnswer: 'Which', explanation: 'Which để hỏi lựa chọn'),
        GrammarExerciseItem(id: 'ex26_4', type: ExerciseType.multipleChoice, question: 'Will you go by bus _____ by car?', options: ['and','or','but','so'], correctAnswer: 'or', explanation: 'Lựa chọn phương tiện dùng or'),
        GrammarExerciseItem(id: 'ex26_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Do','you','like','tea','or','coffee'], correctAnswer: 'Do you like tea or coffee', explanation: 'Câu hỏi lựa chọn'),
        GrammarExerciseItem(id: 'ex26_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Is','it','black','or','white'], correctAnswer: 'Is it black or white', explanation: 'Lựa chọn với to be'),
        GrammarExerciseItem(id: 'ex26_7', type: ExerciseType.fillInBlank, question: 'Which do you prefer, tea _____ (and/or) coffee?', correctAnswer: 'or', explanation: 'Lựa chọn dùng or'),
      ],
      order: 26,
    );
  }

  // LESSON 27: Câu hỏi đuôi
  static GrammarLesson _createLesson27_TagQuestions() {
    return const GrammarLesson(
      id: 'lesson_27',
      categoryId: 'cat_4',
      title: 'Câu Hỏi Đuôi (Tag Questions)',
      objective: 'Thành thạo cách tạo câu hỏi đuôi để xác nhận thông tin hoặc tạo sự thân thiện trong giao tiếp',
      theory: 'Câu hỏi đuôi là câu hỏi ngắn được thêm vào cuối câu khẳng định/phủ định để xác nhận thông tin. Quy tắc: Câu chính khẳng định → đuôi phủ định. Câu chính phủ định → đuôi khẳng định. Câu hỏi đuôi dùng động từ trợ/"to be"/modal verb giống câu chính.',
      formulas: [
        '📌 NGUYÊN TẮC:',
        '• Câu khẳng định → đuôi phủ định',
        '  Ví dụ: You are a student, aren\'t you?',
        '• Câu phủ định → đuôi khẳng định',
        '  Ví dụ: You aren\'t a student, are you?',
        '',
        '📌 CẤU TRÚC:',
        '• S + V, trợ động từ + not + S?',
        '• S + don\'t/doesn\'t/didn\'t + V, do/does/did + S?',
        '',
        '📌 ĐẶC BIỆT:',
        '• I am → aren\'t I? (không dùng amn\'t)',
        '• Let\'s → shall we?',
      ],
      usages: [
        'Xác nhận thông tin',
        'Câu khẳng định dùng đuôi phủ định',
        'Câu phủ định dùng đuôi khẳng định',
        'Đại từ trong đuôi phải tương ứng với chủ ngữ',
      ],
      examples: [
        GrammarExample(english: 'You are a student, aren\'t you?', vietnamese: 'Bạn là học sinh, phải không?', note: 'Khẳng định → đuôi phủ định'),
        GrammarExample(english: 'She can swim, can\'t she?', vietnamese: 'Cô ấy có thể bơi, phải không?', note: 'Can → can\'t'),
        GrammarExample(english: 'They don\'t like it, do they?', vietnamese: 'Họ không thích nó, phải không?', note: 'Phủ định → đuôi khẳng định'),
        GrammarExample(english: 'Let\'s go, shall we?', vietnamese: 'Chúng ta đi thôi, nhé?', note: 'Let\'s → shall we'),
      ],
      recognitionSigns: ['Có đuôi câu hỏi ngắn cuối câu', 'Đuôi ngược với câu chính', 'Dùng để xác nhận'],
      commonMistakes: [
        '❌ You are a student, are you? → ✅ You are a student, aren\'t you? (khẳng định → phủ định)',
        '❌ She can swim, can she? → ✅ She can swim, can\'t she?',
        '❌ They like it, don\'t you? → ✅ They like it, don\'t they? (đại từ phải tương ứng)',
        '❌ I am right, amn\'t I? → ✅ I am right, aren\'t I?',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex27_1', type: ExerciseType.multipleChoice, question: 'You are a student, _____ you?', options: ['are','aren\'t','do','don\'t'], correctAnswer: 'aren\'t', explanation: 'Khẳng định → đuôi phủ định'),
        GrammarExerciseItem(id: 'ex27_2', type: ExerciseType.multipleChoice, question: 'She can swim, _____ she?', options: ['can','can\'t','does','doesn\'t'], correctAnswer: 'can\'t', explanation: 'Can → can\'t'),
        GrammarExerciseItem(id: 'ex27_3', type: ExerciseType.multipleChoice, question: 'They don\'t like it, _____ they?', options: ['do','don\'t','are','aren\'t'], correctAnswer: 'do', explanation: 'Phủ định → đuôi khẳng định'),
        GrammarExerciseItem(id: 'ex27_4', type: ExerciseType.multipleChoice, question: 'Let\'s go, _____ we?', options: ['shall','will','do','don\'t'], correctAnswer: 'shall', explanation: 'Let\'s → shall we'),
        GrammarExerciseItem(id: 'ex27_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','are','a','student','aren\'t','you'], correctAnswer: 'You are a student aren\'t you', explanation: 'Câu hỏi đuôi'),
        GrammarExerciseItem(id: 'ex27_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','can','swim','can\'t','she'], correctAnswer: 'She can swim can\'t she', explanation: 'Tag question với can'),
        GrammarExerciseItem(id: 'ex27_7', type: ExerciseType.fillInBlank, question: 'He is tall, _____ (is/isn\'t) he?', correctAnswer: 'isn\'t', explanation: 'Khẳng định → phủ định'),
      ],
      order: 27,
    );
  }
  // ==================== CATEGORY 5: CẤU TRÚC NGỮ PHÁP CƠ BẢN - NHÓM 1 ====================
  
  // LESSON 28: Enough
  static GrammarLesson _createLesson28_Enough() {
    return const GrammarLesson(
      id: 'lesson_28',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Enough',
      objective: 'Nắm vững cách sử dụng "enough" để diễn tả đủ số lượng hoặc mức độ để làm gì đó',
      theory: 'Enough có nghĩa "đủ", dùng để chỉ số lượng hoặc mức độ đủ để thực hiện một hành động. Vị trí: đứng sau tính từ/trạng từ nhưng đứng trước danh từ.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Adj/Adv + enough + (for sb) + to V',
        '  Ví dụ: He is old enough to drive.',
        '• Enough + N + (for sb) + to V',
        '  Ví dụ: I have enough money to buy it.',
      ],
      usages: ['Diễn tả đủ để làm gì', 'Enough đứng sau tính từ/trạng từ', 'Enough đứng trước danh từ'],
      examples: [
        GrammarExample(english: 'She is tall enough to reach the shelf.', vietnamese: 'Cô ấy đủ cao để với tới kệ.', note: 'Adj + enough'),
        GrammarExample(english: 'I have enough time to finish.', vietnamese: 'Tôi có đủ thời gian để hoàn thành.', note: 'Enough + N'),
      ],
      commonMistakes: ['❌ enough tall → ✅ tall enough', '❌ money enough → ✅ enough money'],
      exercises: [
        GrammarExerciseItem(id: 'ex28_1', type: ExerciseType.multipleChoice, question: 'He is _____ to drive.', options: ['enough old','old enough','enough age','age enough'], correctAnswer: 'old enough', explanation: 'Adj + enough'),
        GrammarExerciseItem(id: 'ex28_2', type: ExerciseType.multipleChoice, question: 'I have _____ money.', options: ['enough','money enough','too','very'], correctAnswer: 'enough', explanation: 'Enough + N'),
        GrammarExerciseItem(id: 'ex28_3', type: ExerciseType.multipleChoice, question: 'She is smart _____ to solve it.', options: ['enough','too','very','so'], correctAnswer: 'enough', explanation: 'Adj + enough + to V'),
        GrammarExerciseItem(id: 'ex28_4', type: ExerciseType.multipleChoice, question: 'We have _____ time to finish.', options: ['enough','time enough','too','very'], correctAnswer: 'enough', explanation: 'Enough + N'),
        GrammarExerciseItem(id: 'ex28_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['He','is','old','enough','to','drive'], correctAnswer: 'He is old enough to drive', explanation: 'Adj + enough + to V'),
        GrammarExerciseItem(id: 'ex28_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','have','enough','money'], correctAnswer: 'I have enough money', explanation: 'Enough + N'),
        GrammarExerciseItem(id: 'ex28_7', type: ExerciseType.fillInBlank, question: 'She is tall _____ (enough/too) to play basketball.', correctAnswer: 'enough', explanation: 'Adj + enough'),
      ],
      order: 28,
    );
  }

  // LESSON 29: Suggest
  static GrammarLesson _createLesson29_Suggest() {
    return const GrammarLesson(
      id: 'lesson_29',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Suggest',
      objective: 'Nắm vững cách sử dụng "suggest" để đưa ra đề nghị, gợi ý một cách lịch sự',
      theory: 'Suggest dùng để đưa ra đề nghị, gợi ý ai đó làm gì. Có 2 cấu trúc: suggest + V-ing (gợi ý làm gì) hoặc suggest + (that) + S + (should) + V (gợi ý ai nên làm gì).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Suggest + V-ing',
        '  Ví dụ: I suggest going to the park.',
        '• Suggest + (that) + S + (should) + V',
        '  Ví dụ: I suggest that we go now.',
      ],
      usages: ['Đưa ra đề nghị', 'Gợi ý làm gì đó'],
      examples: [
        GrammarExample(english: 'I suggest going home.', vietnamese: 'Tôi đề nghị về nhà.', note: 'Suggest + V-ing'),
        GrammarExample(english: 'She suggests that we study harder.', vietnamese: 'Cô ấy đề nghị chúng ta học chăm hơn.', note: 'Suggest + that'),
      ],
      commonMistakes: ['❌ suggest to go → ✅ suggest going', '❌ suggest that we goes → ✅ suggest that we go'],
      exercises: [
        GrammarExerciseItem(id: 'ex29_1', type: ExerciseType.multipleChoice, question: 'I suggest _____ home.', options: ['go','going','to go','goes'], correctAnswer: 'going', explanation: 'Suggest + V-ing'),
        GrammarExerciseItem(id: 'ex29_2', type: ExerciseType.multipleChoice, question: 'She suggests that we _____ now.', options: ['go','goes','going','to go'], correctAnswer: 'go', explanation: 'Suggest + that + V'),
        GrammarExerciseItem(id: 'ex29_3', type: ExerciseType.multipleChoice, question: 'I suggest _____ a break.', options: ['take','taking','to take','takes'], correctAnswer: 'taking', explanation: 'Suggest + V-ing'),
        GrammarExerciseItem(id: 'ex29_4', type: ExerciseType.multipleChoice, question: 'He suggests that she _____ harder.', options: ['study','studies','studying','to study'], correctAnswer: 'study', explanation: 'Suggest + that + V'),
        GrammarExerciseItem(id: 'ex29_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','suggest','going','home'], correctAnswer: 'I suggest going home', explanation: 'Suggest + V-ing'),
        GrammarExerciseItem(id: 'ex29_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['She','suggests','that','we','go'], correctAnswer: 'She suggests that we go', explanation: 'Suggest + that'),
        GrammarExerciseItem(id: 'ex29_7', type: ExerciseType.fillInBlank, question: 'I suggest _____ (study) together.', correctAnswer: 'studying', explanation: 'Suggest + V-ing'),
      ],
      order: 29,
    );
  }

  // LESSON 30: Hope
  static GrammarLesson _createLesson30_Hope() {
    return const GrammarLesson(
      id: 'lesson_30',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Hope',
      objective: 'Nắm vững cách sử dụng "hope" để diễn tả hy vọng, mong muốn điều tốt đẹp xảy ra',
      theory: 'Hope dùng để diễn tả hy vọng, mong muốn điều gì đó tốt đẹp xảy ra trong tương lai. Có 2 cấu trúc: hope + to V (hy vọng tự mình làm gì) hoặc hope + (that) + S + V (hy vọng ai/điều gì xảy ra).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Hope + to V',
        '  Ví dụ: I hope to see you soon.',
        '• Hope + (that) + S + V',
        '  Ví dụ: I hope that you will pass.',
      ],
      usages: ['Diễn tả hy vọng', 'Mong muốn điều tốt đẹp'],
      examples: [
        GrammarExample(english: 'I hope to pass the exam.', vietnamese: 'Tôi hy vọng đậu kỳ thi.', note: 'Hope + to V'),
        GrammarExample(english: 'I hope you will be happy.', vietnamese: 'Tôi hy vọng bạn sẽ hạnh phúc.', note: 'Hope + that'),
      ],
      commonMistakes: ['❌ hope going → ✅ hope to go', '❌ hope that you goes → ✅ hope that you go'],
      exercises: [
        GrammarExerciseItem(id: 'ex30_1', type: ExerciseType.multipleChoice, question: 'I hope _____ you soon.', options: ['see','to see','seeing','sees'], correctAnswer: 'to see', explanation: 'Hope + to V'),
        GrammarExerciseItem(id: 'ex30_2', type: ExerciseType.multipleChoice, question: 'I hope that you _____ pass.', options: ['will','would','can','could'], correctAnswer: 'will', explanation: 'Hope + that + will'),
        GrammarExerciseItem(id: 'ex30_3', type: ExerciseType.multipleChoice, question: 'She hopes _____ a doctor.', options: ['be','to be','being','is'], correctAnswer: 'to be', explanation: 'Hope + to V'),
        GrammarExerciseItem(id: 'ex30_4', type: ExerciseType.multipleChoice, question: 'We hope _____ it rains.', options: ['that','if','when','because'], correctAnswer: 'that', explanation: 'Hope + that'),
        GrammarExerciseItem(id: 'ex30_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','hope','to','see','you'], correctAnswer: 'I hope to see you', explanation: 'Hope + to V'),
        GrammarExerciseItem(id: 'ex30_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','hope','you','will','pass'], correctAnswer: 'I hope you will pass', explanation: 'Hope + that'),
        GrammarExerciseItem(id: 'ex30_7', type: ExerciseType.fillInBlank, question: 'I hope _____ (pass) the exam.', correctAnswer: 'to pass', explanation: 'Hope + to V'),
      ],
      order: 30,
    );
  }

  // LESSON 31: Used to
  static GrammarLesson _createLesson31_UsedTo() {
    return const GrammarLesson(
      id: 'lesson_31',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Used To',
      objective: 'Nắm vững cách sử dụng "used to" để diễn tả thói quen hoặc trạng thái trong quá khứ',
      theory: 'Used to diễn tả thói quen hoặc trạng thái trong quá khứ, hiện tại không còn nữa. Khác với "be used to" (quen với) và "get used to" (dần quen với).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Used to + V',
        '  Ví dụ: I used to play football.',
        '• Didn\'t use to + V (phủ định)',
        '  Ví dụ: I didn\'t use to like coffee.',
      ],
      usages: ['Thói quen trong quá khứ', 'Trạng thái trong quá khứ không còn nữa'],
      examples: [
        GrammarExample(english: 'I used to smoke.', vietnamese: 'Tôi đã từng hút thuốc.', note: 'Thói quen quá khứ'),
        GrammarExample(english: 'She used to live in Hanoi.', vietnamese: 'Cô ấy đã từng sống ở Hà Nội.', note: 'Trạng thái quá khứ'),
      ],
      commonMistakes: ['❌ used to smoking → ✅ used to smoke', '❌ use to go → ✅ used to go'],
      exercises: [
        GrammarExerciseItem(id: 'ex31_1', type: ExerciseType.multipleChoice, question: 'I used to _____ football.', options: ['play','playing','played','plays'], correctAnswer: 'play', explanation: 'Used to + V'),
        GrammarExerciseItem(id: 'ex31_2', type: ExerciseType.multipleChoice, question: 'She _____ live here.', options: ['use to','used to','using to','uses to'], correctAnswer: 'used to', explanation: 'Used to + V'),
        GrammarExerciseItem(id: 'ex31_3', type: ExerciseType.multipleChoice, question: 'I didn\'t _____ like coffee.', options: ['use to','used to','using to','uses to'], correctAnswer: 'use to', explanation: 'Didn\'t use to'),
        GrammarExerciseItem(id: 'ex31_4', type: ExerciseType.multipleChoice, question: 'They used to _____ here.', options: ['work','working','worked','works'], correctAnswer: 'work', explanation: 'Used to + V'),
        GrammarExerciseItem(id: 'ex31_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','used','to','play','football'], correctAnswer: 'I used to play football', explanation: 'Used to + V'),
        GrammarExerciseItem(id: 'ex31_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['She','used','to','live','here'], correctAnswer: 'She used to live here', explanation: 'Used to + V'),
        GrammarExerciseItem(id: 'ex31_7', type: ExerciseType.fillInBlank, question: 'I used to _____ (smoke).', correctAnswer: 'smoke', explanation: 'Used to + V'),
      ],
      order: 31,
    );
  }

  // LESSON 32: Mind
  static GrammarLesson _createLesson32_Mind() {
    return const GrammarLesson(
      id: 'lesson_32',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Mind',
      objective: 'Nắm vững cách sử dụng "mind" để hỏi ý kiến một cách lịch sự và diễn tả phiền/không phiền',
      theory: 'Mind dùng để hỏi ý kiến một cách lịch sự (Do you mind...?), hoặc diễn tả phiền/không phiền (I don\'t mind). Mind + V-ing.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Do you mind + V-ing?',
        '  Ví dụ: Do you mind opening the door?',
        '• Would you mind + V-ing?',
        '  Ví dụ: Would you mind helping me?',
      ],
      usages: ['Hỏi ý kiến lịch sự', 'Nhờ vả ai đó làm gì'],
      examples: [
        GrammarExample(english: 'Do you mind closing the window?', vietnamese: 'Bạn có phiền đóng cửa sổ không?', note: 'Do you mind + V-ing'),
        GrammarExample(english: 'Would you mind waiting?', vietnamese: 'Bạn có phiền đợi không?', note: 'Would you mind + V-ing'),
      ],
      commonMistakes: ['❌ mind to open → ✅ mind opening', '❌ mind open → ✅ mind opening'],
      exercises: [
        GrammarExerciseItem(id: 'ex32_1', type: ExerciseType.multipleChoice, question: 'Do you mind _____ the door?', options: ['open','opening','to open','opens'], correctAnswer: 'opening', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_2', type: ExerciseType.multipleChoice, question: 'Would you mind _____ me?', options: ['help','helping','to help','helps'], correctAnswer: 'helping', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_3', type: ExerciseType.multipleChoice, question: 'Do you mind _____ here?', options: ['wait','waiting','to wait','waits'], correctAnswer: 'waiting', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_4', type: ExerciseType.multipleChoice, question: 'Would you mind _____ the window?', options: ['close','closing','to close','closes'], correctAnswer: 'closing', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Do','you','mind','opening','the','door'], correctAnswer: 'Do you mind opening the door', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Would','you','mind','helping','me'], correctAnswer: 'Would you mind helping me', explanation: 'Mind + V-ing'),
        GrammarExerciseItem(id: 'ex32_7', type: ExerciseType.fillInBlank, question: 'Do you mind _____ (wait)?', correctAnswer: 'waiting', explanation: 'Mind + V-ing'),
      ],
      order: 32,
    );
  }

  // LESSON 33: Would you like
  static GrammarLesson _createLesson33_WouldYouLike() {
    return const GrammarLesson(
      id: 'lesson_33',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Would You Like',
      objective: 'Nắm vững cách sử dụng "would you like" để mời hoặc đề nghị một cách lịch sự',
      theory: 'Would you like dùng để mời hoặc đề nghị một cách lịch sự, lịch thiệp hơn "Do you want". Would you like + N (mời cái gì), would you like + to V (mời làm gì).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Would you like + N?',
        '  Ví dụ: Would you like some coffee?',
        '• Would you like + to V?',
        '  Ví dụ: Would you like to go?',
      ],
      usages: ['Mời ai đó', 'Đề nghị lịch sự'],
      examples: [
        GrammarExample(english: 'Would you like some tea?', vietnamese: 'Bạn có muốn uống trà không?', note: 'Would you like + N'),
        GrammarExample(english: 'Would you like to come?', vietnamese: 'Bạn có muốn đến không?', note: 'Would you like + to V'),
      ],
      commonMistakes: ['❌ Would you like going? → ✅ Would you like to go?', '❌ Do you like to go? → ✅ Would you like to go? (lịch sự hơn)'],
      exercises: [
        GrammarExerciseItem(id: 'ex33_1', type: ExerciseType.multipleChoice, question: 'Would you like _____ coffee?', options: ['some','any','a','an'], correctAnswer: 'some', explanation: 'Would you like + some'),
        GrammarExerciseItem(id: 'ex33_2', type: ExerciseType.multipleChoice, question: 'Would you like _____ go?', options: ['to','for','at','in'], correctAnswer: 'to', explanation: 'Would you like + to V'),
        GrammarExerciseItem(id: 'ex33_3', type: ExerciseType.multipleChoice, question: 'Would you like _____ tea?', options: ['some','any','a','an'], correctAnswer: 'some', explanation: 'Would you like + some'),
        GrammarExerciseItem(id: 'ex33_4', type: ExerciseType.multipleChoice, question: 'Would you like _____ come with us?', options: ['to','for','at','in'], correctAnswer: 'to', explanation: 'Would you like + to V'),
        GrammarExerciseItem(id: 'ex33_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Would','you','like','some','coffee'], correctAnswer: 'Would you like some coffee', explanation: 'Would you like + N'),
        GrammarExerciseItem(id: 'ex33_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Would','you','like','to','go'], correctAnswer: 'Would you like to go', explanation: 'Would you like + to V'),
        GrammarExerciseItem(id: 'ex33_7', type: ExerciseType.fillInBlank, question: 'Would you like _____ (come) with me?', correctAnswer: 'to come', explanation: 'Would you like + to V'),
      ],
      order: 33,
    );
  }

  // LESSON 34: As if / As though
  static GrammarLesson _createLesson34_AsIfAsThough() {
    return const GrammarLesson(
      id: 'lesson_34',
      categoryId: 'cat_5',
      title: 'Cách Dùng As If và As Though',
      objective: 'Nắm vững cách sử dụng "as if/as though" để diễn tả như thể, giống như',
      theory: 'As if / As though dùng để diễn tả điều gì đó giống như, như thể. Thường dùng với thì quá khứ để diễn tả điều không có thật.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• S + V + as if/as though + S + V (past)',
        '  Ví dụ: He acts as if he were rich.',
      ],
      usages: ['Diễn tả như thể', 'So sánh không có thật'],
      examples: [
        GrammarExample(english: 'She looks as if she were tired.', vietnamese: 'Cô ấy trông như thể mệt mỏi.', note: 'As if + quá khứ'),
        GrammarExample(english: 'He talks as though he knew everything.', vietnamese: 'Anh ấy nói như thể biết mọi thứ.', note: 'As though + quá khứ'),
      ],
      commonMistakes: ['❌ as if he is → ✅ as if he were', '❌ as though she knows → ✅ as though she knew'],
      exercises: [
        GrammarExerciseItem(id: 'ex34_1', type: ExerciseType.multipleChoice, question: 'He acts as if he _____ rich.', options: ['is','was','were','be'], correctAnswer: 'were', explanation: 'As if + were'),
        GrammarExerciseItem(id: 'ex34_2', type: ExerciseType.multipleChoice, question: 'She looks as though she _____ tired.', options: ['is','was','were','be'], correctAnswer: 'were', explanation: 'As though + were'),
        GrammarExerciseItem(id: 'ex34_3', type: ExerciseType.multipleChoice, question: 'He talks as if he _____ everything.', options: ['know','knows','knew','known'], correctAnswer: 'knew', explanation: 'As if + quá khứ'),
        GrammarExerciseItem(id: 'ex34_4', type: ExerciseType.multipleChoice, question: 'She acts as though she _____ the boss.', options: ['is','was','were','be'], correctAnswer: 'were', explanation: 'As though + were'),
        GrammarExerciseItem(id: 'ex34_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['He','acts','as','if','he','were','rich'], correctAnswer: 'He acts as if he were rich', explanation: 'As if + were'),
        GrammarExerciseItem(id: 'ex34_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['She','looks','as','though','she','were','tired'], correctAnswer: 'She looks as though she were tired', explanation: 'As though + were'),
        GrammarExerciseItem(id: 'ex34_7', type: ExerciseType.fillInBlank, question: 'He talks as if he _____ (know) everything.', correctAnswer: 'knew', explanation: 'As if + quá khứ'),
      ],
      order: 34,
    );
  }

  // LESSON 35: Although
  static GrammarLesson _createLesson35_Although() {
    return const GrammarLesson(
      id: 'lesson_35',
      categoryId: 'cat_5',
      title: 'Cách Dùng Although',
      objective: 'Nắm vững cách sử dụng "although" để diễn tả sự nhượng bộ, mặc dù',
      theory: 'Although dùng để diễn tả sự nhượng bộ, mặc dù, theo sau là mệnh đề (S + V). Tương tự "though", "even though".',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Although + S + V, S + V',
        '  Ví dụ: Although it rained, I went out.',
      ],
      usages: ['Diễn tả mặc dù', 'Sự tương phản'],
      examples: [
        GrammarExample(english: 'Although he is rich, he is not happy.', vietnamese: 'Mặc dù giàu, anh ấy không hạnh phúc.', note: 'Although + S + V'),
        GrammarExample(english: 'Although it was cold, we went swimming.', vietnamese: 'Mặc dù lạnh, chúng tôi vẫn đi bơi.', note: 'Although + S + V'),
      ],
      commonMistakes: ['❌ Although...but → ✅ Although... (không dùng but)', '❌ Although rich → ✅ Although he is rich (cần S + V)'],
      exercises: [
        GrammarExerciseItem(id: 'ex35_1', type: ExerciseType.multipleChoice, question: 'Although it _____, I went out.', options: ['rain','rains','rained','raining'], correctAnswer: 'rained', explanation: 'Although + S + V'),
        GrammarExerciseItem(id: 'ex35_2', type: ExerciseType.multipleChoice, question: '_____ he is rich, he is not happy.', options: ['Although','But','Because','So'], correctAnswer: 'Although', explanation: 'Although diễn tả mặc dù'),
        GrammarExerciseItem(id: 'ex35_3', type: ExerciseType.multipleChoice, question: 'Although she _____ tired, she kept working.', options: ['is','was','were','be'], correctAnswer: 'was', explanation: 'Although + S + V'),
        GrammarExerciseItem(id: 'ex35_4', type: ExerciseType.multipleChoice, question: 'Although it was cold, we _____ swimming.', options: ['go','goes','went','going'], correctAnswer: 'went', explanation: 'Mệnh đề chính'),
        GrammarExerciseItem(id: 'ex35_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Although','it','rained','I','went','out'], correctAnswer: 'Although it rained I went out', explanation: 'Although + S + V'),
        GrammarExerciseItem(id: 'ex35_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Although','he','is','rich','he','is','not','happy'], correctAnswer: 'Although he is rich he is not happy', explanation: 'Although + S + V'),
        GrammarExerciseItem(id: 'ex35_7', type: ExerciseType.fillInBlank, question: 'Although she _____ (be) tired, she kept working.', correctAnswer: 'was', explanation: 'Although + S + V'),
      ],
      order: 35,
    );
  }

  // LESSON 36: In spite of
  static GrammarLesson _createLesson36_InSpiteOf() {
    return const GrammarLesson(
      id: 'lesson_36',
      categoryId: 'cat_5',
      title: 'Cách Dùng In Spite Of',
      objective: 'Nắm vững cách sử dụng "in spite of/despite" để diễn tả mặc dù với cụm danh từ',
      theory: 'In spite of / Despite dùng để diễn tả mặc dù, theo sau là danh từ/V-ing (không phải mệnh đề). Khác với "although" (+ S + V).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• In spite of / Despite + N/V-ing, S + V',
        '  Ví dụ: In spite of the rain, I went out.',
      ],
      usages: ['Diễn tả mặc dù', 'Theo sau là danh từ hoặc V-ing'],
      examples: [
        GrammarExample(english: 'In spite of being tired, she kept working.', vietnamese: 'Mặc dù mệt, cô ấy vẫn làm việc.', note: 'In spite of + V-ing'),
        GrammarExample(english: 'Despite the rain, we went out.', vietnamese: 'Mặc dù mưa, chúng tôi vẫn ra ngoài.', note: 'Despite + N'),
      ],
      commonMistakes: ['❌ in spite of it rained → ✅ in spite of the rain', '❌ despite of → ✅ despite (không có of)'],
      exercises: [
        GrammarExerciseItem(id: 'ex36_1', type: ExerciseType.multipleChoice, question: 'In spite of _____, I went out.', options: ['rain','the rain','it rained','raining'], correctAnswer: 'the rain', explanation: 'In spite of + N'),
        GrammarExerciseItem(id: 'ex36_2', type: ExerciseType.multipleChoice, question: 'Despite _____ tired, she worked.', options: ['be','being','is','was'], correctAnswer: 'being', explanation: 'Despite + V-ing'),
        GrammarExerciseItem(id: 'ex36_3', type: ExerciseType.multipleChoice, question: 'In spite of _____ hard, he failed.', options: ['study','studying','studied','studies'], correctAnswer: 'studying', explanation: 'In spite of + V-ing'),
        GrammarExerciseItem(id: 'ex36_4', type: ExerciseType.multipleChoice, question: '_____ the cold weather, we went swimming.', options: ['Although','Despite','Because','So'], correctAnswer: 'Despite', explanation: 'Despite + N'),
        GrammarExerciseItem(id: 'ex36_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['In','spite','of','the','rain','I','went','out'], correctAnswer: 'In spite of the rain I went out', explanation: 'In spite of + N'),
        GrammarExerciseItem(id: 'ex36_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Despite','being','tired','she','worked'], correctAnswer: 'Despite being tired she worked', explanation: 'Despite + V-ing'),
        GrammarExerciseItem(id: 'ex36_7', type: ExerciseType.fillInBlank, question: 'In spite of _____ (study) hard, he failed.', correctAnswer: 'studying', explanation: 'In spite of + V-ing'),
      ],
      order: 36,
    );
  }

  // LESSON 37: Because of
  static GrammarLesson _createLesson37_BecauseOf() {
    return const GrammarLesson(
      id: 'lesson_37',
      categoryId: 'cat_5',
      title: 'Cách Sử Dụng Because Of',
      objective: 'Nắm vững cách sử dụng "because of" để diễn tả nguyên nhân với cụm danh từ hoặc V-ing',
      theory: 'Because of có nghĩa "vì", "bởi vì", dùng để chỉ nguyên nhân, lý do của một sự việc. Sau "because of" PHẢI là danh từ (N) hoặc V-ing, KHÔNG được là mệnh đề (S + V). Khác với "because" (+ S + V). Because of = Due to = Owing to (trang trọng hơn).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Because of + N/V-ing, S + V',
        '  Ví dụ: Because of the rain, I stayed home.',
        '• S + V + because of + N/V-ing',
        '  Ví dụ: I stayed home because of the rain.',
      ],
      usages: ['Chỉ nguyên nhân, lý do', 'Theo sau là N hoặc V-ing', 'Khác với because (+ S + V)', 'Because of = Due to = Owing to'],
      examples: [
        GrammarExample(english: 'Because of the rain, I stayed home.', vietnamese: 'Vì mưa, tôi ở nhà.', note: 'Because of + N'),
        GrammarExample(english: 'I failed because of being lazy.', vietnamese: 'Tôi trượt vì lười biếng.', note: 'Because of + V-ing'),
        GrammarExample(english: 'She was late because of the traffic.', vietnamese: 'Cô ấy trễ vì tắc đường.', note: 'Nguyên nhân'),
        GrammarExample(english: 'Because of studying hard, he passed.', vietnamese: 'Vì học chăm chỉ, anh ấy đã đậu.', note: 'Because of + V-ing'),
      ],
      commonMistakes: [
        '❌ because of it rained → ✅ because of the rain / because it rained (không dùng S + V sau because of)',
        '❌ because the rain → ✅ because of the rain (cần "of")',
        '❌ because of he was sick → ✅ because of his sickness / because he was sick',
        '❌ because of study → ✅ because of studying (cần V-ing)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex37_1', type: ExerciseType.multipleChoice, question: 'Because of _____, I stayed home.', options: ['rain','the rain','it rained','raining'], correctAnswer: 'the rain', explanation: 'Because of + N'),
        GrammarExerciseItem(id: 'ex37_2', type: ExerciseType.multipleChoice, question: 'I failed because of _____ lazy.', options: ['be','being','is','was'], correctAnswer: 'being', explanation: 'Because of + V-ing'),
        GrammarExerciseItem(id: 'ex37_3', type: ExerciseType.multipleChoice, question: 'Because of _____ hard, he passed.', options: ['study','studying','studied','studies'], correctAnswer: 'studying', explanation: 'Because of + V-ing'),
        GrammarExerciseItem(id: 'ex37_4', type: ExerciseType.multipleChoice, question: 'She was late _____ the traffic.', options: ['because','because of','although','despite'], correctAnswer: 'because of', explanation: 'Because of + N'),
        GrammarExerciseItem(id: 'ex37_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['Because','of','the','rain','I','stayed','home'], correctAnswer: 'Because of the rain I stayed home', explanation: 'Because of + N'),
        GrammarExerciseItem(id: 'ex37_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp:', wordBank: ['I','failed','because','of','being','lazy'], correctAnswer: 'I failed because of being lazy', explanation: 'Because of + V-ing'),
        GrammarExerciseItem(id: 'ex37_7', type: ExerciseType.fillInBlank, question: 'Because of _____ (study) hard, he passed.', correctAnswer: 'studying', explanation: 'Because of + V-ing'),
      ],
      order: 37,
    );
  }
  // ==================== CATEGORY 5: NHÓM 2 ====================
  
  static GrammarLesson _createLesson38_SoSuchToo() {
    return const GrammarLesson(
      id: 'lesson_38',
      categoryId: 'cat_5',
      title: 'Cấu Trúc So, Such, Too',
      objective: 'Nắm vững cách phân biệt và sử dụng "so", "such", "too" để diễn tả mức độ quá',
      theory: 'So, Such và Too đều có nghĩa "quá", nhưng cấu trúc và cách dùng khác nhau. "So" đứng trước tính từ/trạng từ, "such" đứng trước danh từ (có thể có tính từ bổ nghĩa), "too" diễn tả quá...đến mức không thể làm gì. Hiểu rõ sự khác biệt giúp diễn đạt chính xác mức độ trong tiếng Anh.',
      formulas: [
        '📌 SO:',
        '• So + adj/adv + that + S + V',
        '  Ví dụ: It is so hot that I can\'t sleep.',
        '  (Nóng quá đến nỗi tôi không ngủ được)',
        '',
        '📌 SUCH:',
        '• Such + (a/an) + adj + N + that + S + V',
        '  Ví dụ: It is such a hot day that I can\'t work.',
        '  (Đó là một ngày nóng quá đến nỗi tôi không làm việc được)',
        '',
        '📌 TOO:',
        '• Too + adj/adv + to V',
        '  Ví dụ: It is too hot to work.',
        '  (Nóng quá không thể làm việc)',
      ],
      usages: [
        'So: đứng trước tính từ/trạng từ, nhấn mạnh mức độ',
        'Such: đứng trước danh từ (có thể có a/an và tính từ)',
        'Too: diễn tả quá...không thể làm gì',
        'So/Such thường đi với "that" để chỉ kết quả',
      ],
      examples: [
        GrammarExample(english: 'She is so beautiful that everyone loves her.', vietnamese: 'Cô ấy đẹp quá đến nỗi mọi người đều yêu cô ấy.', note: 'So + adj + that'),
        GrammarExample(english: 'It was such a difficult exam that many students failed.', vietnamese: 'Đó là một kỳ thi khó quá đến nỗi nhiều học sinh trượt.', note: 'Such + a + adj + N + that'),
        GrammarExample(english: 'The coffee is too hot to drink.', vietnamese: 'Cà phê nóng quá không uống được.', note: 'Too + adj + to V'),
        GrammarExample(english: 'He runs so fast that no one can catch him.', vietnamese: 'Anh ấy chạy nhanh quá không ai bắt kịp.', note: 'So + adv + that'),
      ],
      recognitionSigns: ['Có so/such/too', 'Diễn tả mức độ quá', 'Thường có that hoặc to'],
      commonMistakes: [
        '❌ so a hot day → ✅ such a hot day (such + a + adj + N)',
        '❌ such hot → ✅ so hot (so + adj, không có danh từ)',
        '❌ too hot that → ✅ so hot that / too hot to (too không đi với that)',
        '❌ such beautiful → ✅ so beautiful (beautiful là tính từ, dùng so)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex38_1', type: ExerciseType.multipleChoice, question: 'It is _____ hot that I can\'t sleep.', options: ['so','such','too','very'], correctAnswer: 'so', explanation: 'So + adj + that'),
        GrammarExerciseItem(id: 'ex38_2', type: ExerciseType.multipleChoice, question: 'It is _____ a hot day.', options: ['so','such','too','very'], correctAnswer: 'such', explanation: 'Such + a + adj + N'),
        GrammarExerciseItem(id: 'ex38_3', type: ExerciseType.multipleChoice, question: 'It is _____ hot to work.', options: ['so','such','too','very'], correctAnswer: 'too', explanation: 'Too + adj + to V'),
        GrammarExerciseItem(id: 'ex38_4', type: ExerciseType.multipleChoice, question: 'She is _____ beautiful that everyone loves her.', options: ['so','such','too','very'], correctAnswer: 'so', explanation: 'So + adj + that'),
        GrammarExerciseItem(id: 'ex38_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','is','so','hot','that','I','can\'t','sleep'], correctAnswer: 'It is so hot that I can\'t sleep', explanation: 'So + adj + that'),
        GrammarExerciseItem(id: 'ex38_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','is','such','a','nice','day'], correctAnswer: 'It is such a nice day', explanation: 'Such + a + adj + N'),
        GrammarExerciseItem(id: 'ex38_7', type: ExerciseType.fillInBlank, question: 'The coffee is _____ (too/so) hot to drink.', correctAnswer: 'too', explanation: 'Too + adj + to V'),
      ],
      order: 38,
    );
  }

  static GrammarLesson _createLesson39_AsWellAs() {
    return const GrammarLesson(
      id: 'lesson_39',
      categoryId: 'cat_5',
      title: 'Cấu Trúc As Well As',
      objective: 'Nắm vững cách sử dụng "as well as" để nối hai thành phần tương đương',
      theory: 'As well as có nghĩa "cũng như", "và cả", dùng để nối hai thành phần tương đương (danh từ, động từ, tính từ...). Nó tương tự "and" nhưng trang trọng hơn và nhấn mạnh vào phần đứng trước "as well as". Động từ chia theo chủ ngữ đứng trước "as well as".',
      formulas: [
        '📌 CẤU TRÚC:',
        '• A as well as B',
        '  Ví dụ: She speaks English as well as French.',
        '  (Cô ấy nói tiếng Anh cũng như tiếng Pháp)',
        '',
        '📌 CHÚ Ý:',
        '• Động từ chia theo A, không theo B',
        '  Ví dụ: Tom as well as his friends is coming.',
      ],
      usages: [
        'Nối 2 thành phần tương đương',
        'Trang trọng hơn "and"',
        'Nhấn mạnh vào phần đứng trước',
        'Động từ chia theo chủ ngữ đứng trước "as well as"',
      ],
      examples: [
        GrammarExample(english: 'She speaks English as well as French.', vietnamese: 'Cô ấy nói tiếng Anh cũng như tiếng Pháp.', note: 'Nối 2 danh từ'),
        GrammarExample(english: 'He plays football as well as basketball.', vietnamese: 'Anh ấy chơi bóng đá cũng như bóng rổ.', note: 'As well as'),
        GrammarExample(english: 'Tom as well as his friends is coming.', vietnamese: 'Tom cũng như các bạn anh ấy đang đến.', note: 'Động từ chia theo Tom'),
        GrammarExample(english: 'She is beautiful as well as intelligent.', vietnamese: 'Cô ấy đẹp cũng như thông minh.', note: 'Nối 2 tính từ'),
      ],
      recognitionSigns: ['Có "as well as"', 'Nối 2 thành phần tương đương'],
      commonMistakes: [
        '❌ as well → ✅ as well as (thiếu "as" cuối)',
        '❌ Tom as well as his friends are → ✅ Tom as well as his friends is (động từ theo Tom)',
        '❌ She speaks as well as English French → ✅ She speaks English as well as French',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex39_1', type: ExerciseType.multipleChoice, question: 'She speaks English _____ French.', options: ['as well as','as well','also','too'], correctAnswer: 'as well as', explanation: 'As well as nối 2 ngôn ngữ'),
        GrammarExerciseItem(id: 'ex39_2', type: ExerciseType.multipleChoice, question: 'He plays football _____ basketball.', options: ['as well as','as well','also','too'], correctAnswer: 'as well as', explanation: 'As well as'),
        GrammarExerciseItem(id: 'ex39_3', type: ExerciseType.multipleChoice, question: 'Tom as well as his friends _____ coming.', options: ['is','are','am','be'], correctAnswer: 'is', explanation: 'Động từ chia theo Tom'),
        GrammarExerciseItem(id: 'ex39_4', type: ExerciseType.multipleChoice, question: 'She is beautiful _____ intelligent.', options: ['as well as','as well','also','too'], correctAnswer: 'as well as', explanation: 'Nối 2 tính từ'),
        GrammarExerciseItem(id: 'ex39_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','speaks','English','as','well','as','French'], correctAnswer: 'She speaks English as well as French', explanation: 'As well as'),
        GrammarExerciseItem(id: 'ex39_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','plays','football','as','well','as','basketball'], correctAnswer: 'He plays football as well as basketball', explanation: 'As well as'),
        GrammarExerciseItem(id: 'ex39_7', type: ExerciseType.fillInBlank, question: 'She is kind _____ (as well as/as well) smart.', correctAnswer: 'as well as', explanation: 'As well as'),
      ],
      order: 39,
    );
  }

  static GrammarLesson _createLesson40_NotOnlyButAlso() {
    return const GrammarLesson(
      id: 'lesson_40',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Not Only… But Also',
      objective: 'Nắm vững cách sử dụng "not only...but also" để nhấn mạnh cả hai đặc điểm',
      theory: 'Not only...but also có nghĩa "không chỉ...mà còn", dùng để nhấn mạnh cả hai thành phần, thường là hai đặc điểm tích cực. Cấu trúc này trang trọng hơn "and" và tạo sự nhấn mạnh mạnh mẽ. Có thể bỏ "also" trong văn nói thông thường.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Not only A but also B',
        '  Ví dụ: She is not only beautiful but also smart.',
        '  (Cô ấy không chỉ đẹp mà còn thông minh)',
        '',
        '📌 ĐẢO NGỮ (trang trọng):',
        '• Not only + trợ động từ + S + V, but S + also + V',
        '  Ví dụ: Not only does she sing, but she also dances.',
      ],
      usages: [
        'Nhấn mạnh cả 2 đặc điểm',
        'Không chỉ...mà còn',
        'Trang trọng hơn "and"',
        'Có thể bỏ "also" trong văn nói',
      ],
      examples: [
        GrammarExample(english: 'She is not only beautiful but also smart.', vietnamese: 'Cô ấy không chỉ đẹp mà còn thông minh.', note: 'Not only...but also'),
        GrammarExample(english: 'He is not only rich but also kind.', vietnamese: 'Anh ấy không chỉ giàu mà còn tốt bụng.', note: 'Nhấn mạnh 2 đặc điểm'),
        GrammarExample(english: 'She not only sings but also dances.', vietnamese: 'Cô ấy không chỉ hát mà còn nhảy.', note: 'Nối 2 động từ'),
        GrammarExample(english: 'Not only does she speak English, but she also speaks French.', vietnamese: 'Cô ấy không chỉ nói tiếng Anh mà còn nói tiếng Pháp.', note: 'Đảo ngữ'),
      ],
      recognitionSigns: ['Có "not only...but also"', 'Nhấn mạnh 2 ý', 'Không chỉ...mà còn'],
      commonMistakes: [
        '❌ not only...but → ✅ not only...but also (thiếu also)',
        '❌ not only...and also → ✅ not only...but also (dùng but, không dùng and)',
        '❌ She is not only beautiful but smart also → ✅ She is not only beautiful but also smart',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex40_1', type: ExerciseType.multipleChoice, question: 'She is not only beautiful _____ smart.', options: ['but also','but','also','and'], correctAnswer: 'but also', explanation: 'Not only...but also'),
        GrammarExerciseItem(id: 'ex40_2', type: ExerciseType.multipleChoice, question: 'He is not only rich _____ kind.', options: ['but also','but','also','and'], correctAnswer: 'but also', explanation: 'Not only...but also'),
        GrammarExerciseItem(id: 'ex40_3', type: ExerciseType.multipleChoice, question: 'She not only sings _____ dances.', options: ['but also','but','also','and'], correctAnswer: 'but also', explanation: 'Nối 2 động từ'),
        GrammarExerciseItem(id: 'ex40_4', type: ExerciseType.multipleChoice, question: 'He is not only talented _____ hardworking.', options: ['but also','but','also','and'], correctAnswer: 'but also', explanation: 'Not only...but also'),
        GrammarExerciseItem(id: 'ex40_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','is','not','only','beautiful','but','also','smart'], correctAnswer: 'She is not only beautiful but also smart', explanation: 'Not only...but also'),
        GrammarExerciseItem(id: 'ex40_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','not','only','sings','but','also','dances'], correctAnswer: 'He not only sings but also dances', explanation: 'Nối động từ'),
        GrammarExerciseItem(id: 'ex40_7', type: ExerciseType.fillInBlank, question: 'She is not only kind _____ (but also/but) generous.', correctAnswer: 'but also', explanation: 'Not only...but also'),
      ],
      order: 40,
    );
  }

  static GrammarLesson _createLesson41_WouldRather() {
    return const GrammarLesson(
      id: 'lesson_41',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Would Rather',
      objective: 'Nắm vững cách sử dụng "would rather" để diễn tả sở thích, lựa chọn',
      theory: 'Would rather có nghĩa "thích...hơn", "muốn...hơn", dùng để diễn tả sở thích cá nhân hoặc lựa chọn giữa hai việc. Sau "would rather" là động từ nguyên mẫu không "to". Có thể viết tắt thành "\'d rather". Phủ định: would rather not + V.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Would rather + V (nguyên mẫu)',
        '  Ví dụ: I would rather stay home.',
        '  (Tôi thích ở nhà hơn)',
        '',
        '• Would rather + V + than + V',
        '  Ví dụ: I would rather stay than go.',
        '  (Tôi thích ở lại hơn là đi)',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Would rather not + V',
        '  Ví dụ: I would rather not go.',
      ],
      usages: [
        'Diễn tả sở thích cá nhân',
        'Lựa chọn giữa 2 việc',
        'Sau would rather là V nguyên mẫu (không to)',
        'Có thể viết tắt: \'d rather',
      ],
      examples: [
        GrammarExample(english: 'I would rather stay home than go out.', vietnamese: 'Tôi thích ở nhà hơn ra ngoài.', note: 'Would rather...than'),
        GrammarExample(english: 'She\'d rather drink tea.', vietnamese: 'Cô ấy thích uống trà hơn.', note: 'Viết tắt \'d rather'),
        GrammarExample(english: 'I would rather not tell you.', vietnamese: 'Tôi không muốn nói với bạn.', note: 'Would rather not'),
        GrammarExample(english: 'He would rather walk than take the bus.', vietnamese: 'Anh ấy thích đi bộ hơn là đi xe buýt.', note: 'So sánh 2 hành động'),
      ],
      recognitionSigns: ['Có "would rather"', 'Diễn tả sở thích', 'Sau đó là V nguyên mẫu'],
      commonMistakes: [
        '❌ would rather to stay → ✅ would rather stay (không có "to")',
        '❌ would rather staying → ✅ would rather stay (V nguyên mẫu)',
        '❌ I would rather not to go → ✅ I would rather not go',
        '❌ would rather than go → ✅ would rather stay than go (cần động từ trước than)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex41_1', type: ExerciseType.multipleChoice, question: 'I would rather _____ home.', options: ['stay','to stay','staying','stayed'], correctAnswer: 'stay', explanation: 'Would rather + V'),
        GrammarExerciseItem(id: 'ex41_2', type: ExerciseType.multipleChoice, question: 'She would rather _____ than go.', options: ['stay','to stay','staying','stayed'], correctAnswer: 'stay', explanation: 'Would rather + V'),
        GrammarExerciseItem(id: 'ex41_3', type: ExerciseType.multipleChoice, question: 'I would rather _____ tell you.', options: ['not','don\'t','not to','doesn\'t'], correctAnswer: 'not', explanation: 'Would rather not'),
        GrammarExerciseItem(id: 'ex41_4', type: ExerciseType.multipleChoice, question: 'He\'d rather _____ than drive.', options: ['walk','to walk','walking','walked'], correctAnswer: 'walk', explanation: '\'d rather + V'),
        GrammarExerciseItem(id: 'ex41_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','would','rather','stay','home'], correctAnswer: 'I would rather stay home', explanation: 'Would rather + V'),
        GrammarExerciseItem(id: 'ex41_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','would','rather','drink','tea','than','coffee'], correctAnswer: 'She would rather drink tea than coffee', explanation: 'Would rather...than'),
        GrammarExerciseItem(id: 'ex41_7', type: ExerciseType.fillInBlank, question: 'I would rather _____ (walk) than take the bus.', correctAnswer: 'walk', explanation: 'Would rather + V'),
      ],
      order: 41,
    );
  }

  static GrammarLesson _createLesson42_Prefer() {
    return const GrammarLesson(
      id: 'lesson_42',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Prefer',
      objective: 'Nắm vững cách sử dụng "prefer" để diễn tả sở thích, thích cái gì hơn',
      theory: 'Prefer có nghĩa "thích...hơn", dùng để diễn tả sở thích giữa hai lựa chọn. Có 3 cấu trúc chính: prefer A to B (thích A hơn B với danh từ), prefer V-ing to V-ing (thích làm gì hơn làm gì), prefer to V rather than V (thích làm gì hơn là làm gì - trang trọng hơn).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Prefer A to B (danh từ)',
        '  Ví dụ: I prefer tea to coffee.',
        '  (Tôi thích trà hơn cà phê)',
        '',
        '• Prefer V-ing to V-ing',
        '  Ví dụ: I prefer reading to watching TV.',
        '  (Tôi thích đọc sách hơn xem TV)',
        '',
        '• Prefer to V rather than (V)',
        '  Ví dụ: I prefer to stay rather than go.',
        '  (Tôi thích ở lại hơn là đi)',
      ],
      usages: [
        'Diễn tả sở thích giữa 2 lựa chọn',
        'Prefer A to B: với danh từ',
        'Prefer V-ing to V-ing: với động từ',
        'Prefer to V rather than V: trang trọng hơn',
      ],
      examples: [
        GrammarExample(english: 'I prefer tea to coffee.', vietnamese: 'Tôi thích trà hơn cà phê.', note: 'Prefer A to B'),
        GrammarExample(english: 'She prefers staying home to going out.', vietnamese: 'Cô ấy thích ở nhà hơn ra ngoài.', note: 'Prefer V-ing to V-ing'),
        GrammarExample(english: 'I prefer to walk rather than take the bus.', vietnamese: 'Tôi thích đi bộ hơn là đi xe buýt.', note: 'Prefer to V rather than V'),
        GrammarExample(english: 'He prefers football to basketball.', vietnamese: 'Anh ấy thích bóng đá hơn bóng rổ.', note: 'So sánh 2 danh từ'),
      ],
      recognitionSigns: ['Có "prefer"', 'Có "to" hoặc "rather than"', 'Diễn tả sở thích'],
      commonMistakes: [
        '❌ prefer A than B → ✅ prefer A to B (dùng "to", không dùng "than")',
        '❌ prefer to read to watch → ✅ prefer reading to watching (V-ing to V-ing)',
        '❌ prefer stay to go → ✅ prefer staying to going',
        '❌ prefer to stay rather than to go → ✅ prefer to stay rather than go (sau rather than không có "to")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex42_1', type: ExerciseType.multipleChoice, question: 'I prefer tea _____ coffee.', options: ['to','than','from','with'], correctAnswer: 'to', explanation: 'Prefer A to B'),
        GrammarExerciseItem(id: 'ex42_2', type: ExerciseType.multipleChoice, question: 'She prefers _____ to going out.', options: ['stay','staying','to stay','stayed'], correctAnswer: 'staying', explanation: 'Prefer V-ing to V-ing'),
        GrammarExerciseItem(id: 'ex42_3', type: ExerciseType.multipleChoice, question: 'I prefer to walk _____ take the bus.', options: ['rather than','than','to','instead'], correctAnswer: 'rather than', explanation: 'Prefer to V rather than V'),
        GrammarExerciseItem(id: 'ex42_4', type: ExerciseType.multipleChoice, question: 'He prefers football _____ basketball.', options: ['to','than','from','over'], correctAnswer: 'to', explanation: 'Prefer A to B'),
        GrammarExerciseItem(id: 'ex42_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','prefer','tea','to','coffee'], correctAnswer: 'I prefer tea to coffee', explanation: 'Prefer A to B'),
        GrammarExerciseItem(id: 'ex42_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','prefers','reading','to','watching','TV'], correctAnswer: 'She prefers reading to watching TV', explanation: 'Prefer V-ing to V-ing'),
        GrammarExerciseItem(id: 'ex42_7', type: ExerciseType.fillInBlank, question: 'I prefer walking _____ (to/than) driving.', correctAnswer: 'to', explanation: 'Prefer V-ing to V-ing'),
      ],
      order: 42,
    );
  }

  static GrammarLesson _createLesson43_Refuse() {
    return const GrammarLesson(
      id: 'lesson_43',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Refuse',
      objective: 'Nắm vững cách sử dụng "refuse" để từ chối làm gì một cách lịch sự',
      theory: 'Refuse có nghĩa "từ chối", dùng để diễn tả việc không chấp nhận hoặc không đồng ý làm gì. Sau "refuse" luôn là "to + V" (động từ nguyên mẫu có "to"). Refuse mang tính trang trọng hơn "say no". Phủ định: refuse not to V (từ chối không làm gì = đồng ý làm).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Refuse + to V',
        '  Ví dụ: He refused to help me.',
        '  (Anh ấy từ chối giúp tôi)',
        '',
        '• Refuse + sb + sth',
        '  Ví dụ: They refused him entry.',
        '  (Họ từ chối cho anh ấy vào)',
      ],
      usages: [
        'Từ chối làm gì',
        'Không chấp nhận đề nghị',
        'Sau refuse là to + V',
        'Trang trọng hơn "say no"',
      ],
      examples: [
        GrammarExample(english: 'She refused to answer the question.', vietnamese: 'Cô ấy từ chối trả lời câu hỏi.', note: 'Refuse + to V'),
        GrammarExample(english: 'He refused to go with us.', vietnamese: 'Anh ấy từ chối đi cùng chúng tôi.', note: 'Từ chối đề nghị'),
        GrammarExample(english: 'They refused to accept the offer.', vietnamese: 'Họ từ chối chấp nhận lời đề nghị.', note: 'Refuse + to V'),
        GrammarExample(english: 'I refused to believe it.', vietnamese: 'Tôi từ chối tin điều đó.', note: 'Không chấp nhận'),
      ],
      recognitionSigns: ['Có "refuse"', 'Sau đó là to + V', 'Diễn tả từ chối'],
      commonMistakes: [
        '❌ refuse helping → ✅ refuse to help (dùng to V, không dùng V-ing)',
        '❌ refuse help → ✅ refuse to help (cần "to")',
        '❌ refuse that → ✅ refuse to do that',
        '❌ He refused go → ✅ He refused to go',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex43_1', type: ExerciseType.multipleChoice, question: 'He refused _____ help me.', options: ['to','for','at','helping'], correctAnswer: 'to', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_2', type: ExerciseType.multipleChoice, question: 'She refused _____ answer.', options: ['to','for','answering','answer'], correctAnswer: 'to', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_3', type: ExerciseType.multipleChoice, question: 'They refused _____ accept the offer.', options: ['to','for','accepting','accept'], correctAnswer: 'to', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_4', type: ExerciseType.multipleChoice, question: 'I refused _____ believe it.', options: ['to','for','believing','believe'], correctAnswer: 'to', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['He','refused','to','help','me'], correctAnswer: 'He refused to help me', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','refused','to','go','with','us'], correctAnswer: 'She refused to go with us', explanation: 'Refuse + to V'),
        GrammarExerciseItem(id: 'ex43_7', type: ExerciseType.fillInBlank, question: 'They refused _____ (accept) the offer.', correctAnswer: 'to accept', explanation: 'Refuse + to V'),
      ],
      order: 43,
    );
  }

  static GrammarLesson _createLesson44_Let() {
    return const GrammarLesson(
      id: 'lesson_44',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Let',
      objective: 'Nắm vững cách sử dụng "let" để cho phép ai đó làm gì',
      theory: 'Let có nghĩa "để cho", "cho phép", dùng để diễn tả việc cho phép ai đó làm gì. Cấu trúc: Let + tân ngữ + động từ nguyên mẫu (không "to"). Let là động từ đặc biệt, sau tân ngữ không có "to". Phủ định: Don\'t let + O + V (đừng để ai làm gì).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Let + O + V (nguyên mẫu không "to")',
        '  Ví dụ: Let me help you.',
        '  (Để tôi giúp bạn)',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Don\'t let + O + V',
        '  Ví dụ: Don\'t let him go.',
        '  (Đừng để anh ấy đi)',
      ],
      usages: [
        'Cho phép ai làm gì',
        'Đề nghị được làm gì',
        'Sau let + O là V nguyên mẫu (không "to")',
        'Phủ định: Don\'t let',
      ],
      examples: [
        GrammarExample(english: 'Let me go.', vietnamese: 'Để tôi đi.', note: 'Let + O + V'),
        GrammarExample(english: 'Let him try.', vietnamese: 'Để anh ấy thử.', note: 'Cho phép làm gì'),
        GrammarExample(english: 'Don\'t let them know.', vietnamese: 'Đừng để họ biết.', note: 'Phủ định'),
        GrammarExample(english: 'Let me see that book.', vietnamese: 'Để tôi xem cuốn sách đó.', note: 'Đề nghị'),
      ],
      recognitionSigns: ['Có "let"', 'Sau đó là O + V', 'Cho phép làm gì'],
      commonMistakes: [
        '❌ let me to go → ✅ let me go (không có "to")',
        '❌ let me going → ✅ let me go (V nguyên mẫu)',
        '❌ let to him go → ✅ let him go',
        '❌ not let him go → ✅ don\'t let him go (dùng don\'t)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex44_1', type: ExerciseType.multipleChoice, question: 'Let me _____ you.', options: ['help','to help','helping','helps'], correctAnswer: 'help', explanation: 'Let + O + V'),
        GrammarExerciseItem(id: 'ex44_2', type: ExerciseType.multipleChoice, question: 'Let him _____.', options: ['go','to go','going','goes'], correctAnswer: 'go', explanation: 'Let + O + V'),
        GrammarExerciseItem(id: 'ex44_3', type: ExerciseType.multipleChoice, question: 'Don\'t let them _____.', options: ['know','to know','knowing','knows'], correctAnswer: 'know', explanation: 'Don\'t let + O + V'),
        GrammarExerciseItem(id: 'ex44_4', type: ExerciseType.multipleChoice, question: 'Let me _____ that book.', options: ['see','to see','seeing','sees'], correctAnswer: 'see', explanation: 'Let + O + V'),
        GrammarExerciseItem(id: 'ex44_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Let','me','help','you'], correctAnswer: 'Let me help you', explanation: 'Let + O + V'),
        GrammarExerciseItem(id: 'ex44_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Don\'t','let','him','go'], correctAnswer: 'Don\'t let him go', explanation: 'Don\'t let + O + V'),
        GrammarExerciseItem(id: 'ex44_7', type: ExerciseType.fillInBlank, question: 'Let me _____ (try).', correctAnswer: 'try', explanation: 'Let + O + V'),
      ],
      order: 44,
    );
  }

  static GrammarLesson _createLesson45_Lets() {
    return const GrammarLesson(
      id: 'lesson_45',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Let\'s',
      objective: 'Nắm vững cách sử dụng "let\'s" để rủ rê, đề nghị cùng làm gì',
      theory: 'Let\'s (viết tắt của Let us) có nghĩa "chúng ta hãy", dùng để rủ rê, đề nghị cùng nhau làm gì. Sau "let\'s" là động từ nguyên mẫu (không "to"). Câu hỏi đuôi của Let\'s là "shall we?". Phủ định: Let\'s not + V (đừng làm gì).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Let\'s + V (nguyên mẫu không "to")',
        '  Ví dụ: Let\'s go!',
        '  (Chúng ta đi thôi!)',
        '',
        '📌 CÂU HỎI ĐUÔI:',
        '• Let\'s + V, shall we?',
        '  Ví dụ: Let\'s go, shall we?',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Let\'s not + V',
        '  Ví dụ: Let\'s not waste time.',
      ],
      usages: [
        'Rủ rê cùng làm gì',
        'Đề nghị cùng nhau',
        'Sau let\'s là V nguyên mẫu (không "to")',
        'Câu hỏi đuôi: shall we?',
      ],
      examples: [
        GrammarExample(english: 'Let\'s go home.', vietnamese: 'Chúng ta về nhà đi.', note: 'Let\'s + V'),
        GrammarExample(english: 'Let\'s have lunch together.', vietnamese: 'Chúng ta ăn trưa cùng nhau đi.', note: 'Rủ rê'),
        GrammarExample(english: 'Let\'s not waste time.', vietnamese: 'Đừng lãng phí thời gian.', note: 'Phủ định'),
        GrammarExample(english: 'Let\'s go, shall we?', vietnamese: 'Chúng ta đi thôi, nhé?', note: 'Câu hỏi đuôi'),
      ],
      recognitionSigns: ['Có "let\'s"', 'Sau đó là V nguyên mẫu', 'Rủ rê cùng làm'],
      commonMistakes: [
        '❌ let\'s to go → ✅ let\'s go (không có "to")',
        '❌ let\'s going → ✅ let\'s go (V nguyên mẫu)',
        '❌ let\'s go, aren\'t we? → ✅ let\'s go, shall we? (câu hỏi đuôi)',
        '❌ don\'t let\'s go → ✅ let\'s not go (phủ định)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex45_1', type: ExerciseType.multipleChoice, question: 'Let\'s _____ home.', options: ['go','to go','going','goes'], correctAnswer: 'go', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex45_2', type: ExerciseType.multipleChoice, question: 'Let\'s _____ a break.', options: ['take','to take','taking','takes'], correctAnswer: 'take', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex45_3', type: ExerciseType.multipleChoice, question: 'Let\'s not _____ time.', options: ['waste','to waste','wasting','wastes'], correctAnswer: 'waste', explanation: 'Let\'s not + V'),
        GrammarExerciseItem(id: 'ex45_4', type: ExerciseType.multipleChoice, question: 'Let\'s go, _____ we?', options: ['shall','will','do','don\'t'], correctAnswer: 'shall', explanation: 'Câu hỏi đuôi: shall we'),
        GrammarExerciseItem(id: 'ex45_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Let\'s','go','home'], correctAnswer: 'Let\'s go home', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex45_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Let\'s','have','lunch','together'], correctAnswer: 'Let\'s have lunch together', explanation: 'Let\'s + V'),
        GrammarExerciseItem(id: 'ex45_7', type: ExerciseType.fillInBlank, question: 'Let\'s _____ (study) together.', correctAnswer: 'study', explanation: 'Let\'s + V'),
      ],
      order: 45,
    );
  }

  static GrammarLesson _createLesson46_Difficult() {
    return const GrammarLesson(
      id: 'lesson_46',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Difficult',
      objective: 'Nắm vững cách sử dụng "difficult" để diễn tả độ khó của việc gì đó',
      theory: 'Difficult có nghĩa "khó", dùng để diễn tả độ khó của một việc. Có 2 cấu trúc: "It is difficult to V" (khó để làm gì - chung chung) và "It is difficult for sb to V" (khó cho ai để làm gì - cụ thể). Có thể thay "difficult" bằng "hard", "easy", "impossible", v.v.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• It is difficult + to V',
        '  Ví dụ: It is difficult to learn English.',
        '  (Học tiếng Anh khó)',
        '',
        '• It is difficult + for sb + to V',
        '  Ví dụ: It is difficult for me to understand.',
        '  (Khó cho tôi để hiểu)',
        '',
        '📌 TƯƠNG TỰ:',
        '• It is easy/hard/impossible to V',
      ],
      usages: [
        'Diễn tả độ khó của việc gì',
        'It is difficult to V: chung chung',
        'It is difficult for sb to V: cụ thể cho ai',
        'Có thể thay bằng easy, hard, impossible',
      ],
      examples: [
        GrammarExample(english: 'It is difficult to learn English.', vietnamese: 'Học tiếng Anh khó.', note: 'Difficult + to V'),
        GrammarExample(english: 'It is difficult for me to understand.', vietnamese: 'Khó cho tôi để hiểu.', note: 'Difficult + for sb + to V'),
        GrammarExample(english: 'It is easy to make mistakes.', vietnamese: 'Dễ mắc lỗi.', note: 'Easy + to V'),
        GrammarExample(english: 'It is impossible for him to finish on time.', vietnamese: 'Không thể nào anh ấy hoàn thành đúng giờ.', note: 'Impossible + for sb + to V'),
      ],
      recognitionSigns: ['Có "difficult/easy/hard/impossible"', 'Có "It is...to V"', 'Diễn tả độ khó'],
      commonMistakes: [
        '❌ difficult learning → ✅ difficult to learn (dùng to V)',
        '❌ It is difficult learn → ✅ It is difficult to learn (cần "to")',
        '❌ It is difficult to me → ✅ It is difficult for me (dùng "for")',
        '❌ Difficult to learn English → ✅ It is difficult to learn English (cần "It is")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex46_1', type: ExerciseType.multipleChoice, question: 'It is difficult _____ learn English.', options: ['to','for','at','learning'], correctAnswer: 'to', explanation: 'Difficult + to V'),
        GrammarExerciseItem(id: 'ex46_2', type: ExerciseType.multipleChoice, question: 'It is difficult _____ me to understand.', options: ['for','to','at','of'], correctAnswer: 'for', explanation: 'Difficult + for sb'),
        GrammarExerciseItem(id: 'ex46_3', type: ExerciseType.multipleChoice, question: 'It is easy _____ make mistakes.', options: ['to','for','at','making'], correctAnswer: 'to', explanation: 'Easy + to V'),
        GrammarExerciseItem(id: 'ex46_4', type: ExerciseType.multipleChoice, question: 'It is impossible _____ him to finish.', options: ['for','to','at','of'], correctAnswer: 'for', explanation: 'Impossible + for sb'),
        GrammarExerciseItem(id: 'ex46_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','is','difficult','to','learn','English'], correctAnswer: 'It is difficult to learn English', explanation: 'Difficult + to V'),
        GrammarExerciseItem(id: 'ex46_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','is','easy','for','me','to','understand'], correctAnswer: 'It is easy for me to understand', explanation: 'Easy + for sb + to V'),
        GrammarExerciseItem(id: 'ex46_7', type: ExerciseType.fillInBlank, question: 'It is difficult _____ (understand) this lesson.', correctAnswer: 'to understand', explanation: 'Difficult + to V'),
      ],
      order: 46,
    );
  }

  static GrammarLesson _createLesson47_Promise() {
    return const GrammarLesson(
      id: 'lesson_47',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Promise',
      objective: 'Nắm vững cách sử dụng "promise" để hứa hẹn làm gì',
      theory: 'Promise có nghĩa "hứa", "cam kết", dùng để diễn tả lời hứa hẹn sẽ làm gì. Sau "promise" là "to + V" (động từ nguyên mẫu có "to"). Có thể dùng "promise + sb + to V" (hứa với ai làm gì) hoặc "promise + that + S + V" (hứa rằng). Danh từ "promise" nghĩa là "lời hứa".',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Promise + to V',
        '  Ví dụ: I promise to help you.',
        '  (Tôi hứa sẽ giúp bạn)',
        '',
        '• Promise + sb + to V',
        '  Ví dụ: She promised me to come.',
        '  (Cô ấy hứa với tôi sẽ đến)',
        '',
        '• Promise + (that) + S + V',
        '  Ví dụ: I promise that I will help you.',
      ],
      usages: [
        'Hứa hẹn làm gì',
        'Cam kết với ai',
        'Sau promise là to + V',
        'Có thể dùng promise + that + S + V',
      ],
      examples: [
        GrammarExample(english: 'She promised to come.', vietnamese: 'Cô ấy hứa sẽ đến.', note: 'Promise + to V'),
        GrammarExample(english: 'I promise to study harder.', vietnamese: 'Tôi hứa sẽ học chăm hơn.', note: 'Lời hứa'),
        GrammarExample(english: 'He promised me to help.', vietnamese: 'Anh ấy hứa với tôi sẽ giúp.', note: 'Promise + sb + to V'),
        GrammarExample(english: 'I promise that I will be on time.', vietnamese: 'Tôi hứa rằng tôi sẽ đúng giờ.', note: 'Promise + that'),
      ],
      recognitionSigns: ['Có "promise"', 'Sau đó là to + V hoặc that', 'Diễn tả lời hứa'],
      commonMistakes: [
        '❌ promise coming → ✅ promise to come (dùng to V)',
        '❌ promise help → ✅ promise to help (cần "to")',
        '❌ promise that come → ✅ promise to come / promise that I will come',
        '❌ I promise you to help → ✅ I promise to help you (vị trí tân ngữ)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex47_1', type: ExerciseType.multipleChoice, question: 'I promise _____ help you.', options: ['to','for','helping','help'], correctAnswer: 'to', explanation: 'Promise + to V'),
        GrammarExerciseItem(id: 'ex47_2', type: ExerciseType.multipleChoice, question: 'She promised _____ come.', options: ['to','for','coming','come'], correctAnswer: 'to', explanation: 'Promise + to V'),
        GrammarExerciseItem(id: 'ex47_3', type: ExerciseType.multipleChoice, question: 'He promised me _____ help.', options: ['to','for','helping','help'], correctAnswer: 'to', explanation: 'Promise + sb + to V'),
        GrammarExerciseItem(id: 'ex47_4', type: ExerciseType.multipleChoice, question: 'I promise _____ I will be on time.', options: ['that','to','for','if'], correctAnswer: 'that', explanation: 'Promise + that'),
        GrammarExerciseItem(id: 'ex47_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','promise','to','help','you'], correctAnswer: 'I promise to help you', explanation: 'Promise + to V'),
        GrammarExerciseItem(id: 'ex47_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','promised','to','study','harder'], correctAnswer: 'She promised to study harder', explanation: 'Promise + to V'),
        GrammarExerciseItem(id: 'ex47_7', type: ExerciseType.fillInBlank, question: 'He promised _____ (be) on time.', correctAnswer: 'to be', explanation: 'Promise + to V'),
      ],
      order: 47,
    );
  }
  // ==================== CATEGORY 5: NHÓM 3 & 4 (17 bài cuối) ====================
  
  static GrammarLesson _createLesson48_Avoid() {
    return const GrammarLesson(
      id: 'lesson_48',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Avoid',
      objective: 'Nắm vững cách sử dụng "avoid" để tránh làm gì hoặc tránh điều gì',
      theory: 'Avoid có nghĩa "tránh", "né tránh", dùng để diễn tả việc cố gắng không làm gì hoặc không gặp phải điều gì. Sau "avoid" luôn là V-ing (động từ thêm -ing), không bao giờ dùng "to V". Avoid thường dùng để khuyên ai đó không nên làm gì vì có hại hoặc nguy hiểm.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Avoid + V-ing',
        '  Ví dụ: Avoid smoking.',
        '  (Tránh hút thuốc)',
        '',
        '• Avoid + N',
        '  Ví dụ: Avoid junk food.',
        '  (Tránh đồ ăn vặt)',
      ],
      usages: [
        'Tránh làm gì',
        'Né tránh điều gì có hại',
        'Sau avoid là V-ing, không dùng to V',
        'Có thể dùng avoid + danh từ',
      ],
      examples: [
        GrammarExample(english: 'Avoid smoking.', vietnamese: 'Tránh hút thuốc.', note: 'Avoid + V-ing'),
        GrammarExample(english: 'You should avoid eating junk food.', vietnamese: 'Bạn nên tránh ăn đồ ăn vặt.', note: 'Khuyên tránh'),
        GrammarExample(english: 'Avoid making the same mistake.', vietnamese: 'Tránh mắc lỗi tương tự.', note: 'Avoid + V-ing'),
        GrammarExample(english: 'I try to avoid him.', vietnamese: 'Tôi cố tránh anh ấy.', note: 'Avoid + N'),
      ],
      recognitionSigns: ['Có "avoid"', 'Sau đó là V-ing', 'Diễn tả tránh làm gì'],
      commonMistakes: [
        '❌ avoid to smoke → ✅ avoid smoking (dùng V-ing, không dùng to V)',
        '❌ avoid smoke → ✅ avoid smoking (cần thêm -ing)',
        '❌ avoid to eat → ✅ avoid eating',
        '❌ I avoid go there → ✅ I avoid going there',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex48_1', type: ExerciseType.multipleChoice, question: 'Avoid _____ junk food.', options: ['eat','eating','to eat','ate'], correctAnswer: 'eating', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_2', type: ExerciseType.multipleChoice, question: 'You should avoid _____.', options: ['smoke','smoking','to smoke','smoked'], correctAnswer: 'smoking', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_3', type: ExerciseType.multipleChoice, question: 'Avoid _____ the same mistake.', options: ['make','making','to make','made'], correctAnswer: 'making', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_4', type: ExerciseType.multipleChoice, question: 'I try to avoid _____ late.', options: ['be','being','to be','am'], correctAnswer: 'being', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Avoid','smoking'], correctAnswer: 'Avoid smoking', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','should','avoid','eating','junk','food'], correctAnswer: 'You should avoid eating junk food', explanation: 'Avoid + V-ing'),
        GrammarExerciseItem(id: 'ex48_7', type: ExerciseType.fillInBlank, question: 'Avoid _____ (drink) too much coffee.', correctAnswer: 'drinking', explanation: 'Avoid + V-ing'),
      ],
      order: 48,
    );
  }

  static GrammarLesson _createLesson49_Advise() {
    return const GrammarLesson(
      id: 'lesson_49',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Advise',
      objective: 'Nắm vững cách sử dụng "advise" để khuyên ai làm gì một cách trang trọng',
      theory: 'Advise có nghĩa "khuyên", "khuyên nhủ", dùng để đưa ra lời khuyên cho ai đó làm gì. Cấu trúc: Advise + sb + to V (khuyên ai làm gì). Advise trang trọng hơn "tell" hay "say". Có thể dùng "advise + V-ing" (khuyên làm gì - chung chung) hoặc "advise + that + S + should V".',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Advise + sb + to V',
        '  Ví dụ: I advise you to study harder.',
        '  (Tôi khuyên bạn học chăm hơn)',
        '',
        '• Advise + V-ing (chung chung)',
        '  Ví dụ: I advise taking a rest.',
        '  (Tôi khuyên nên nghỉ ngơi)',
        '',
        '• Advise + that + S + (should) + V',
        '  Ví dụ: I advise that you (should) see a doctor.',
      ],
      usages: [
        'Khuyên ai làm gì',
        'Đưa ra lời khuyên',
        'Advise + sb + to V: khuyên ai cụ thể',
        'Trang trọng hơn "tell"',
      ],
      examples: [
        GrammarExample(english: 'I advise you to study harder.', vietnamese: 'Tôi khuyên bạn học chăm hơn.', note: 'Advise + sb + to V'),
        GrammarExample(english: 'The doctor advised me to rest.', vietnamese: 'Bác sĩ khuyên tôi nghỉ ngơi.', note: 'Lời khuyên từ bác sĩ'),
        GrammarExample(english: 'I advise taking a break.', vietnamese: 'Tôi khuyên nên nghỉ giải lao.', note: 'Advise + V-ing'),
        GrammarExample(english: 'He advised that I should see a doctor.', vietnamese: 'Anh ấy khuyên tôi nên đi khám bác sĩ.', note: 'Advise + that'),
      ],
      recognitionSigns: ['Có "advise"', 'Sau đó là sb + to V', 'Đưa ra lời khuyên'],
      commonMistakes: [
        '❌ advise you studying → ✅ advise you to study (dùng to V)',
        '❌ advise to study → ✅ advise you to study (cần tân ngữ)',
        '❌ I advise you study → ✅ I advise you to study (cần "to")',
        '❌ advise that you go → ✅ advise that you should go / advise you to go',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex49_1', type: ExerciseType.multipleChoice, question: 'I advise you _____ study harder.', options: ['to','for','studying','study'], correctAnswer: 'to', explanation: 'Advise + sb + to V'),
        GrammarExerciseItem(id: 'ex49_2', type: ExerciseType.multipleChoice, question: 'The doctor advised me _____ rest.', options: ['to','for','resting','rest'], correctAnswer: 'to', explanation: 'Advise + sb + to V'),
        GrammarExerciseItem(id: 'ex49_3', type: ExerciseType.multipleChoice, question: 'I advise _____ a break.', options: ['take','taking','to take','took'], correctAnswer: 'taking', explanation: 'Advise + V-ing'),
        GrammarExerciseItem(id: 'ex49_4', type: ExerciseType.multipleChoice, question: 'He advised that I _____ see a doctor.', options: ['should','to','must','can'], correctAnswer: 'should', explanation: 'Advise + that + should'),
        GrammarExerciseItem(id: 'ex49_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','advise','you','to','study','harder'], correctAnswer: 'I advise you to study harder', explanation: 'Advise + sb + to V'),
        GrammarExerciseItem(id: 'ex49_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','doctor','advised','me','to','rest'], correctAnswer: 'The doctor advised me to rest', explanation: 'Advise + sb + to V'),
        GrammarExerciseItem(id: 'ex49_7', type: ExerciseType.fillInBlank, question: 'I advise you _____ (see) a doctor.', correctAnswer: 'to see', explanation: 'Advise + sb + to V'),
      ],
      order: 49,
    );
  }

  static GrammarLesson _createLesson50_After() {
    return const GrammarLesson(
      id: 'lesson_50',
      categoryId: 'cat_5',
      title: 'Cấu Trúc After',
      objective: 'Nắm vững cách sử dụng "after" để diễn tả thời gian sau khi làm gì',
      theory: 'After có nghĩa "sau khi", dùng để chỉ thời gian một việc xảy ra sau một việc khác. Có 2 cấu trúc: "After + V-ing" (khi 2 hành động cùng chủ ngữ) và "After + S + V" (khi có chủ ngữ rõ ràng). After là giới từ hoặc liên từ chỉ thời gian.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• After + V-ing (cùng chủ ngữ)',
        '  Ví dụ: After eating, I sleep.',
        '  (Sau khi ăn, tôi ngủ)',
        '',
        '• After + S + V (có chủ ngữ)',
        '  Ví dụ: After I eat, I sleep.',
        '  (Sau khi tôi ăn, tôi ngủ)',
        '',
        '📌 TƯƠNG TỰ:',
        '• Before + V-ing / Before + S + V (trước khi)',
      ],
      usages: [
        'Chỉ thời gian sau khi',
        'After + V-ing: cùng chủ ngữ',
        'After + S + V: có chủ ngữ rõ ràng',
        'Diễn tả trình tự hành động',
      ],
      examples: [
        GrammarExample(english: 'After eating, I sleep.', vietnamese: 'Sau khi ăn, tôi ngủ.', note: 'After + V-ing'),
        GrammarExample(english: 'After I finished my homework, I watched TV.', vietnamese: 'Sau khi làm xong bài tập, tôi xem TV.', note: 'After + S + V'),
        GrammarExample(english: 'After studying, she went to bed.', vietnamese: 'Sau khi học, cô ấy đi ngủ.', note: 'Trình tự hành động'),
        GrammarExample(english: 'I will call you after the meeting.', vietnamese: 'Tôi sẽ gọi bạn sau cuộc họp.', note: 'After + N'),
      ],
      recognitionSigns: ['Có "after"', 'Chỉ thời gian sau', 'Diễn tả trình tự'],
      commonMistakes: [
        '❌ after eat → ✅ after eating (cần V-ing)',
        '❌ after to eat → ✅ after eating (không dùng to V)',
        '❌ After I eating → ✅ After I eat / After eating (không dùng cả 2)',
        '❌ after finish → ✅ after finishing',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex50_1', type: ExerciseType.multipleChoice, question: 'After _____, I sleep.', options: ['eat','eating','to eat','ate'], correctAnswer: 'eating', explanation: 'After + V-ing'),
        GrammarExerciseItem(id: 'ex50_2', type: ExerciseType.multipleChoice, question: 'After I _____ my homework, I watched TV.', options: ['finish','finished','finishing','to finish'], correctAnswer: 'finished', explanation: 'After + S + V'),
        GrammarExerciseItem(id: 'ex50_3', type: ExerciseType.multipleChoice, question: 'After _____, she went to bed.', options: ['study','studying','to study','studied'], correctAnswer: 'studying', explanation: 'After + V-ing'),
        GrammarExerciseItem(id: 'ex50_4', type: ExerciseType.multipleChoice, question: 'I will call you after _____ meeting.', options: ['the','a','an','this'], correctAnswer: 'the', explanation: 'After + N'),
        GrammarExerciseItem(id: 'ex50_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['After','eating','I','sleep'], correctAnswer: 'After eating I sleep', explanation: 'After + V-ing'),
        GrammarExerciseItem(id: 'ex50_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['After','I','finished','I','watched','TV'], correctAnswer: 'After I finished I watched TV', explanation: 'After + S + V'),
        GrammarExerciseItem(id: 'ex50_7', type: ExerciseType.fillInBlank, question: 'After _____ (finish) work, I go home.', correctAnswer: 'finishing', explanation: 'After + V-ing'),
      ],
      order: 50,
    );
  }

  static GrammarLesson _createLesson51_Asked() {
    return const GrammarLesson(
      id: 'lesson_51',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Ask',
      objective: 'Nắm vững cách sử dụng "ask" để yêu cầu, đề nghị ai làm gì',
      theory: 'Ask có nghĩa "yêu cầu", "đề nghị", "nhờ", dùng để nhờ vả hoặc yêu cầu ai đó làm gì. Cấu trúc: Ask + sb + to V (yêu cầu ai làm gì). Khác với "ask for" (xin, yêu cầu cái gì). Ask nhẹ nhàng hơn "order" (ra lệnh) và "demand" (đòi hỏi).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Ask + sb + to V',
        '  Ví dụ: I asked him to help me.',
        '  (Tôi nhờ anh ấy giúp tôi)',
        '',
        '• Ask + sb + for + sth',
        '  Ví dụ: I asked him for help.',
        '  (Tôi xin anh ấy giúp đỡ)',
        '',
        '• Ask + sb + question',
        '  Ví dụ: I asked him a question.',
      ],
      usages: [
        'Yêu cầu ai làm gì',
        'Nhờ vả ai',
        'Ask + sb + to V: yêu cầu làm gì',
        'Ask + for: xin cái gì',
      ],
      examples: [
        GrammarExample(english: 'I asked him to help me.', vietnamese: 'Tôi nhờ anh ấy giúp tôi.', note: 'Ask + sb + to V'),
        GrammarExample(english: 'She asked me to wait.', vietnamese: 'Cô ấy yêu cầu tôi đợi.', note: 'Yêu cầu làm gì'),
        GrammarExample(english: 'I asked him for help.', vietnamese: 'Tôi xin anh ấy giúp đỡ.', note: 'Ask + for'),
        GrammarExample(english: 'He asked me a question.', vietnamese: 'Anh ấy hỏi tôi một câu hỏi.', note: 'Ask + question'),
      ],
      recognitionSigns: ['Có "ask"', 'Sau đó là sb + to V hoặc for', 'Yêu cầu, nhờ vả'],
      commonMistakes: [
        '❌ ask him helping → ✅ ask him to help (dùng to V)',
        '❌ ask to help → ✅ ask him to help (cần tân ngữ)',
        '❌ I asked him help → ✅ I asked him to help (cần "to")',
        '❌ ask for to help → ✅ ask for help / ask sb to help',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex51_1', type: ExerciseType.multipleChoice, question: 'I asked him _____ help me.', options: ['to','for','helping','help'], correctAnswer: 'to', explanation: 'Ask + sb + to V'),
        GrammarExerciseItem(id: 'ex51_2', type: ExerciseType.multipleChoice, question: 'She asked me _____ wait.', options: ['to','for','waiting','wait'], correctAnswer: 'to', explanation: 'Ask + sb + to V'),
        GrammarExerciseItem(id: 'ex51_3', type: ExerciseType.multipleChoice, question: 'I asked him _____ help.', options: ['for','to','at','with'], correctAnswer: 'for', explanation: 'Ask + for + sth'),
        GrammarExerciseItem(id: 'ex51_4', type: ExerciseType.multipleChoice, question: 'He asked me _____ question.', options: ['a','the','to','for'], correctAnswer: 'a', explanation: 'Ask + question'),
        GrammarExerciseItem(id: 'ex51_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','asked','him','to','help','me'], correctAnswer: 'I asked him to help me', explanation: 'Ask + sb + to V'),
        GrammarExerciseItem(id: 'ex51_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','asked','me','to','wait'], correctAnswer: 'She asked me to wait', explanation: 'Ask + sb + to V'),
        GrammarExerciseItem(id: 'ex51_7', type: ExerciseType.fillInBlank, question: 'I asked her _____ (come) with me.', correctAnswer: 'to come', explanation: 'Ask + sb + to V'),
      ],
      order: 51,
    );
  }

  static GrammarLesson _createLesson52_Enjoy() {
    return const GrammarLesson(
      id: 'lesson_52',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Enjoy',
      objective: 'Nắm vững cách sử dụng "enjoy" để diễn tả thích thú, tận hưởng việc làm gì',
      theory: 'Enjoy có nghĩa "thích", "tận hưởng", dùng để diễn tả sự thích thú khi làm gì. Sau "enjoy" luôn là V-ing (động từ thêm -ing), không bao giờ dùng "to V". Enjoy mang ý nghĩa tích cực, thể hiện sự vui vẻ, hài lòng khi làm việc gì đó.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Enjoy + V-ing',
        '  Ví dụ: I enjoy reading books.',
        '  (Tôi thích đọc sách)',
        '',
        '• Enjoy + N',
        '  Ví dụ: I enjoy music.',
        '  (Tôi thích âm nhạc)',
        '',
        '📌 CỤM TỪ:',
        '• Enjoy yourself: vui vẻ, tận hưởng',
      ],
      usages: [
        'Thích làm gì',
        'Tận hưởng việc gì',
        'Sau enjoy là V-ing, không dùng to V',
        'Diễn tả sự thích thú tích cực',
      ],
      examples: [
        GrammarExample(english: 'I enjoy reading books.', vietnamese: 'Tôi thích đọc sách.', note: 'Enjoy + V-ing'),
        GrammarExample(english: 'She enjoys swimming.', vietnamese: 'Cô ấy thích bơi.', note: 'Thích làm gì'),
        GrammarExample(english: 'We enjoyed the party.', vietnamese: 'Chúng tôi thích bữa tiệc.', note: 'Enjoy + N'),
        GrammarExample(english: 'Enjoy yourself!', vietnamese: 'Hãy vui vẻ nhé!', note: 'Enjoy yourself'),
      ],
      recognitionSigns: ['Có "enjoy"', 'Sau đó là V-ing hoặc N', 'Diễn tả sự thích thú'],
      commonMistakes: [
        '❌ enjoy to read → ✅ enjoy reading (dùng V-ing, không dùng to V)',
        '❌ enjoy read → ✅ enjoy reading (cần thêm -ing)',
        '❌ enjoy to swim → ✅ enjoy swimming',
        '❌ I enjoy go → ✅ I enjoy going',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex52_1', type: ExerciseType.multipleChoice, question: 'I enjoy _____ books.', options: ['read','reading','to read','reads'], correctAnswer: 'reading', explanation: 'Enjoy + V-ing'),
        GrammarExerciseItem(id: 'ex52_2', type: ExerciseType.multipleChoice, question: 'She enjoys _____.', options: ['swim','swimming','to swim','swims'], correctAnswer: 'swimming', explanation: 'Enjoy + V-ing'),
        GrammarExerciseItem(id: 'ex52_3', type: ExerciseType.multipleChoice, question: 'We enjoyed _____ party.', options: ['the','a','an','this'], correctAnswer: 'the', explanation: 'Enjoy + N'),
        GrammarExerciseItem(id: 'ex52_4', type: ExerciseType.multipleChoice, question: 'I enjoy _____ to music.', options: ['listen','listening','to listen','listens'], correctAnswer: 'listening', explanation: 'Enjoy + V-ing'),
        GrammarExerciseItem(id: 'ex52_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','enjoy','reading','books'], correctAnswer: 'I enjoy reading books', explanation: 'Enjoy + V-ing'),
        GrammarExerciseItem(id: 'ex52_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','enjoys','swimming'], correctAnswer: 'She enjoys swimming', explanation: 'Enjoy + V-ing'),
        GrammarExerciseItem(id: 'ex52_7', type: ExerciseType.fillInBlank, question: 'I enjoy _____ (play) football.', correctAnswer: 'playing', explanation: 'Enjoy + V-ing'),
      ],
      order: 52,
    );
  }

  static GrammarLesson _createLesson53_Must() {
    return const GrammarLesson(
      id: 'lesson_53',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Must',
      objective: 'Nắm vững cách sử dụng "must" để diễn tả sự bắt buộc, nghĩa vụ',
      theory: 'Must là động từ khuyết thiếu (modal verb) có nghĩa "phải", dùng để diễn tả sự bắt buộc, nghĩa vụ phải làm gì. Sau "must" là động từ nguyên mẫu (không "to"). Phủ định: must not / mustn\'t (không được phép). Must còn dùng để suy đoán chắc chắn (must be).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Must + V (nguyên mẫu không "to")',
        '  Ví dụ: You must study.',
        '  (Bạn phải học)',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Must not / Mustn\'t + V',
        '  Ví dụ: You mustn\'t smoke here.',
        '  (Bạn không được hút thuốc ở đây)',
        '',
        '📌 SUY ĐOÁN:',
        '• Must + be: chắc chắn là',
        '  Ví dụ: He must be tired.',
      ],
      usages: [
        'Diễn tả bắt buộc phải làm',
        'Nghĩa vụ, quy định',
        'Sau must là V nguyên mẫu (không "to")',
        'Must not: cấm, không được phép',
      ],
      examples: [
        GrammarExample(english: 'You must study hard.', vietnamese: 'Bạn phải học chăm chỉ.', note: 'Must + V'),
        GrammarExample(english: 'You mustn\'t smoke here.', vietnamese: 'Bạn không được hút thuốc ở đây.', note: 'Cấm đoán'),
        GrammarExample(english: 'He must be tired.', vietnamese: 'Chắc chắn anh ấy mệt.', note: 'Suy đoán'),
        GrammarExample(english: 'We must finish this today.', vietnamese: 'Chúng ta phải hoàn thành việc này hôm nay.', note: 'Bắt buộc'),
      ],
      recognitionSigns: ['Có "must"', 'Sau đó là V nguyên mẫu', 'Diễn tả bắt buộc'],
      commonMistakes: [
        '❌ must to study → ✅ must study (không có "to")',
        '❌ must studying → ✅ must study (V nguyên mẫu)',
        '❌ don\'t must → ✅ must not / mustn\'t (phủ định)',
        '❌ You must to go → ✅ You must go',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex53_1', type: ExerciseType.multipleChoice, question: 'You must _____ hard.', options: ['study','to study','studying','studied'], correctAnswer: 'study', explanation: 'Must + V'),
        GrammarExerciseItem(id: 'ex53_2', type: ExerciseType.multipleChoice, question: 'You _____ smoke here.', options: ['mustn\'t','don\'t must','must not to','not must'], correctAnswer: 'mustn\'t', explanation: 'Must not = mustn\'t'),
        GrammarExerciseItem(id: 'ex53_3', type: ExerciseType.multipleChoice, question: 'He must _____ tired.', options: ['be','is','being','to be'], correctAnswer: 'be', explanation: 'Must + be'),
        GrammarExerciseItem(id: 'ex53_4', type: ExerciseType.multipleChoice, question: 'We must _____ this today.', options: ['finish','to finish','finishing','finished'], correctAnswer: 'finish', explanation: 'Must + V'),
        GrammarExerciseItem(id: 'ex53_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','must','study','hard'], correctAnswer: 'You must study hard', explanation: 'Must + V'),
        GrammarExerciseItem(id: 'ex53_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','mustn\'t','smoke','here'], correctAnswer: 'You mustn\'t smoke here', explanation: 'Mustn\'t + V'),
        GrammarExerciseItem(id: 'ex53_7', type: ExerciseType.fillInBlank, question: 'You must _____ (be) careful.', correctAnswer: 'be', explanation: 'Must + V'),
      ],
      order: 53,
    );
  }

  static GrammarLesson _createLesson54_AsMuchAs() {
    return const GrammarLesson(
      id: 'lesson_54',
      categoryId: 'cat_5',
      title: 'Cấu Trúc As Much As / As Many As',
      objective: 'Nắm vững cách sử dụng "as much as" và "as many as" để so sánh số lượng bằng nhau',
      theory: 'As much as / As many as dùng để so sánh số lượng bằng nhau. "As much as" dùng với danh từ không đếm được (money, water, time...), "as many as" dùng với danh từ đếm được (books, people...). Cấu trúc tương tự "as...as" trong so sánh bằng.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• As much + N (không đếm được) + as',
        '  Ví dụ: I have as much money as you.',
        '  (Tôi có nhiều tiền như bạn)',
        '',
        '• As many + N (đếm được) + as',
        '  Ví dụ: I have as many books as you.',
        '  (Tôi có nhiều sách như bạn)',
      ],
      usages: [
        'So sánh số lượng bằng nhau',
        'As much as: danh từ không đếm được',
        'As many as: danh từ đếm được',
        'Tương tự as...as trong so sánh',
      ],
      examples: [
        GrammarExample(english: 'I have as much money as you.', vietnamese: 'Tôi có nhiều tiền như bạn.', note: 'As much as + N không đếm được'),
        GrammarExample(english: 'She has as many friends as I do.', vietnamese: 'Cô ấy có nhiều bạn như tôi.', note: 'As many as + N đếm được'),
        GrammarExample(english: 'I drink as much water as possible.', vietnamese: 'Tôi uống nhiều nước nhất có thể.', note: 'As much as possible'),
        GrammarExample(english: 'He has as many books as she does.', vietnamese: 'Anh ấy có nhiều sách như cô ấy.', note: 'So sánh số lượng'),
      ],
      recognitionSigns: ['Có "as much as" hoặc "as many as"', 'So sánh số lượng', 'Bằng nhau'],
      commonMistakes: [
        '❌ as much than → ✅ as much as (dùng "as", không dùng "than")',
        '❌ as much books → ✅ as many books (books đếm được)',
        '❌ as many money → ✅ as much money (money không đếm được)',
        '❌ I have as much as money you → ✅ I have as much money as you',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex54_1', type: ExerciseType.multipleChoice, question: 'I have as much money _____ you.', options: ['as','than','from','like'], correctAnswer: 'as', explanation: 'As much...as'),
        GrammarExerciseItem(id: 'ex54_2', type: ExerciseType.multipleChoice, question: 'She has as _____ friends as I do.', options: ['many','much','more','most'], correctAnswer: 'many', explanation: 'Friends đếm được'),
        GrammarExerciseItem(id: 'ex54_3', type: ExerciseType.multipleChoice, question: 'I drink as _____ water as possible.', options: ['much','many','more','most'], correctAnswer: 'much', explanation: 'Water không đếm được'),
        GrammarExerciseItem(id: 'ex54_4', type: ExerciseType.multipleChoice, question: 'He has as many books _____ she does.', options: ['as','than','like','from'], correctAnswer: 'as', explanation: 'As many...as'),
        GrammarExerciseItem(id: 'ex54_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','as','much','money','as','you'], correctAnswer: 'I have as much money as you', explanation: 'As much...as'),
        GrammarExerciseItem(id: 'ex54_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','has','as','many','friends','as','I','do'], correctAnswer: 'She has as many friends as I do', explanation: 'As many...as'),
        GrammarExerciseItem(id: 'ex54_7', type: ExerciseType.fillInBlank, question: 'I have as _____ (much/many) time as you.', correctAnswer: 'much', explanation: 'Time không đếm được'),
      ],
      order: 54,
    );
  }

  static GrammarLesson _createLesson55_WhenWhile() {
    return const GrammarLesson(
      id: 'lesson_55',
      categoryId: 'cat_5',
      title: 'Cấu Trúc When và While',
      objective: 'Nắm vững cách sử dụng "when" và "while" để chỉ thời gian',
      theory: 'When và While là liên từ chỉ thời gian. "When" có nghĩa "khi", dùng cho hành động ngắn hoặc điểm thời gian cụ thể. "While" có nghĩa "trong khi", dùng cho hành động kéo dài, thường đi với thì tiếp diễn. Cả hai đều theo sau bởi mệnh đề (S + V).',
      formulas: [
        '📌 WHEN:',
        '• When + S + V (hành động ngắn)',
        '  Ví dụ: When I came, he was sleeping.',
        '  (Khi tôi đến, anh ấy đang ngủ)',
        '',
        '📌 WHILE:',
        '• While + S + V (hành động kéo dài)',
        '  Ví dụ: While I was studying, he called.',
        '  (Trong khi tôi đang học, anh ấy gọi)',
      ],
      usages: [
        'When: hành động ngắn, điểm thời gian',
        'While: hành động kéo dài, tiếp diễn',
        'Cả hai đều + S + V',
        'Chỉ thời gian xảy ra sự việc',
      ],
      examples: [
        GrammarExample(english: 'When I came, he was sleeping.', vietnamese: 'Khi tôi đến, anh ấy đang ngủ.', note: 'When + hành động ngắn'),
        GrammarExample(english: 'While I was studying, he called.', vietnamese: 'Trong khi tôi đang học, anh ấy gọi.', note: 'While + hành động kéo dài'),
        GrammarExample(english: 'When she arrived, we were having dinner.', vietnamese: 'Khi cô ấy đến, chúng tôi đang ăn tối.', note: 'When + thời điểm'),
        GrammarExample(english: 'While he was cooking, I was reading.', vietnamese: 'Trong khi anh ấy nấu ăn, tôi đang đọc sách.', note: '2 hành động song song'),
      ],
      recognitionSigns: ['Có "when" hoặc "while"', 'Chỉ thời gian', 'Theo sau là S + V'],
      commonMistakes: [
        '❌ when coming → ✅ when I came (cần S + V)',
        '❌ while come → ✅ while I was coming (while + tiếp diễn)',
        '❌ When I came, he sleeps → ✅ When I came, he was sleeping (thì phù hợp)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex55_1', type: ExerciseType.multipleChoice, question: '_____ I came, he was sleeping.', options: ['When','While','If','Because'], correctAnswer: 'When', explanation: 'When + hành động ngắn'),
        GrammarExerciseItem(id: 'ex55_2', type: ExerciseType.multipleChoice, question: '_____ I was studying, he called.', options: ['While','When','If','Because'], correctAnswer: 'While', explanation: 'While + tiếp diễn'),
        GrammarExerciseItem(id: 'ex55_3', type: ExerciseType.multipleChoice, question: 'When she _____, we were having dinner.', options: ['arrived','was arriving','arrives','arriving'], correctAnswer: 'arrived', explanation: 'When + quá khứ đơn'),
        GrammarExerciseItem(id: 'ex55_4', type: ExerciseType.multipleChoice, question: 'While he _____ cooking, I was reading.', options: ['was','is','were','be'], correctAnswer: 'was', explanation: 'While + tiếp diễn'),
        GrammarExerciseItem(id: 'ex55_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['When','I','came','he','was','sleeping'], correctAnswer: 'When I came he was sleeping', explanation: 'When + S + V'),
        GrammarExerciseItem(id: 'ex55_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['While','I','was','studying','he','called'], correctAnswer: 'While I was studying he called', explanation: 'While + S + V'),
        GrammarExerciseItem(id: 'ex55_7', type: ExerciseType.fillInBlank, question: '_____ (When/While) I was cooking, she came.', correctAnswer: 'While', explanation: 'While + tiếp diễn'),
      ],
      order: 55,
    );
  }

  static GrammarLesson _createLesson56_Find() {
    return const GrammarLesson(
      id: 'lesson_56',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Find',
      objective: 'Nắm vững cách sử dụng "find" để diễn tả nhận thấy, cảm thấy',
      theory: 'Find có nghĩa "thấy", "nhận thấy", "cảm thấy", dùng để diễn tả ý kiến cá nhân về mức độ khó/dễ của việc gì. Cấu trúc: Find + it + adj + to V. "It" là tân ngữ giả, "to V" là chủ ngữ thực sự. Không được bỏ "it".',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Find + it + adj + to V',
        '  Ví dụ: I find it difficult to learn English.',
        '  (Tôi thấy khó để học tiếng Anh)',
        '',
        '• Find + O + adj',
        '  Ví dụ: I find this book interesting.',
        '  (Tôi thấy cuốn sách này thú vị)',
      ],
      usages: [
        'Nhận thấy, cảm thấy',
        'Diễn tả ý kiến cá nhân',
        'Find it + adj + to V: cần "it" làm tân ngữ giả',
        'Tương tự "think"',
      ],
      examples: [
        GrammarExample(english: 'I find it difficult to learn English.', vietnamese: 'Tôi thấy khó để học tiếng Anh.', note: 'Find it + adj + to V'),
        GrammarExample(english: 'She finds it easy to make friends.', vietnamese: 'Cô ấy thấy dễ kết bạn.', note: 'Nhận thấy'),
        GrammarExample(english: 'I find this book interesting.', vietnamese: 'Tôi thấy cuốn sách này thú vị.', note: 'Find + O + adj'),
        GrammarExample(english: 'We find it hard to believe.', vietnamese: 'Chúng tôi thấy khó tin.', note: 'Cảm thấy'),
      ],
      recognitionSigns: ['Có "find"', 'Có "it" + adj + to V', 'Diễn tả nhận thấy'],
      commonMistakes: [
        '❌ find difficult → ✅ find it difficult (cần "it")',
        '❌ find to learn difficult → ✅ find it difficult to learn (thứ tự đúng)',
        '❌ I find that difficult → ✅ I find it difficult',
        '❌ find it is difficult → ✅ find it difficult (không cần "is")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex56_1', type: ExerciseType.multipleChoice, question: 'I find _____ difficult to learn.', options: ['it','this','that','them'], correctAnswer: 'it', explanation: 'Find it + adj'),
        GrammarExerciseItem(id: 'ex56_2', type: ExerciseType.multipleChoice, question: 'She finds _____ easy to make friends.', options: ['it','this','that','them'], correctAnswer: 'it', explanation: 'Find it + adj'),
        GrammarExerciseItem(id: 'ex56_3', type: ExerciseType.multipleChoice, question: 'I find this book _____.', options: ['interesting','interested','interest','to interest'], correctAnswer: 'interesting', explanation: 'Find + O + adj'),
        GrammarExerciseItem(id: 'ex56_4', type: ExerciseType.multipleChoice, question: 'We find it hard _____ believe.', options: ['to','for','at','in'], correctAnswer: 'to', explanation: 'Find it + adj + to V'),
        GrammarExerciseItem(id: 'ex56_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','find','it','difficult','to','learn'], correctAnswer: 'I find it difficult to learn', explanation: 'Find it + adj + to V'),
        GrammarExerciseItem(id: 'ex56_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','finds','it','easy','to','make','friends'], correctAnswer: 'She finds it easy to make friends', explanation: 'Find it + adj + to V'),
        GrammarExerciseItem(id: 'ex56_7', type: ExerciseType.fillInBlank, question: 'I find _____ (it/this) hard to understand.', correctAnswer: 'it', explanation: 'Find it + adj'),
      ],
      order: 56,
    );
  }

  static GrammarLesson _createLesson57_Remember() {
    return const GrammarLesson(
      id: 'lesson_57',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Remember',
      objective: 'Nắm vững cách sử dụng "remember" để diễn tả nhớ làm gì hoặc nhớ đã làm gì',
      theory: 'Remember có nghĩa "nhớ", có 2 cấu trúc khác nhau: "Remember + to V" (nhớ phải làm gì - chưa làm) và "Remember + V-ing" (nhớ đã làm gì - đã làm rồi). Sự khác biệt này rất quan trọng. Tương tự: forget + to V / V-ing.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Remember + to V (nhớ phải làm - chưa làm)',
        '  Ví dụ: Remember to lock the door.',
        '  (Nhớ khóa cửa nhé)',
        '',
        '• Remember + V-ing (nhớ đã làm - đã làm rồi)',
        '  Ví dụ: I remember locking the door.',
        '  (Tôi nhớ đã khóa cửa)',
      ],
      usages: [
        'Remember + to V: nhớ phải làm (tương lai)',
        'Remember + V-ing: nhớ đã làm (quá khứ)',
        'Phân biệt rõ 2 cấu trúc',
        'Tương tự: forget, regret, stop',
      ],
      examples: [
        GrammarExample(english: 'Remember to lock the door.', vietnamese: 'Nhớ khóa cửa nhé.', note: 'Remember + to V (chưa làm)'),
        GrammarExample(english: 'I remember locking the door.', vietnamese: 'Tôi nhớ đã khóa cửa.', note: 'Remember + V-ing (đã làm)'),
        GrammarExample(english: 'Remember to call me.', vietnamese: 'Nhớ gọi cho tôi nhé.', note: 'Nhắc nhở'),
        GrammarExample(english: 'I remember meeting him before.', vietnamese: 'Tôi nhớ đã gặp anh ấy trước đây.', note: 'Hồi tưởng'),
      ],
      recognitionSigns: ['Có "remember"', 'Theo sau là to V hoặc V-ing', 'Phân biệt chưa làm/đã làm'],
      commonMistakes: [
        '❌ remember lock → ✅ remember to lock (cần "to")',
        '❌ remember to locking → ✅ remember locking (không dùng cả 2)',
        '❌ I remember to lock (đã làm) → ✅ I remember locking',
        '❌ Remember locking the door (nhắc nhở) → ✅ Remember to lock the door',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex57_1', type: ExerciseType.multipleChoice, question: 'Remember _____ lock the door.', options: ['to','for','locking','lock'], correctAnswer: 'to', explanation: 'Remember + to V (nhắc nhở)'),
        GrammarExerciseItem(id: 'ex57_2', type: ExerciseType.multipleChoice, question: 'I remember _____ him before.', options: ['meeting','to meet','meet','met'], correctAnswer: 'meeting', explanation: 'Remember + V-ing (đã làm)'),
        GrammarExerciseItem(id: 'ex57_3', type: ExerciseType.multipleChoice, question: 'Remember _____ call me.', options: ['to','calling','call','for'], correctAnswer: 'to', explanation: 'Remember + to V'),
        GrammarExerciseItem(id: 'ex57_4', type: ExerciseType.multipleChoice, question: 'I remember _____ the door.', options: ['locking','to lock','lock','locked'], correctAnswer: 'locking', explanation: 'Remember + V-ing'),
        GrammarExerciseItem(id: 'ex57_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Remember','to','lock','the','door'], correctAnswer: 'Remember to lock the door', explanation: 'Remember + to V'),
        GrammarExerciseItem(id: 'ex57_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','remember','meeting','him','before'], correctAnswer: 'I remember meeting him before', explanation: 'Remember + V-ing'),
        GrammarExerciseItem(id: 'ex57_7', type: ExerciseType.fillInBlank, question: 'Remember _____ (bring) your book tomorrow.', correctAnswer: 'to bring', explanation: 'Remember + to V'),
      ],
      order: 57,
    );
  }

  static GrammarLesson _createLesson58_Unless() {
    return const GrammarLesson(
      id: 'lesson_58',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Unless',
      objective: 'Nắm vững cách sử dụng "unless" để diễn tả điều kiện "trừ khi"',
      theory: 'Unless có nghĩa "trừ khi", "nếu không", tương đương với "if not". Unless đã mang nghĩa phủ định nên KHÔNG dùng "not" sau unless. Cấu trúc: Unless + S + V (khẳng định). Unless thường dùng trong câu điều kiện loại 1.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Unless + S + V = If...not',
        '  Ví dụ: Unless you study, you will fail.',
        '  = If you don\'t study, you will fail.',
        '  (Trừ khi bạn học, bạn sẽ trượt)',
        '',
        '📌 LƯU Ý:',
        '• Unless = If not (đã có nghĩa phủ định)',
        '• Không dùng "not" sau unless',
      ],
      usages: [
        'Diễn tả điều kiện "trừ khi"',
        'Unless = If not',
        'Sau unless là động từ khẳng định',
        'Thường dùng trong câu điều kiện loại 1',
      ],
      examples: [
        GrammarExample(english: 'Unless you study, you will fail.', vietnamese: 'Trừ khi bạn học, bạn sẽ trượt.', note: 'Unless + S + V'),
        GrammarExample(english: 'Unless it rains, we will go out.', vietnamese: 'Trừ khi trời mưa, chúng ta sẽ ra ngoài.', note: 'Điều kiện'),
        GrammarExample(english: 'I won\'t go unless you come with me.', vietnamese: 'Tôi sẽ không đi trừ khi bạn đi cùng tôi.', note: 'Unless = if not'),
        GrammarExample(english: 'Unless you hurry, you\'ll be late.', vietnamese: 'Trừ khi bạn nhanh lên, bạn sẽ trễ.', note: 'Cảnh báo'),
      ],
      recognitionSigns: ['Có "unless"', 'Tương đương "if not"', 'Điều kiện phủ định'],
      commonMistakes: [
        '❌ unless you don\'t study → ✅ unless you study (không dùng "not")',
        '❌ unless not → ✅ unless (đã có nghĩa phủ định)',
        '❌ Unless you will study → ✅ Unless you study (không dùng will sau unless)',
        '❌ if you unless → ✅ unless you / if you don\'t',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex58_1', type: ExerciseType.multipleChoice, question: 'Unless you _____, you will fail.', options: ['study','don\'t study','will study','studied'], correctAnswer: 'study', explanation: 'Unless + S + V (khẳng định)'),
        GrammarExerciseItem(id: 'ex58_2', type: ExerciseType.multipleChoice, question: 'Unless it _____, we will go out.', options: ['rains','doesn\'t rain','will rain','rained'], correctAnswer: 'rains', explanation: 'Unless + S + V'),
        GrammarExerciseItem(id: 'ex58_3', type: ExerciseType.multipleChoice, question: 'I won\'t go _____ you come with me.', options: ['unless','if','when','because'], correctAnswer: 'unless', explanation: 'Unless = trừ khi'),
        GrammarExerciseItem(id: 'ex58_4', type: ExerciseType.multipleChoice, question: 'Unless you hurry, you _____ late.', options: ['\'ll be','are','were','be'], correctAnswer: '\'ll be', explanation: 'Unless + hiện tại, will + V'),
        GrammarExerciseItem(id: 'ex58_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Unless','you','study','you','will','fail'], correctAnswer: 'Unless you study you will fail', explanation: 'Unless + S + V'),
        GrammarExerciseItem(id: 'ex58_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Unless','it','rains','we','will','go','out'], correctAnswer: 'Unless it rains we will go out', explanation: 'Unless + S + V'),
        GrammarExerciseItem(id: 'ex58_7', type: ExerciseType.fillInBlank, question: 'Unless you _____ (hurry), you will be late.', correctAnswer: 'hurry', explanation: 'Unless + V (khẳng định)'),
      ],
      order: 58,
    );
  }

  static GrammarLesson _createLesson59_HadBetter() {
    return const GrammarLesson(
      id: 'lesson_59',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Had Better',
      objective: 'Nắm vững cách sử dụng "had better" để khuyên nên làm gì',
      theory: 'Had better có nghĩa "nên", "tốt hơn là nên", dùng để khuyên ai đó nên làm gì, thường mang ý cảnh báo nếu không làm sẽ có hậu quả xấu. Cấu trúc: Had better + V (nguyên mẫu không "to"). Viết tắt: \'d better. Phủ định: had better not + V.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Had better + V (nguyên mẫu không "to")',
        '  Ví dụ: You had better study hard.',
        '  (Bạn nên học chăm chỉ)',
        '',
        '📌 VIẾT TẮT:',
        '• You\'d better + V',
        '  Ví dụ: You\'d better hurry.',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Had better not + V',
        '  Ví dụ: You\'d better not be late.',
      ],
      usages: [
        'Khuyên nên làm gì',
        'Mang ý cảnh báo',
        'Sau had better là V nguyên mẫu (không "to")',
        'Mạnh hơn "should"',
      ],
      examples: [
        GrammarExample(english: 'You had better study hard.', vietnamese: 'Bạn nên học chăm chỉ.', note: 'Had better + V'),
        GrammarExample(english: 'You\'d better hurry or you\'ll be late.', vietnamese: 'Bạn nên nhanh lên không sẽ trễ.', note: 'Cảnh báo'),
        GrammarExample(english: 'You\'d better not be late.', vietnamese: 'Bạn không nên trễ.', note: 'Phủ định'),
        GrammarExample(english: 'We\'d better go now.', vietnamese: 'Chúng ta nên đi bây giờ.', note: 'Đề nghị'),
      ],
      recognitionSigns: ['Có "had better"', 'Sau đó là V nguyên mẫu', 'Khuyên với cảnh báo'],
      commonMistakes: [
        '❌ had better to study → ✅ had better study (không có "to")',
        '❌ had better studying → ✅ had better study (V nguyên mẫu)',
        '❌ You better go → ✅ You had better go (cần "had")',
        '❌ had not better → ✅ had better not (thứ tự đúng)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex59_1', type: ExerciseType.multipleChoice, question: 'You had better _____ hard.', options: ['study','to study','studying','studied'], correctAnswer: 'study', explanation: 'Had better + V'),
        GrammarExerciseItem(id: 'ex59_2', type: ExerciseType.multipleChoice, question: 'You\'d better _____ or you\'ll be late.', options: ['hurry','to hurry','hurrying','hurried'], correctAnswer: 'hurry', explanation: 'Had better + V'),
        GrammarExerciseItem(id: 'ex59_3', type: ExerciseType.multipleChoice, question: 'You\'d better _____ be late.', options: ['not','don\'t','to not','not to'], correctAnswer: 'not', explanation: 'Had better not + V'),
        GrammarExerciseItem(id: 'ex59_4', type: ExerciseType.multipleChoice, question: 'We\'d better _____ now.', options: ['go','to go','going','goes'], correctAnswer: 'go', explanation: 'Had better + V'),
        GrammarExerciseItem(id: 'ex59_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You','had','better','study','hard'], correctAnswer: 'You had better study hard', explanation: 'Had better + V'),
        GrammarExerciseItem(id: 'ex59_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['You\'d','better','not','be','late'], correctAnswer: 'You\'d better not be late', explanation: 'Had better not + V'),
        GrammarExerciseItem(id: 'ex59_7', type: ExerciseType.fillInBlank, question: 'You had better _____ (hurry) up.', correctAnswer: 'hurry', explanation: 'Had better + V'),
      ],
      order: 59,
    );
  }

  static GrammarLesson _createLesson60_Despite() {
    return const GrammarLesson(
      id: 'lesson_60',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Despite / In Spite Of',
      objective: 'Nắm vững cách sử dụng "despite" và "in spite of" để diễn tả "mặc dù"',
      theory: 'Despite và In spite of có nghĩa "mặc dù", dùng để diễn tả sự tương phản. Sau despite/in spite of là danh từ (N) hoặc V-ing. LƯU Ý: Despite KHÔNG có "of", nhưng In spite OF có "of". Khác với "although" (+ S + V).',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Despite + N / V-ing',
        '  Ví dụ: Despite the rain, I went out.',
        '  (Mặc dù mưa, tôi ra ngoài)',
        '',
        '• In spite of + N / V-ing',
        '  Ví dụ: In spite of being tired, she worked.',
        '  (Mặc dù mệt, cô ấy vẫn làm việc)',
        '',
        '📌 LƯU Ý:',
        '• Despite ≠ Despite of (❌)',
        '• Although + S + V (khác biệt)',
      ],
      usages: [
        'Diễn tả sự tương phản',
        'Despite = In spite of',
        'Sau đó là N hoặc V-ing',
        'Khác với although (+ S + V)',
      ],
      examples: [
        GrammarExample(english: 'Despite the rain, I went out.', vietnamese: 'Mặc dù mưa, tôi ra ngoài.', note: 'Despite + N'),
        GrammarExample(english: 'In spite of being tired, she worked.', vietnamese: 'Mặc dù mệt, cô ấy vẫn làm việc.', note: 'In spite of + V-ing'),
        GrammarExample(english: 'Despite his age, he is very active.', vietnamese: 'Mặc dù tuổi tác, ông ấy rất năng động.', note: 'Tương phản'),
        GrammarExample(english: 'In spite of the difficulties, we succeeded.', vietnamese: 'Mặc dù khó khăn, chúng tôi thành công.', note: 'Vượt qua'),
      ],
      recognitionSigns: ['Có "despite" hoặc "in spite of"', 'Sau đó là N/V-ing', 'Diễn tả tương phản'],
      commonMistakes: [
        '❌ despite of → ✅ despite (không có "of")',
        '❌ in spite → ✅ in spite of (cần "of")',
        '❌ despite he was tired → ✅ despite being tired / although he was tired',
        '❌ despite to be tired → ✅ despite being tired',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex60_1', type: ExerciseType.multipleChoice, question: 'Despite _____, I went out.', options: ['the rain','it rained','raining','to rain'], correctAnswer: 'the rain', explanation: 'Despite + N'),
        GrammarExerciseItem(id: 'ex60_2', type: ExerciseType.multipleChoice, question: 'In spite _____ being tired, she worked.', options: ['of','to','for','at'], correctAnswer: 'of', explanation: 'In spite of'),
        GrammarExerciseItem(id: 'ex60_3', type: ExerciseType.multipleChoice, question: 'Despite his _____, he is very active.', options: ['age','old','aging','to age'], correctAnswer: 'age', explanation: 'Despite + N'),
        GrammarExerciseItem(id: 'ex60_4', type: ExerciseType.multipleChoice, question: 'In spite of the difficulties, we _____.', options: ['succeeded','success','successful','succeed'], correctAnswer: 'succeeded', explanation: 'Quá khứ đơn'),
        GrammarExerciseItem(id: 'ex60_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Despite','the','rain','I','went','out'], correctAnswer: 'Despite the rain I went out', explanation: 'Despite + N'),
        GrammarExerciseItem(id: 'ex60_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['In','spite','of','being','tired','she','worked'], correctAnswer: 'In spite of being tired she worked', explanation: 'In spite of + V-ing'),
        GrammarExerciseItem(id: 'ex60_7', type: ExerciseType.fillInBlank, question: 'Despite _____ (be) sick, he went to work.', correctAnswer: 'being', explanation: 'Despite + V-ing'),
      ],
      order: 60,
    );
  }

  static GrammarLesson _createLesson61_ItWasNotUntil() {
    return const GrammarLesson(
      id: 'lesson_61',
      categoryId: 'cat_5',
      title: 'Cấu Trúc It Was Not Until',
      objective: 'Nắm vững cách sử dụng "it was not until" để nhấn mạnh thời gian "mãi đến khi"',
      theory: 'It was not until có nghĩa "mãi đến khi", dùng để nhấn mạnh thời điểm một sự việc xảy ra. Cấu trúc: It was not until + thời gian/sự kiện + that + S + V. LƯU Ý: Dùng "that", KHÔNG dùng "when". Có thể đảo ngữ: Not until + thời gian + did + S + V.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• It was not until + time/event + that + S + V',
        '  Ví dụ: It was not until 10pm that he came.',
        '  (Mãi đến 10h tối anh ấy mới đến)',
        '',
        '📌 ĐẢO NGỮU:',
        '• Not until + time + did + S + V',
        '  Ví dụ: Not until 10pm did he come.',
        '',
        '📌 LƯU Ý:',
        '• Dùng "that", không dùng "when"',
      ],
      usages: [
        'Nhấn mạnh thời gian',
        'Diễn tả "mãi đến khi"',
        'Dùng "that" sau until',
        'Có thể đảo ngữ',
      ],
      examples: [
        GrammarExample(english: 'It was not until 10pm that he came.', vietnamese: 'Mãi đến 10h tối anh ấy mới đến.', note: 'It was not until...that'),
        GrammarExample(english: 'It was not until yesterday that I knew.', vietnamese: 'Mãi đến hôm qua tôi mới biết.', note: 'Nhấn mạnh'),
        GrammarExample(english: 'Not until midnight did she arrive.', vietnamese: 'Mãi đến nửa đêm cô ấy mới đến.', note: 'Đảo ngữ'),
        GrammarExample(english: 'It was not until I met her that I understood.', vietnamese: 'Mãi đến khi gặp cô ấy tôi mới hiểu.', note: 'Sự kiện'),
      ],
      recognitionSigns: ['Có "it was not until"', 'Dùng "that" sau until', 'Nhấn mạnh thời gian'],
      commonMistakes: [
        '❌ not until...when → ✅ not until...that (dùng "that")',
        '❌ It was not until 10pm he came → ✅ It was not until 10pm that he came (cần "that")',
        '❌ It was until 10pm that → ✅ It was not until 10pm that (cần "not")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex61_1', type: ExerciseType.multipleChoice, question: 'It was not until 10pm _____ he came.', options: ['that','when','which','where'], correctAnswer: 'that', explanation: 'Not until...that'),
        GrammarExerciseItem(id: 'ex61_2', type: ExerciseType.multipleChoice, question: 'It was not until yesterday _____ I knew.', options: ['that','when','which','who'], correctAnswer: 'that', explanation: 'Not until...that'),
        GrammarExerciseItem(id: 'ex61_3', type: ExerciseType.multipleChoice, question: 'Not until midnight _____ she arrive.', options: ['did','does','do','was'], correctAnswer: 'did', explanation: 'Đảo ngữ'),
        GrammarExerciseItem(id: 'ex61_4', type: ExerciseType.multipleChoice, question: 'It was not until I met her _____ I understood.', options: ['that','when','which','where'], correctAnswer: 'that', explanation: 'Not until...that'),
        GrammarExerciseItem(id: 'ex61_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['It','was','not','until','10pm','that','he','came'], correctAnswer: 'It was not until 10pm that he came', explanation: 'Not until...that'),
        GrammarExerciseItem(id: 'ex61_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Not','until','midnight','did','she','arrive'], correctAnswer: 'Not until midnight did she arrive', explanation: 'Đảo ngữ'),
        GrammarExerciseItem(id: 'ex61_7', type: ExerciseType.fillInBlank, question: 'It was not until yesterday _____ (that/when) I knew.', correctAnswer: 'that', explanation: 'Not until...that'),
      ],
      order: 61,
    );
  }

  static GrammarLesson _createLesson62_Need() {
    return const GrammarLesson(
      id: 'lesson_62',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Need',
      objective: 'Nắm vững cách sử dụng "need" để diễn tả cần làm gì',
      theory: 'Need có nghĩa "cần", có 2 cấu trúc: "Need + to V" (cần làm gì - chủ động) và "Need + V-ing" (cần được làm gì - bị động). Ví dụ: "The car needs washing" = "The car needs to be washed". Phủ định: don\'t need to V / needn\'t V.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Need + to V (cần làm - chủ động)',
        '  Ví dụ: I need to study.',
        '  (Tôi cần học)',
        '',
        '• Need + V-ing (cần được làm - bị động)',
        '  Ví dụ: The car needs washing.',
        '  = The car needs to be washed.',
        '  (Xe cần được rửa)',
        '',
        '📌 PHỦ ĐỊNH:',
        '• Don\'t need to V / Needn\'t V',
      ],
      usages: [
        'Diễn tả sự cần thiết',
        'Need + to V: chủ động',
        'Need + V-ing: bị động',
        'Phủ định: don\'t need to',
      ],
      examples: [
        GrammarExample(english: 'I need to study.', vietnamese: 'Tôi cần học.', note: 'Need + to V'),
        GrammarExample(english: 'The car needs washing.', vietnamese: 'Xe cần được rửa.', note: 'Need + V-ing (bị động)'),
        GrammarExample(english: 'You don\'t need to worry.', vietnamese: 'Bạn không cần lo lắng.', note: 'Phủ định'),
        GrammarExample(english: 'This room needs cleaning.', vietnamese: 'Phòng này cần được dọn dẹp.', note: 'Need + V-ing'),
      ],
      recognitionSigns: ['Có "need"', 'Theo sau là to V hoặc V-ing', 'Diễn tả sự cần thiết'],
      commonMistakes: [
        '❌ need study → ✅ need to study (cần "to")',
        '❌ need studying → ✅ need to study (khi chủ động)',
        '❌ The car needs to wash → ✅ The car needs washing / needs to be washed',
        '❌ don\'t need study → ✅ don\'t need to study',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex62_1', type: ExerciseType.multipleChoice, question: 'I need _____ study.', options: ['to','for','studying','study'], correctAnswer: 'to', explanation: 'Need + to V'),
        GrammarExerciseItem(id: 'ex62_2', type: ExerciseType.multipleChoice, question: 'The car needs _____.', options: ['washing','to wash','wash','washed'], correctAnswer: 'washing', explanation: 'Need + V-ing (bị động)'),
        GrammarExerciseItem(id: 'ex62_3', type: ExerciseType.multipleChoice, question: 'You don\'t need _____ worry.', options: ['to','for','worrying','worry'], correctAnswer: 'to', explanation: 'Don\'t need to V'),
        GrammarExerciseItem(id: 'ex62_4', type: ExerciseType.multipleChoice, question: 'This room needs _____.', options: ['cleaning','to clean','clean','cleaned'], correctAnswer: 'cleaning', explanation: 'Need + V-ing'),
        GrammarExerciseItem(id: 'ex62_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','need','to','study'], correctAnswer: 'I need to study', explanation: 'Need + to V'),
        GrammarExerciseItem(id: 'ex62_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['The','car','needs','washing'], correctAnswer: 'The car needs washing', explanation: 'Need + V-ing'),
        GrammarExerciseItem(id: 'ex62_7', type: ExerciseType.fillInBlank, question: 'I need _____ (go) now.', correctAnswer: 'to go', explanation: 'Need + to V'),
      ],
      order: 62,
    );
  }

  static GrammarLesson _createLesson63_Regret() {
    return const GrammarLesson(
      id: 'lesson_63',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Regret',
      objective: 'Nắm vững cách sử dụng "regret" để diễn tả hối tiếc',
      theory: 'Regret có nghĩa "hối tiếc", có 2 cấu trúc: "Regret + V-ing" (hối tiếc đã làm gì - quá khứ) và "Regret + to V" (tiếc phải làm gì - hiện tại, thường dùng với inform, tell, say). Tương tự remember, forget, stop.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Regret + V-ing (hối tiếc đã làm)',
        '  Ví dụ: I regret not studying harder.',
        '  (Tôi hối tiếc không học chăm hơn)',
        '',
        '• Regret + to V (tiếc phải làm)',
        '  Ví dụ: I regret to inform you...',
        '  (Tôi rất tiếc phải thông báo...)',
        '',
        '📌 LƯU Ý:',
        '• Regret + to V: thường với inform, tell, say',
      ],
      usages: [
        'Regret + V-ing: hối tiếc quá khứ',
        'Regret + to V: tiếc hiện tại',
        'Phân biệt rõ 2 cấu trúc',
        'Tương tự: remember, forget',
      ],
      examples: [
        GrammarExample(english: 'I regret not studying harder.', vietnamese: 'Tôi hối tiếc không học chăm hơn.', note: 'Regret + V-ing'),
        GrammarExample(english: 'I regret to inform you that...', vietnamese: 'Tôi rất tiếc phải thông báo rằng...', note: 'Regret + to V'),
        GrammarExample(english: 'She regrets buying that car.', vietnamese: 'Cô ấy hối tiếc đã mua chiếc xe đó.', note: 'Hối tiếc quá khứ'),
        GrammarExample(english: 'I regret to say that I can\'t help.', vietnamese: 'Tôi rất tiếc phải nói rằng tôi không thể giúp.', note: 'Tiếc hiện tại'),
      ],
      recognitionSigns: ['Có "regret"', 'Theo sau là V-ing hoặc to V', 'Diễn tả hối tiếc'],
      commonMistakes: [
        '❌ regret to not study → ✅ regret not studying (hối tiếc quá khứ)',
        '❌ regret buying (tiếc hiện tại) → ✅ regret to buy',
        '❌ I regret to buy → ✅ I regret buying (hối tiếc đã mua)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex63_1', type: ExerciseType.multipleChoice, question: 'I regret _____ that.', options: ['doing','to do','do','did'], correctAnswer: 'doing', explanation: 'Regret + V-ing (hối tiếc đã làm)'),
        GrammarExerciseItem(id: 'ex63_2', type: ExerciseType.multipleChoice, question: 'I regret _____ inform you.', options: ['to','for','informing','inform'], correctAnswer: 'to', explanation: 'Regret + to V (tiếc phải)'),
        GrammarExerciseItem(id: 'ex63_3', type: ExerciseType.multipleChoice, question: 'She regrets _____ that car.', options: ['buying','to buy','buy','bought'], correctAnswer: 'buying', explanation: 'Regret + V-ing'),
        GrammarExerciseItem(id: 'ex63_4', type: ExerciseType.multipleChoice, question: 'I regret _____ say that I can\'t help.', options: ['to','for','saying','say'], correctAnswer: 'to', explanation: 'Regret + to V'),
        GrammarExerciseItem(id: 'ex63_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','regret','not','studying','harder'], correctAnswer: 'I regret not studying harder', explanation: 'Regret + V-ing'),
        GrammarExerciseItem(id: 'ex63_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','regret','to','inform','you'], correctAnswer: 'I regret to inform you', explanation: 'Regret + to V'),
        GrammarExerciseItem(id: 'ex63_7', type: ExerciseType.fillInBlank, question: 'I regret _____ (not study) harder.', correctAnswer: 'not studying', explanation: 'Regret + V-ing'),
      ],
      order: 63,
    );
  }

  static GrammarLesson _createLesson64_Stop() {
    return const GrammarLesson(
      id: 'lesson_64',
      categoryId: 'cat_5',
      title: 'Cấu Trúc Stop',
      objective: 'Nắm vững cách sử dụng "stop" để diễn tả dừng làm gì',
      theory: 'Stop có nghĩa "dừng", có 2 cấu trúc KHÁC NHAU: "Stop + V-ing" (dừng làm gì - không làm nữa) và "Stop + to V" (dừng lại để làm gì - làm việc khác). Sự khác biệt này rất quan trọng. Tương tự: remember, forget, regret.',
      formulas: [
        '📌 CẤU TRÚC:',
        '• Stop + V-ing (dừng làm gì)',
        '  Ví dụ: Stop smoking!',
        '  (Dừng hút thuốc!)',
        '',
        '• Stop + to V (dừng lại để làm gì)',
        '  Ví dụ: I stopped to rest.',
        '  (Tôi dừng lại để nghỉ)',
        '',
        '📌 LƯU Ý:',
        '• Stop smoking = dừng hút',
        '• Stop to smoke = dừng lại để hút',
      ],
      usages: [
        'Stop + V-ing: dừng làm (không làm nữa)',
        'Stop + to V: dừng để làm (mục đích)',
        'Phân biệt rõ 2 cấu trúc',
        'Tương tự: remember, forget',
      ],
      examples: [
        GrammarExample(english: 'Stop smoking!', vietnamese: 'Dừng hút thuốc!', note: 'Stop + V-ing (dừng làm)'),
        GrammarExample(english: 'I stopped to rest.', vietnamese: 'Tôi dừng lại để nghỉ.', note: 'Stop + to V (dừng để)'),
        GrammarExample(english: 'Stop talking!', vietnamese: 'Dừng nói chuyện!', note: 'Dừng làm gì'),
        GrammarExample(english: 'He stopped to buy some food.', vietnamese: 'Anh ấy dừng lại để mua đồ ăn.', note: 'Mục đích'),
      ],
      recognitionSigns: ['Có "stop"', 'Theo sau là V-ing hoặc to V', 'Phân biệt dừng làm/dừng để'],
      commonMistakes: [
        '❌ stop to smoke (dừng hút) → ✅ stop smoking',
        '❌ stop smoking (dừng để hút) → ✅ stop to smoke',
        '❌ stop talk → ✅ stop talking (cần V-ing)',
        '❌ I stopped rest → ✅ I stopped to rest (cần "to")',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex64_1', type: ExerciseType.multipleChoice, question: 'Stop _____! (dừng hút)', options: ['smoking','to smoke','smoke','smoked'], correctAnswer: 'smoking', explanation: 'Stop + V-ing (dừng làm)'),
        GrammarExerciseItem(id: 'ex64_2', type: ExerciseType.multipleChoice, question: 'I stopped _____ rest. (dừng để nghỉ)', options: ['to','for','resting','rest'], correctAnswer: 'to', explanation: 'Stop + to V (dừng để)'),
        GrammarExerciseItem(id: 'ex64_3', type: ExerciseType.multipleChoice, question: 'Stop _____! (dừng nói)', options: ['talking','to talk','talk','talked'], correctAnswer: 'talking', explanation: 'Stop + V-ing'),
        GrammarExerciseItem(id: 'ex64_4', type: ExerciseType.multipleChoice, question: 'He stopped _____ buy food. (dừng để mua)', options: ['to','for','buying','buy'], correctAnswer: 'to', explanation: 'Stop + to V'),
        GrammarExerciseItem(id: 'ex64_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['Stop','smoking'], correctAnswer: 'Stop smoking', explanation: 'Stop + V-ing'),
        GrammarExerciseItem(id: 'ex64_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','stopped','to','rest'], correctAnswer: 'I stopped to rest', explanation: 'Stop + to V'),
        GrammarExerciseItem(id: 'ex64_7', type: ExerciseType.fillInBlank, question: 'Stop _____ (talk)! (dừng nói)', correctAnswer: 'talking', explanation: 'Stop + V-ing'),
      ],
      order: 64,
    );
  }

  static GrammarLesson _createPlaceholder(String id, String catId, String title, int order) {
    return GrammarLesson(
      id: id,
      categoryId: catId,
      title: title,
      objective: 'Đang cập nhật nội dung...',
      theory: 'Nội dung đang được xây dựng.',
      formulas: const [],
      usages: const [],
      examples: const [],
      commonMistakes: const [],
      exercises: const [],
      order: order,
    );
  }
}
