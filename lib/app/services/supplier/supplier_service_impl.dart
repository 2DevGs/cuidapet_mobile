import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';

import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';

import '../../repositories/supplier/supplier_repository.dart';
import '../../models/supplier_category_model.dart';
import './supplier_service.dart';

class SupplierServiceImpl implements SupplierService {

  final SupplierRepository _repository;

  SupplierServiceImpl({
    required SupplierRepository supplierRepository,
  }) : _repository = supplierRepository;
  

  @override
  Future<List<SupplierCategoryModel>> getCategories() => 
      _repository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) => 
      _repository.findNearBy(address);

  @override
  Future<SupplierModel> findById(int id) => 
      _repository.findById(id);

  @override
  Future<List<SupplierServicesModel>> findServices(int supplierId) => 
      _repository.findServices(supplierId);

}
