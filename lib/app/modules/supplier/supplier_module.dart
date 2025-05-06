
import 'package:cuidapet_mobile/app/modules/supplier/supplier_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierModule extends Module {

@override
  void routes(RouteManager r) {
    r.child('/', child: (context) => SupplierPage());
  }

}