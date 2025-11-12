// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Task Timer';

  @override
  String get tasks => 'Tasks';

  @override
  String get timer => 'Timer';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get createTask => 'Create Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get taskTitle => 'Title';

  @override
  String get taskDescription => 'Description';

  @override
  String get taskEstimatedTime => 'Estimated Time';

  @override
  String get taskPriority => 'Priority';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get start => 'Start';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get stop => 'Stop';

  @override
  String get complete => 'Complete';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String pomodoroMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String completedTasks(int count) {
    return 'Completed Tasks: $count';
  }

  @override
  String totalTime(int hours, int minutes) {
    return 'Total Time: ${hours}h ${minutes}m';
  }

  @override
  String get taskCompletedNotification => 'Task completed!';

  @override
  String get pomodoroCompletedNotification => 'Pomodoro completed! Break time.';

  @override
  String get noTasksFound => 'No tasks found';

  @override
  String get createFirstTask => 'Create your first task';

  @override
  String get deleteConfirmation => 'Are you sure you want to delete this task?';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidTime => 'Invalid time';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get vibration => 'Vibration';

  @override
  String get about => 'About';
}
