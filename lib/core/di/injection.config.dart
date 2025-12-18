// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/models/task_log_model.dart' as _i847;
import '../../data/repositories/app_repository.dart' as _i932;
import '../../domain/repositories/i_repository.dart' as _i701;
import '../../presentation/blocs/history_cubit.dart' as _i557;
import '../../presentation/blocs/home_cubit.dart' as _i817;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    await gh.factoryAsync<_i979.Box<dynamic>>(
      () => registerModule.settingsBox,
      instanceName: 'SettingsBox',
      preResolve: true,
    );
    await gh.factoryAsync<_i979.Box<_i847.TaskLogModel>>(
      () => registerModule.historyBox,
      instanceName: 'HistoryBox',
      preResolve: true,
    );
    gh.lazySingleton<_i701.IRepository>(() => _i932.AppRepository(
          gh<_i979.Box<dynamic>>(instanceName: 'SettingsBox'),
          gh<_i979.Box<_i847.TaskLogModel>>(instanceName: 'HistoryBox'),
          gh<_i361.Dio>(),
        ));
    gh.factory<_i557.HistoryCubit>(
        () => _i557.HistoryCubit(gh<_i701.IRepository>()));
    gh.factory<_i817.HomeCubit>(() => _i817.HomeCubit(gh<_i701.IRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
