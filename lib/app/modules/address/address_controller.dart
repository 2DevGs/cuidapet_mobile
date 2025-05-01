import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

import '../../services/address/address_service.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {

  final AddressService _addressService;

  @readonly
  var _addresses = <AddressEntity>[];

  @readonly
  var _locationServiceUnavaliable = false;

  @readonly
  PermissionStatus? _permissionStatus;

  @readonly
  PlaceModel? _placeModel;

  AddressControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _addresses = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {
    
    _permissionStatus = null;
    _locationServiceUnavaliable = false;

    Location location = Location();

    final serviceEnable = await location.serviceEnabled();

    if(!serviceEnable){
      _locationServiceUnavaliable = true; 
      return;
    }

    final locationPermission = await location.hasPermission();

    switch(locationPermission){

      case PermissionStatus.denied:

        final permission = await location.requestPermission();
        if(permission == PermissionStatus.denied || permission == PermissionStatus.deniedForever) {
          _permissionStatus = permission;
          return;
        }
        break;
      case PermissionStatus.deniedForever:
          _permissionStatus = locationPermission;
        break;

      case PermissionStatus.granted:
      case PermissionStatus.grantedLimited:
        break; 
    }
    Loader.show();
    
    final position = await location.getLocation();
    final placemark = 
      await geocoding.placemarkFromCoordinates(position.latitude!, position.longitude!);
    //     await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);

    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
      address: address, lat: position.latitude!, lng: position.longitude!);
    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address = await Modular.to.pushNamed('/address/detail/', arguments: place);

    if(address is PlaceModel) { // Quer dizer que estou editando um endereço enviado.
      _placeModel = address;
    } else if(address is AddressEntity) { // Quer dizer que salvou um endereço
      selectAddress(address);
    }

  }

  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _addressService.selectAddress(addressEntity);
    Modular.to.pop(addressEntity);
  }

  Future<bool> addressWasSelected() async {
    final address = await _addressService.getAddressSelected();

    if(address != null) {
      return true;
    } else {
      Messages.alert('Por favor selecione ou cadastre um endereço');
      return false;
    }
  }

}
