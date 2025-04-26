
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_page.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/database/sqlite_connection_factory.dart';

class AddressDetailModule extends Module {

  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(AddressDetailController.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (context) => AddressDetailPage(place: r.args.data,),);
  }

}
