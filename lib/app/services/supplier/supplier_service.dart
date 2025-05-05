import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';

import '../../models/supplier_category_model.dart';

abstract class SupplierService {

  Future<List<SupplierCategoryModel>> getCategories();

  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address);

}