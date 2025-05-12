
import 'package:cuidapet_mobile/app/modules/address/address_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/auth_module.dart';
import 'package:cuidapet_mobile/app/modules/core/core_module.dart';
import 'package:cuidapet_mobile/app/modules/home/home_module.dart';
import 'package:cuidapet_mobile/app/modules/schedules/schedules_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
  }

  @override
  List<Module> get imports => [
    CoreModule(),
  ];
  

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/address', module: AddressModule());
    r.module('/supplier', module: SupplierModule());
    r.module('/schedules', module: SchedulesModule());
    super.routes(r);
  }
}