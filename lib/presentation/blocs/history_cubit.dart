import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_archiver_mobile/data/models/task_log_model.dart';
import 'package:insta_archiver_mobile/domain/repositories/i_repository.dart';

@injectable
class HistoryCubit extends Cubit<List<TaskLogModel>> {
  final IRepository repository;

  HistoryCubit(this.repository) : super([]) {
    loadHistory();
  }

  void loadHistory() {
    emit(repository.getHistory());
  }

  void clearHistory() {
    repository.clearHistory();
    loadHistory();
  }
}
