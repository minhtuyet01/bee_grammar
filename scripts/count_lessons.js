const admin = require('firebase-admin');

const serviceAccount = require('./serviceAccountKey.json');

if (!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });
}

const db = admin.firestore();

async function countLessonsByCategory() {
    console.log('📊 Counting lessons by category...\n');

    const lessonsSnapshot = await db.collection('grammar_lessons').get();

    const categoryCounts = {
        'cat_1': 0,
        'cat_2': 0,
        'cat_3': 0,
        'cat_4': 0,
        'cat_5': 0,
    };

    lessonsSnapshot.forEach(doc => {
        const data = doc.data();
        const categoryId = data.categoryId;
        if (categoryCounts.hasOwnProperty(categoryId)) {
            categoryCounts[categoryId]++;
        }
    });

    console.log('Category lesson counts:');
    console.log('cat_1 (I. Các Thì Trong Tiếng Anh):', categoryCounts['cat_1']);
    console.log('cat_2 (II. Cấu Trúc Câu Trong Tiếng Anh):', categoryCounts['cat_2']);
    console.log('cat_3 (III. Các Từ Loại):', categoryCounts['cat_3']);
    console.log('cat_4 (IV. Các Dạng Câu Hỏi):', categoryCounts['cat_4']);
    console.log('cat_5 (V. Cấu Trúc Ngữ Pháp Tiếng Anh Cơ Bản):', categoryCounts['cat_5']);
    console.log('\nTotal lessons:', lessonsSnapshot.size);

    process.exit(0);
}

countLessonsByCategory().catch(error => {
    console.error('❌ Error:', error);
    process.exit(1);
});
