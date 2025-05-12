import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:mobx/mobx.dart';
part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle{

  final SupplierService _supplierService;
  final AppLogger _log;

  int _supplierID = 0;

  @readonly
  SupplierModel? _supplierModel;

  @readonly
  var _supplierServices = <SupplierServicesModel>[];

  @readonly
  var _servicesSelected = <SupplierServicesModel>[].asObservable();

  SupplierControllerBase({
    required SupplierService supplierService,
    required AppLogger log,
  }) : _supplierService = supplierService,
       _log = log;

  @override
  void onInit([Map<String, dynamic>? params]) {

      _supplierID = params?['supplierId'] ?? 0;
    
  }

  @override
  Future<void> onReady() async {
    try {
      Loader.show();
      await Future.wait([
        _findSupplierById(),
        _findSupplierServices(),
      ]);
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> _findSupplierById() async {
    try {
      _supplierModel = await _supplierService.findById(_supplierID);
    }  catch (e, s) {
      final message = 'Erro ao buscar dados do fornecedor';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @action
  Future<void> _findSupplierServices() async {
    try {
      _supplierServices = await _supplierService.findServices(_supplierID);
    }  catch (e, s) {
      final message = 'Erro ao buscar serviços do fornecedor';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @action
  void addOrRemoveService(SupplierServicesModel supplierServiceModel) {
    if(_servicesSelected.contains(supplierServiceModel)) {
      _servicesSelected.remove(supplierServiceModel);
    } else {
      _servicesSelected.add(supplierServiceModel);
    }
  }

  bool isServiceSelected(SupplierServicesModel servicesModel) => 
      _servicesSelected.contains(servicesModel);

  int get totalServicesSelected => _servicesSelected.length;

}