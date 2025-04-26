import 'package:cuidapet_mobile/app/models/place_model.dart';
import '../../entities/address_entity.dart';

abstract class AddressService {

  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);

  Future<List<AddressEntity>> getAddress();

  Future<void> deleteAll();
   
  Future<AddressEntity> saveAddress(PlaceModel placeModel, String additional); 
  
}