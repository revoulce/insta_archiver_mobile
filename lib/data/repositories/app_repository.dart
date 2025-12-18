import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_archiver_mobile/data/models/task_log_model.dart';
import 'package:insta_archiver_mobile/domain/repositories/i_repository.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IRepository)
class AppRepository implements IRepository {
  final Box settingsBox;
  final Box<TaskLogModel> historyBox;
  final Dio dio;

  AppRepository(
    @Named('SettingsBox') this.settingsBox,
    @Named('HistoryBox') this.historyBox,
    this.dio,
  );

  @override
  Map<String, String> getSettings() {
    return {
      'url':
          settingsBox.get('serverUrl', defaultValue: 'http://10.0.2.2:3000')
              as String,
      'secret': settingsBox.get('secretKey', defaultValue: '') as String,
    };
  }

  @override
  Future<void> saveSettings(String url, String secret) async {
    await settingsBox.put('serverUrl', url);
    await settingsBox.put('secretKey', secret);
  }

  @override
  Future<void> sendTask(String rawUrl) async {
    final settings = getSettings();
    final serverUrl = settings['url'];
    final secret = settings['secret'];

    final url = _extractUrl(rawUrl);

    if (serverUrl == null || serverUrl.isEmpty)
      throw Exception('Server URL not set');
    if (url == null) throw Exception('No valid URL found');

    try {
      await dio.post(
        '$serverUrl/api/v1/task',
        data: {'url': url},
        options: Options(headers: {'Authorization': secret}),
      );

      _addToHistory(url, 'success', 'Queued');
    } on DioException catch (e) {
      _addToHistory(url, 'error', e.message ?? 'Network Error');
      rethrow;
    } catch (e) {
      _addToHistory(url, 'error', e.toString());
      rethrow;
    }
  }

  void _addToHistory(String url, String status, String msg) {
    final log = TaskLogModel(
      id: const Uuid().v4(),
      url: url,
      status: status,
      message: msg,
      date: DateTime.now(),
    );
    historyBox.add(log);
  }

  @override
  List<TaskLogModel> getHistory() {
    return historyBox.values.toList().reversed.toList();
  }

  @override
  Future<void> clearHistory() async {
    await historyBox.clear();
  }

  String? _extractUrl(String text) {
    final RegExp exp = RegExp(
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
    );
    final match = exp.firstMatch(text);
    return match?.group(0);
  }
}
