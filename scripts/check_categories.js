const admin = require('firebase-admin');

const serviceAccount = require('./serviceAccountKey.json');

if (!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });
}

const db = admin.firestore();

async function checkAllCollections() {
    console.log('🔍 Checking grammar collections...\n');

    // Check grammar_categories
    console.log('📁 grammar_categories:');
    const categoriesSnapshot = await db.collection('grammar_categories').get();
    if (categoriesSnapshot.empty) {
        console.log('   (Empty)');
    } else {
        categoriesSnapshot.forEach(doc => {
            const data = doc.data();
            console.log(`   - ID: ${doc.id}`);
            console.log(`     Title: ${data.title || 'N/A'}`);
        });
    }

    // Check grammar_lessons
    console.log('\n📁 grammar_lessons (first 5):');
    const lessonsSnapshot = await db.collection('grammar_lessons').limit(5).get();
    if (lessonsSnapshot.empty) {
        console.log('   (Empty)');
    } else {
        lessonsSnapshot.forEach(doc => {
            const data = doc.data();
            console.log(`   - ID: ${doc.id}`);
            console.log(`     Title: ${data.title || 'N/A'}`);
            console.log(`     CategoryID: ${data.categoryId || 'N/A'}`);
        });
    }

    process.exit(0);
}

checkAllCollections().catch(error => {
    console.error('❌ Error:', error);
    process.exit(1);
});
