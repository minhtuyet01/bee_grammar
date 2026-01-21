const admin = require('firebase-admin');
const fs = require('fs');

// Đọc service account key
// Download từ: Firebase Console → Project Settings → Service Accounts → Generate new private key
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// User ID thực từ Firebase Authentication
const USER_ID = 'trBrhxPdjXSPQzkrJMsdlJvHX493';

const sampleData = [
  {
    userId: USER_ID,
    lessonId: 'cat1_present_simple',
    lessonTitle: 'Thì Hiện Tại Đơn',
    categoryId: 'cat_1',
    categoryTitle: 'I. Các Thì Trong Tiếng Anh',
    completedAt: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 2 * 24 * 60 * 60 * 1000)),
    score: 85,
    correctAnswers: 17,
    totalQuestions: 20,
    timeSpent: 180,
  },
  {
    userId: USER_ID,
    lessonId: 'cat2_conditional_type1',
    lessonTitle: 'Câu Điều Kiện Loại 1',
    categoryId: 'cat_2',
    categoryTitle: 'II. Cấu Trúc Câu Trong Tiếng Anh',
    completedAt: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 1 * 24 * 60 * 60 * 1000)),
    score: 90,
    correctAnswers: 18,
    totalQuestions: 20,
    timeSpent: 150,
  },
  {
    userId: USER_ID,
    lessonId: 'cat3_noun',
    lessonTitle: 'Danh Từ',
    categoryId: 'cat_3',
    categoryTitle: 'III. Các Từ Loại',
    completedAt: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 5 * 60 * 60 * 1000)),
    score: 75,
    correctAnswers: 15,
    totalQuestions: 20,
    timeSpent: 200,
  },
  {
    userId: USER_ID,
    lessonId: 'cat4_wh_questions',
    lessonTitle: 'Câu Hỏi Wh-',
    categoryId: 'cat_4',
    categoryTitle: 'IV. Các Dạng Câu Hỏi',
    completedAt: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 2 * 60 * 60 * 1000)),
    score: 80,
    correctAnswers: 16,
    totalQuestions: 20,
    timeSpent: 170,
  },
  {
    userId: USER_ID,
    lessonId: 'cat5_basic_structure',
    lessonTitle: 'Cấu Trúc Câu Cơ Bản',
    categoryId: 'cat_5',
    categoryTitle: 'V. Cấu Trúc Ngữ Pháp Tiếng Anh Cơ Bản',
    completedAt: admin.firestore.Timestamp.now(),
    score: 95,
    correctAnswers: 19,
    totalQuestions: 20,
    timeSpent: 160,
  },
];

async function importData() {
  console.log('🚀 Starting import...');

  const batch = db.batch();

  sampleData.forEach((item, index) => {
    const docId = `${item.userId}_${item.lessonId}_${Date.now() + index}`;
    const docRef = db.collection('learning_history').doc(docId);
    batch.set(docRef, item);
    console.log(`📝 Preparing: ${item.lessonTitle}`);
  });

  await batch.commit();
  console.log('✅ Import thành công! Đã tạo', sampleData.length, 'records.');
  process.exit(0);
}

importData().catch(error => {
  console.error('❌ Lỗi:', error);
  process.exit(1);
});
