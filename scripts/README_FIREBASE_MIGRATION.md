# Grammar Data Migration to Firebase

## Tổng quan
Để tránh code dài trong `grammar_content_data.dart`, chúng ta sẽ lưu tất cả grammar lessons lên Firebase Firestore.

## Cấu trúc Firestore

### Collections:
1. **`grammar_categories`** - Các danh mục ngữ pháp
   - Document ID: category ID (vd: `cat_1`)
   - Fields: id, title, description, icon, color, order, lessonIds

2. **`grammar_lessons`** - Các bài học ngữ pháp
   - Document ID: lesson ID (vd: `lesson_1`)
   - Fields: id, categoryId, title, objective, theory, formulas, notes, usages, examples, recognitionSigns, commonMistakes, exercises, order

## Cách sử dụng

### Bước 1: Upload data lên Firebase (chỉ chạy 1 lần)

```bash
# Chạy script upload
cd d:\LAMTHUE\bee_grammar
dart scripts/upload_grammar_to_firebase.dart
```

Script sẽ upload:
- 5 categories (Các thì, Các loại câu, Các từ loại, Cấu trúc đặc biệt, Cấu trúc giao tiếp)
- 26 lessons (tất cả bài học hiện có)

### Bước 2: Sử dụng Firebase service trong app

Thay vì dùng `GrammarContentData.getAllLessons()`, dùng:

```dart
import 'package:bee_grammar/data/firebase_grammar_lesson_service.dart';

final service = FirebaseGrammarLessonService();

// Lấy tất cả categories
final categories = await service.getCategories();

// Lấy tất cả lessons
final lessons = await service.getLessons();

// Lấy lessons theo category
final tenseLessons = await service.getLessonsByCategory('cat_1');

// Lấy 1 lesson cụ thể
final lesson = await service.getLesson('lesson_1');
```

### Bước 3: Cập nhật UI để dùng Firebase data

Ví dụ trong `GrammarCategoriesScreen`:

```dart
// Thay vì:
final categories = GrammarContentData.getAllCategories();

// Dùng:
final service = FirebaseGrammarLessonService();
final categories = await service.getCategories();
```

## Lợi ích

✅ **Code ngắn gọn hơn** - Không cần hardcode 2000+ dòng data
✅ **Dễ cập nhật** - Chỉnh sửa trên Firebase Console thay vì rebuild app
✅ **Scalable** - Dễ thêm lessons mới mà không cần update code
✅ **Offline support** - Firestore tự động cache data
✅ **Real-time updates** - Có thể stream data nếu cần

## Lưu ý

- Lần đầu app sẽ cần internet để tải data
- Data sẽ được cache locally sau lần đầu
- Có thể giữ lại `grammar_content_data.dart` làm fallback nếu không có internet

## Firestore Rules

Thêm rules sau vào Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Grammar categories - public read
    match /grammar_categories/{categoryId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
    
    // Grammar lessons - public read
    match /grammar_lessons/{lessonId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
  }
}
```

## Tương lai

Có thể tạo admin panel để:
- Thêm/sửa/xóa lessons trực tiếp trên web
- Không cần rebuild app khi update content
- Quản lý content dễ dàng hơn
