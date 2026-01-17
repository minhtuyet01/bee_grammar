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
        description: '12 thì: Hiện tại, Quá khứ, Tương lai (đơn, tiếp diễn, hoàn thành, hoàn thành tiếp diễn)',
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
        description: 'Câu khẳng định, phủ định, nghi vấn, mệnh lệnh, câu hỏi WH-',
        icon: Icons.format_list_bulleted,
        color: Colors.green,
        order: 2,
        lessonIds: ['lesson_6', 'lesson_7', 'lesson_8', 'lesson_9', 'lesson_10'],
      ),
      const GrammarCategory(
        id: 'cat_3',
        title: 'III. Các Từ Loại',
        description: 'Danh từ, Động từ, Tính từ, Trạng từ, Đại từ, Mạo từ',
        icon: Icons.text_fields,
        color: Colors.orange,
        order: 3,
        lessonIds: ['lesson_11', 'lesson_12', 'lesson_13', 'lesson_14', 'lesson_15', 'lesson_16'],
      ),
      const GrammarCategory(
        id: 'cat_4',
        title: 'IV. Các Dạng Câu Hỏi',
        description: 'Câu bị động, Câu điều kiện, So sánh, There is/are, Modal verbs',
        icon: Icons.star,
        color: Colors.purple,
        order: 4,
        lessonIds: ['lesson_17', 'lesson_18', 'lesson_19', 'lesson_20', 'lesson_21'],
      ),
      const GrammarCategory(
        id: 'cat_5',
        title: 'V. Cấu Trúc Ngữ Pháp Tiếng Anh Cơ Bản',
        description: 'Would you like, How about, Let\'s, Do you mind',
        icon: Icons.chat_bubble,
        color: Colors.teal,
        order: 5,
        lessonIds: ['lesson_22', 'lesson_23', 'lesson_24', 'lesson_25'],
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
      
      // CATEGORY 2: CÁC LOẠI CÂU
      _createLesson6_AffirmativeSentence(),
      _createLesson7_NegativeSentence(),
      _createLesson8_QuestionSentence(),
      _createLesson9_ImperativeSentence(),
      _createLesson10_WHQuestions(),
      
      // CATEGORY 3: CÁC TỪ LOẠI
      _createLesson11_Nouns(),
      _createLesson12_Verbs(),
      _createLesson13_Adjectives(),
      _createLesson14_Adverbs(),
      _createLesson15_Pronouns(),
      _createLesson16_Articles(),
      
      // CATEGORY 4: CẤU TRÚC ĐẶC BIỆT
      _createLesson17_PassiveVoice(),
      _createLesson18_ConditionalType1(),
      _createLesson19_Comparatives(),
      _createLesson20_ThereIsAre(),
      _createLesson21_ModalVerbs(),
      
      // CATEGORY 5: CẤU TRÚC GIAO TIẾP
      _createLesson22_WouldYouLike(),
      _createLesson23_HowAboutLets(),
      _createLesson24_DoYouMind(),
      _createLesson25_OtherSuggestions(),
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
        'Diễn tả một sự thật (tuổi tác, nghề nghiệp, đặc điểm, tính cách) của một người hoặc vật',
        'Diễn tả một năng lực của con người',
        'Diễn tả một kế hoạch đã được sắp xếp cho tương lai (lịch tàu, xe, máy bay)',
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
        'Khẳng định: S + am/is/are + V-ing',
        'Phủ định: S + am/is/are + not + V-ing',
        'Nghi vấn: Am/Is/Are + S + V-ing?',
      ],
      notes: null,
      usages: [
        'Diễn tả một hành động đang diễn ra tại thời điểm nói',
        'Diễn tả hành động đang diễn ra xung quanh thời điểm nói nhưng không phải ngay tại thời điểm nói',
        'Diễn tả một hành động sẽ xảy ra ở trong tương lai gần',
        'Diễn tả một hành động thường xảy ra lặp đi lặp lại (dùng với phó từ ALWAYS)',
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
        'Mốc thời gian trong tương lai gần: this weekend, tonight, at the end of this year',
        'Các từ chỉ "hiện tại": now, right now, at the/this moment',
        'Khoảng thời gian xung quanh "hiện tại": these days, currently, this week, this month',
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
      formulas: [],
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
      formulas: [],
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
      formulas: [],
      notes: null,
      usages: [
        'Diễn tả một hành động đang xảy ra thì bị một hành động khác cắt ngang.\nVí dụ: While I was preparing for our project yesterday, my computer shut down.',
        'Diễn tả hai hành động đang cùng diễn ra tại một thời điểm trong quá khứ.\nVí dụ: Yesterday, I was sweeping the house while my older sister was doing the laundry.',
        'Diễn tả một hành động đang diễn ra tại một thời điểm nhất định trong quá khứ, thường đi kèm với mốc thời gian.\nVí dụ: At 8 a.m this morning, we were studying history.',
      ],
      examples: [],
      recognitionSigns: [
        'Câu chứa các cụm hoặc mệnh đề chỉ thời điểm trong quá khứ: last night, this morning, when she came, at 3am last Monday, at this time last night',
        'Câu phức 2 mệnh đề dùng với "while" hoặc "when"',
      ],
      commonMistakes: [],
      exercises: [],
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
      formulas: [],
      notes: null,
      usages: [
        'Dùng trong câu điều kiện loại 3.\nVí dụ: If you had studied hard, you could have passed the final exam.',
        'Diễn tả hành động đã hoàn thành trước một thời điểm ở trong quá khứ.\nVí dụ: By 5pm yesterday he had left his company.',
      ],
      examples: [],
      recognitionSigns: [
        'Câu có dạng câu phức với: một mệnh đề dùng thì quá khứ hoàn thành, một mệnh đề dùng quá khứ đơn',
        'Các liên từ chỉ thời gian: before, after, by the time, as soon as, until then',
      ],
      commonMistakes: [],
      exercises: [],
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
      formulas: [],
      notes: null,
      usages: [
        'Diễn tả hành động xảy ra và kéo dài liên tục trước một thời điểm được xác định trong quá khứ.\nVí dụ: My wife and I had been quarreling for an hour until 7pm.',
        'Diễn tả hành động xảy ra và liên tục trước một hành động khác trong quá khứ.\nVí dụ: I had been eating candy until my teacher saw me.',
      ],
      examples: [],
      recognitionSigns: [
        'Trong câu có các từ như by the time, until then, prior to that time, before, after',
      ],
      commonMistakes: [],
      exercises: [],
      order: 9,
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
      formulas: [],
      notes: null,
      usages: [
        'Diễn tả một hành động xảy ra trong tương lai tại thời điểm được xác định.\nVí dụ: I will be visiting Ha Noi at this time next Saturday.',
        'Diễn tả về một hành động đang xảy ra trong tương lai thì có hành động khác chen vào.\nVí dụ: I will be waiting for you when the bus come.',
      ],
      examples: [],
      recognitionSigns: [
        'Trong câu thường có các cụm từ: next time, next week, in the future, and soon',
      ],
      commonMistakes: [],
      exercises: [],
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
      formulas: [],
      notes: null,
      usages: [
        'Diễn tả một hành động trong tương lai sẽ kết thúc trước 1 hành động khác trong tương lai.\nVí dụ: She will have finished her homework before 9pm this evening.',
      ],
      examples: [],
      recognitionSigns: [
        'Trong câu chứa by the time, by the end of + thời gian tương lai',
      ],
      commonMistakes: [],
      exercises: [],
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
      formulas: [],
      notes: null,
      usages: [
        'Nhấn mạnh khoảng thời gian của một hành động đang xảy ra trong tương lai và sẽ kết thúc trước một hành động khác trong tương lai.\nVí dụ: I will have been studying English for 5 years by the end of next week.',
      ],
      examples: [],
      recognitionSigns: [
        'Trong câu có by the time, for + khoảng thời gian',
      ],
      commonMistakes: [],
      exercises: [],
      order: 12,
    );
  }

  static GrammarLesson _createLesson5_PresentPerfect() {
    return const GrammarLesson(
      id: 'lesson_5',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Hoàn Thành (Present Perfect)',
      objective: 'Học cách diễn tả hành động đã xảy ra nhưng còn liên quan đến hiện tại',
      theory: 'Thì hiện tại hoàn thành là thì dùng để diễn tả một sự việc, một hành động đã bắt đầu từ trong quá khứ, kéo dài đến hiện tại và có thể tiếp tục diễn ra trong tương lai.',
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
        'Diễn tả hành động xảy ra trong quá khứ nhưng vẫn còn ở hiện tại và tương lai (thường dùng với "since" và "for")',
        'Diễn tả sự lặp đi lặp lại của một hành động trong quá khứ',
        'Diễn tả một hành động xảy ra và kết thúc trong quá khứ nhưng không nói rõ thời gian xảy ra',
        'Diễn tả một hành động vừa mới xảy ra (dùng với "just")',
        'Nói về kinh nghiệm hoặc trải nghiệm (dùng với "ever" và "never")',
      ],
      examples: [
        GrammarExample(
          english: 'I have been an engineer since 2015.',
          vietnamese: 'Tôi là một kỹ sư từ năm 2015.',
          note: 'Hành động từ quá khứ đến hiện tại - dùng "since"',
        ),
        GrammarExample(
          english: 'She has worked here for 5 years.',
          vietnamese: 'Cô ấy đã làm việc ở đây được 5 năm.',
          note: 'Hành động từ quá khứ đến hiện tại - dùng "for"',
        ),
        GrammarExample(
          english: 'I have visited Japan three times.',
          vietnamese: 'Tôi đã đến Nhật Bản ba lần.',
          note: 'Sự lặp lại của hành động',
        ),
        GrammarExample(
          english: 'My sister has lost her key.',
          vietnamese: 'Em gái tôi đã làm mất chìa khóa.',
          note: 'Không nói rõ thời gian',
        ),
        GrammarExample(
          english: 'I have just broken up with my girlfriend.',
          vietnamese: 'Tôi vừa mới chia tay bạn gái.',
          note: 'Vừa mới xảy ra - dùng "just"',
        ),
        GrammarExample(
          english: 'She has just arrived home.',
          vietnamese: 'Cô ấy vừa mới về đến nhà.',
          note: 'Vừa mới xảy ra',
        ),
        GrammarExample(
          english: 'Have you ever eaten sushi?',
          vietnamese: 'Bạn đã từng ăn sushi chưa?',
          note: 'Kinh nghiệm - dùng "ever"',
        ),
        GrammarExample(
          english: 'I have never been to Paris.',
          vietnamese: 'Tôi chưa bao giờ đến Paris.',
          note: 'Kinh nghiệm - dùng "never"',
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


  // LESSON 1_6: Present Perfect Continuous
  static GrammarLesson _createLesson1_6_PresentPerfectContinuous() {
    return const GrammarLesson(
      id: 'lesson_1_6',
      categoryId: 'cat_1',
      title: 'Thì Hiện Tại Hoàn Thành Tiếp Diễn (Present Perfect Continuous)',
      objective: 'Học cách diễn tả hành động bắt đầu trong quá khứ, tiếp tục đến hiện tại và nhấn mạnh tính liên tục',
      theory: 'Thì hiện tại hoàn thành tiếp diễn – Present Perfect Continuous Tense là thì diễn tả sự việc bắt đầu trong quá khứ và tiếp tục ở hiện tại, có thể tiếp diễn ở tương lai hoặc sự việc đã kết thúc nhưng ảnh hưởng kết quả còn lưu lại hiện tại.',
      formulas: [
        '📌 CÔNG THỨC:',
        '• Khẳng định: S + have/has + been + V-ing',
        '  Ví dụ: I have been learning English for 12 years',
        '• Phủ định: S + have/has + not + been + V-ing',
        '  Ví dụ: July hasn\'t been driving a car for 2 years',
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
          english: 'My father has been working since 7 a.m. Now, he must be tired and hungry.',
          vietnamese: 'Ba của tôi làm việc suốt từ 7 giờ sáng. Bây giờ, ông ấy chắc rất mệt và đói bụng.',
          note: 'Nhấn mạnh tính liên tục từ quá khứ đến hiện tại',
        ),
        GrammarExample(
          english: 'It has been raining for 5 hours straight. It has just stopped and most of the streets are flooded now.',
          vietnamese: 'Trời mưa liên tục 5 tiếng. Vừa mới ngừng và hầu hết các con đường bây giờ đều ngập.',
          note: 'Hành động vừa kết thúc nhưng hậu quả còn lại',
        ),
        GrammarExample(
          english: 'I have been studying English for 3 years.',
          vietnamese: 'Tôi đã học tiếng Anh được 3 năm.',
          note: 'Hành động liên tục từ quá khứ đến hiện tại',
        ),
        GrammarExample(
          english: 'She has been waiting for you since 2 o\'clock.',
          vietnamese: 'Cô ấy đã đợi bạn từ 2 giờ.',
          note: 'Dùng với "since"',
        ),
        GrammarExample(
          english: 'They have been playing football all morning.',
          vietnamese: 'Họ đã chơi bóng đá cả buổi sáng.',
          note: 'Nhấn mạnh thời gian kéo dài',
        ),
      ],
      recognitionSigns: [
        'Động từ nằm trong cấu trúc have/has + been + V-ing',
        'Thường có các từ: for, since, all day/week/month, how long',
      ],
      commonMistakes: [
        '❌ I have been go → ✅ I have been going (Thiếu V-ing)',
        '❌ She has been works → ✅ She has been working (Sai dạng động từ)',
        '❌ They has been studying → ✅ They have been studying (Sai trợ động từ)',
        '❌ He have been sleep → ✅ He has been sleeping (Sai trợ động từ và thiếu -ing)',
      ],
      exercises: [
        GrammarExerciseItem(id: 'ex1_6_1', type: ExerciseType.multipleChoice, question: 'I _____ English for 5 years.', options: ['have been learning','has been learning','have learning','am learning'], correctAnswer: 'have been learning', explanation: 'have + been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_2', type: ExerciseType.multipleChoice, question: 'She _____ for the exam all week.', options: ['has been study','has been studying','have been studying','is studying'], correctAnswer: 'has been studying', explanation: 'has + been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_3', type: ExerciseType.multipleChoice, question: '_____ you _____ here long?', options: ['Have/been waiting','Has/been waiting','Do/wait','Are/waiting'], correctAnswer: 'Have/been waiting', explanation: 'Have + been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_4', type: ExerciseType.multipleChoice, question: 'They _____ football since morning.', options: ['have been play','have been playing','has been playing','are playing'], correctAnswer: 'have been playing', explanation: 'have + been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_5', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['I','have','been','learning','English'], correctAnswer: 'I have been learning English', explanation: 'Present Perfect Continuous'),
        GrammarExerciseItem(id: 'ex1_6_6', type: ExerciseType.dragAndDrop, question: 'Sắp xếp thành câu đúng:', wordBank: ['She','has','been','working','hard'], correctAnswer: 'She has been working hard', explanation: 'has + been + V-ing'),
        GrammarExerciseItem(id: 'ex1_6_7', type: ExerciseType.fillInBlank, question: 'We _____ (work) on this project for 2 months.', correctAnswer: 'have been working', explanation: 'have + been + V-ing'),
      ],
      order: 6,
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
