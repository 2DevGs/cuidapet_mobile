import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/address/address_repository.dart';
import '../../repositories/address/address_repository_impl.dart';
import '../../services/address/address_service.dart';
import '../../services/address/address_service_impl.dart';

class CoreModule extends Module {

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i.addLazySingleton(SqliteConnectionFactory.new);
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new);
  }
  
}