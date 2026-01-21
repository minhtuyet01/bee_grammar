const admin = require('firebase-admin');

// Sử dụng service account key đã có
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// User ID thực từ Firebase Authentication
const USER_ID = 'trBrhxPdjXSPQzkrJMsdlJvHX493';

const sampleStatistics = {
    totalLessonsCompleted: 5,
    totalExercisesCompleted: 100,
    totalCorrectAnswers: 85,
    totalQuestions: 100,
    averageScore: 85,
    totalTimeSpent: 860, // seconds
    lastUpdated: admin.firestore.Timestamp.now(),
    categoriesProgress: {
        'cat_1': {
            completed: 1,
            totalQuestions: 20,
            correctAnswers: 17,
            averageScore: 85,
            lastCompleted: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 2 * 24 * 60 * 60 * 1000))
        },
        'cat_2': {
            completed: 1,
            totalQuestions: 20,
            correctAnswers: 18,
            averageScore: 90,
            lastCompleted: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 1 * 24 * 60 * 60 * 1000))
        },
        'cat_3': {
            completed: 1,
            totalQuestions: 20,
            correctAnswers: 15,
            averageScore: 75,
            lastCompleted: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 5 * 60 * 60 * 1000))
        },
        'cat_4': {
            completed: 1,
            totalQuestions: 20,
            correctAnswers: 16,
            averageScore: 80,
            lastCompleted: admin.firestore.Timestamp.fromDate(new Date(Date.now() - 2 * 60 * 60 * 1000))
        },
        'cat_5': {
            completed: 1,
            totalQuestions: 20,
            correctAnswers: 19,
            averageScore: 95,
            lastCompleted: admin.firestore.Timestamp.now()
        }
    }
};

async function importStatistics() {
    console.log('🚀 Starting statistics import...');

    try {
        await db.collection('user_statistics').doc(USER_ID).set(sampleStatistics);
        console.log('✅ Import thành công!');
        console.log('📊 Statistics summary:');
        console.log('   - Total lessons: 5');
        console.log('   - Average score: 85%');
        console.log('   - Categories: 5 (cat_1 to cat_5)');
        console.log('');
        console.log('⚠️  User ID:', USER_ID);
        console.log('   Nhớ thay bằng UID thực nếu cần!');
        process.exit(0);
    } catch (error) {
        console.error('❌ Lỗi:', error);
        process.exit(1);
    }
}

importStatistics();
