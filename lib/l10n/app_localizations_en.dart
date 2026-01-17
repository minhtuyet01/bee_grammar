// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BeeGrammar';

  @override
  String get home => 'Home';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get tasks => 'Tasks';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get streak => 'Streak';

  @override
  String get points => 'Points';

  @override
  String get diamonds => 'Diamonds';

  @override
  String get day => 'day';

  @override
  String get days => 'days';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get enableAllNotifications => 'Enable all notifications';

  @override
  String get receiveAllNotifications =>
      'Receive all notifications from the app';

  @override
  String get disableAllNotifications => 'Disable all notifications';

  @override
  String get learningSection => 'Learning';

  @override
  String get learningReminders => 'Learning reminders';

  @override
  String get learningRemindersDesc => 'Daily reminders to maintain your streak';

  @override
  String get newContent => 'New content';

  @override
  String get newContentDesc =>
      'Notify when new lessons or topics are available';

  @override
  String get progressSection => 'Progress & Achievements';

  @override
  String get newAchievements => 'New achievements';

  @override
  String get newAchievementsDesc =>
      'Notify when you earn achievements or badges';

  @override
  String get quizResults => 'Quiz results';

  @override
  String get quizResultsDesc =>
      'Receive notifications about scores and reviews';

  @override
  String get leaderboardUpdates => 'Leaderboard updates';

  @override
  String get leaderboardUpdatesDesc => 'Notify when your rank changes';

  @override
  String get systemSection => 'System';

  @override
  String get appUpdates => 'App updates';

  @override
  String get appUpdatesDesc => 'Notifications about new versions and features';

  @override
  String get settingsSaved => '✅ Settings saved';

  @override
  String get language => 'Language';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get selectLanguage => 'Select display language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String languageChanged(String language) {
    return '✅ Changed to $language';
  }

  @override
  String get languageChangeInfo =>
      'Language changes will apply to the entire app. Some learning content will remain in the original language.';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get personalInfoDesc => 'View and edit your information';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordDesc => 'Update your password';

  @override
  String get achievements => 'Achievements';

  @override
  String get achievementsDesc => 'View your earned achievements';

  @override
  String get learningHistory => 'Learning History';

  @override
  String get learningHistoryDesc => 'View completed lessons';

  @override
  String get savedLessons => 'Saved Lessons';

  @override
  String get savedLessonsDesc => 'Your favorite lessons';

  @override
  String get statistics => 'Statistics';

  @override
  String get statisticsDesc => 'View your learning progress';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get helpSupportDesc => 'Frequently asked questions';

  @override
  String get featureInDevelopment => 'Feature in development';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get theme => 'Theme';

  @override
  String get settings => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get general => 'General';

  @override
  String get todayTasks => 'Today\'s Tasks';

  @override
  String get completedTasks => 'Completed';

  @override
  String get pendingTasks => 'Pending';

  @override
  String get allTasks => 'All Tasks';

  @override
  String get dailyTasks => 'Daily Tasks';

  @override
  String get weeklyTasks => 'Weekly Tasks';

  @override
  String get specialTasks => 'Special Tasks';

  @override
  String get taskCompleted => 'Task completed!';

  @override
  String get reward => 'Reward';

  @override
  String get complete => 'Complete';

  @override
  String get completed => 'Completed';

  @override
  String get topLearners => 'Top Learners';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get allTime => 'All Time';

  @override
  String get rank => 'Rank';

  @override
  String get you => 'You';

  @override
  String get level => 'Level';

  @override
  String get continueStreak => 'Continue your streak!';

  @override
  String daysStreak(int count) {
    return '$count days streak';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get startLesson => 'Start Lesson';

  @override
  String get practiceGrammar => 'Practice Grammar';

  @override
  String get listeningPractice => 'Listening Practice';

  @override
  String get yourProgress => 'Your Progress';

  @override
  String get lessonsCompleted => 'Lessons Completed';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get studyTime => 'Study Time';

  @override
  String get minutes => 'minutes';
}
