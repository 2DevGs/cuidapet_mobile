import 'package:cuidapet_mobile/app/modules/schedules/schedules_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';

class SchedulesModule extends Module {

   @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SchedulesPage());
  }

}