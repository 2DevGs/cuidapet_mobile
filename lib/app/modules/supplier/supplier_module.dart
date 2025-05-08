
import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_page.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierModule extends Module {

  @override
  void binds(Injector i) {
    i.addLazySingleton(SupplierController.new);
    i.addLazySingleton<SupplierService>(SupplierServiceImpl.new);
    i.addLazySingleton<SupplierRepository>(SupplierRepositoryImpl.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new);
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
  }

  @override
  List<Module> get imports => [
    SupplierCoreModule(),
  ];

@override
  void routes(RouteManager r) {
    r.child('/', child: (context) => SupplierPage(
      supplierId: r.args.data,
    ));
  }

}