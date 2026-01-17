// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'BeeGrammar';

  @override
  String get home => 'Trang chủ';

  @override
  String get leaderboard => 'Bảng xếp hạng';

  @override
  String get tasks => 'Nhiệm vụ';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get logoutConfirm => 'Bạn có chắc chắn muốn đăng xuất?';

  @override
  String get cancel => 'Hủy';

  @override
  String get streak => 'Chuỗi';

  @override
  String get points => 'Điểm';

  @override
  String get diamonds => 'Kim cương';

  @override
  String get day => 'ngày';

  @override
  String get days => 'ngày';

  @override
  String get notifications => 'Thông báo';

  @override
  String get notificationSettings => 'Quản lý thông báo';

  @override
  String get enableAllNotifications => 'Bật tất cả thông báo';

  @override
  String get receiveAllNotifications => 'Nhận tất cả thông báo từ ứng dụng';

  @override
  String get disableAllNotifications => 'Tắt tất cả thông báo';

  @override
  String get learningSection => 'Học tập';

  @override
  String get learningReminders => 'Nhắc nhở học tập';

  @override
  String get learningRemindersDesc =>
      'Nhận nhắc nhở hàng ngày để duy trì chuỗi học';

  @override
  String get newContent => 'Nội dung mới';

  @override
  String get newContentDesc => 'Thông báo khi có bài học hoặc chủ đề mới';

  @override
  String get progressSection => 'Tiến độ & Thành tích';

  @override
  String get newAchievements => 'Thành tích mới';

  @override
  String get newAchievementsDesc =>
      'Thông báo khi đạt được thành tích hoặc huy hiệu';

  @override
  String get quizResults => 'Kết quả quiz';

  @override
  String get quizResultsDesc => 'Nhận thông báo về điểm số và đánh giá';

  @override
  String get leaderboardUpdates => 'Cập nhật bảng xếp hạng';

  @override
  String get leaderboardUpdatesDesc =>
      'Thông báo khi thứ hạng của bạn thay đổi';

  @override
  String get systemSection => 'Hệ thống';

  @override
  String get appUpdates => 'Cập nhật ứng dụng';

  @override
  String get appUpdatesDesc => 'Thông báo về phiên bản mới và tính năng';

  @override
  String get settingsSaved => '✅ Đã lưu cài đặt thông báo';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageSettings => 'Cài đặt ngôn ngữ';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ hiển thị';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'English';

  @override
  String languageChanged(String language) {
    return '✅ Đã chuyển sang $language';
  }

  @override
  String get languageChangeInfo =>
      'Thay đổi ngôn ngữ sẽ áp dụng cho toàn bộ ứng dụng. Một số nội dung học tập vẫn giữ nguyên ngôn ngữ gốc.';

  @override
  String get personalInfo => 'Thông tin cá nhân';

  @override
  String get personalInfoDesc => 'Xem và chỉnh sửa thông tin';

  @override
  String get changePassword => 'Đổi mật khẩu';

  @override
  String get changePasswordDesc => 'Cập nhật mật khẩu của bạn';

  @override
  String get achievements => 'Thành tích';

  @override
  String get achievementsDesc => 'Xem các thành tích đã đạt được';

  @override
  String get learningHistory => 'Lịch sử học tập';

  @override
  String get learningHistoryDesc => 'Xem các bài đã học';

  @override
  String get savedLessons => 'Bài học đã lưu';

  @override
  String get savedLessonsDesc => 'Danh sách bài học yêu thích';

  @override
  String get statistics => 'Thống kê';

  @override
  String get statisticsDesc => 'Xem tiến độ học tập';

  @override
  String get helpSupport => 'Trợ giúp & Hỗ trợ';

  @override
  String get helpSupportDesc => 'Câu hỏi thường gặp';

  @override
  String get featureInDevelopment => 'Tính năng đang phát triển';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get lightMode => 'Chế độ sáng';

  @override
  String get theme => 'Giao diện';

  @override
  String get settings => 'Cài đặt';

  @override
  String get account => 'Tài khoản';

  @override
  String get general => 'Chung';

  @override
  String get todayTasks => 'Nhiệm vụ hôm nay';

  @override
  String get completedTasks => 'Đã hoàn thành';

  @override
  String get pendingTasks => 'Đang chờ';

  @override
  String get allTasks => 'Tất cả nhiệm vụ';

  @override
  String get dailyTasks => 'Nhiệm vụ hàng ngày';

  @override
  String get weeklyTasks => 'Nhiệm vụ hàng tuần';

  @override
  String get specialTasks => 'Nhiệm vụ đặc biệt';

  @override
  String get taskCompleted => 'Hoàn thành nhiệm vụ!';

  @override
  String get reward => 'Phần thưởng';

  @override
  String get complete => 'Hoàn thành';

  @override
  String get completed => 'Đã hoàn thành';

  @override
  String get topLearners => 'Người học xuất sắc';

  @override
  String get thisWeek => 'Tuần này';

  @override
  String get thisMonth => 'Tháng này';

  @override
  String get allTime => 'Mọi lúc';

  @override
  String get rank => 'Hạng';

  @override
  String get you => 'Bạn';

  @override
  String get level => 'Cấp độ';

  @override
  String get continueStreak => 'Duy trì chuỗi học!';

  @override
  String daysStreak(int count) {
    return 'Chuỗi $count ngày';
  }

  @override
  String get quickActions => 'Hành động nhanh';

  @override
  String get startLesson => 'Bắt đầu bài học';

  @override
  String get practiceGrammar => 'Luyện ngữ pháp';

  @override
  String get listeningPractice => 'Luyện nghe';

  @override
  String get yourProgress => 'Tiến độ của bạn';

  @override
  String get lessonsCompleted => 'Bài học đã hoàn thành';

  @override
  String get accuracy => 'Độ chính xác';

  @override
  String get studyTime => 'Thời gian học';

  @override
  String get minutes => 'phút';
}
