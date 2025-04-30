
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';

class AddressModule extends Module {

  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(AddressSearchController.new); 
    i.addLazySingleton(AddressController.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new); //CoreModule
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new); //CoreModule
    i.addLazySingleton(SqliteConnectionFactory.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (_) => const AddressPage());
    r.module('/detail/', module: AddressDetailModule());
  }

}