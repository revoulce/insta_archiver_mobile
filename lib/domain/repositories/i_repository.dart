import 'package:insta_archiver_mobile/data/models/task_log_model.dart';

abstract class IRepository {
  // Settings
  Future<void> saveSettings(String url, String secret);

  Map<String, String> getSettings();

  // Tasks
  Future<void> sendTask(String url);

  // History
  List<TaskLogModel> getHistory();

  Future<void> clearHistory();
}
