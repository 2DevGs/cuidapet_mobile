import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/home_page.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/address/address_repository.dart';
import '../../services/address/address_service.dart';

class HomeModule extends Module {

   @override
  void binds(Injector i) {
    i.addSingleton<HomeController>(HomeController.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
  }

  @override
  List<Module> get imports => [
    SupplierCoreModule(),
  ];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const HomePage());
  }

}