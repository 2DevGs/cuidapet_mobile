import 'package:cuidapet_mobile/app/models/place_model.dart';

import '../../entities/address_entity.dart';

abstract class AddressRepository {

  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);

  Future<List<AddressEntity>> getAddress();

  Future<int> saveAddress(AddressEntity entity); 
   
  Future<void> deleteAll();

}