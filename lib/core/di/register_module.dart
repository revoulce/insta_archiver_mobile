import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_archiver_mobile/data/models/task_log_model.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @preResolve
  @Named('SettingsBox')
  Future<Box> get settingsBox async => await Hive.openBox('settings');

  @preResolve
  @Named('HistoryBox')
  Future<Box<TaskLogModel>> get historyBox async =>
      await Hive.openBox<TaskLogModel>('history');
}
