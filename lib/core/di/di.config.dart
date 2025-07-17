// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/data/data_sources/auth_remote_data_source_impl.dart'
    as _i104;
import '../../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i317;
import '../../features/authentication/domain/repositories/auth_data_source_contract/auth_remote_data_source.dart'
    as _i261;
import '../../features/authentication/domain/repositories/auth_repositories/auth_repository_contract.dart'
    as _i733;
import '../../features/authentication/domain/usecases/register_use_case.dart'
    as _i377;
import '../../features/authentication/presentation/cubit/register_view_model.dart'
    as _i128;
import '../Api/api_manager.dart' as _i1039;
import '../providers/app_config_provider.dart' as _i56;
import 'modules/dio_module.dart' as _i983;
import 'modules/shared_preferences_module.dart' as _i813;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.singleton<_i1039.ApiManager>(() => _i1039.ApiManager());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => dioModule.providePrettyDioLogger(),
    );
    gh.factory<_i261.AuthRemoteDataSource>(
      () => _i104.AuthRemoteDataSourceImpl(apiManager: gh<_i1039.ApiManager>()),
    );
    gh.factory<_i733.AuthRepositoryContract>(
      () => _i317.AuthRepositoryImpl(gh<_i261.AuthRemoteDataSource>()),
    );
    gh.factory<_i377.RegisterUseCase>(
      () => _i377.RegisterUseCase(gh<_i733.AuthRepositoryContract>()),
    );
    gh.singleton<_i56.AppConfigProvider>(
      () => _i56.AppConfigProvider(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i128.RegisterViewModel>(
      () => _i128.RegisterViewModel(gh<_i377.RegisterUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i813.SharedPreferencesModule {}

class _$DioModule extends _i983.DioModule {}
