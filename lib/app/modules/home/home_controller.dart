import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';

import '../../services/supplier/supplier_service.dart';

part 'home_controller.g.dart';

enum SupplierPageType { list, grid }

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {

  final AddressService _addressService;
  final SupplierService _supplierService;

  @readonly
  AddressEntity? _addressEntity;

  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  @readonly
  var _supplierPageTypeSelected = SupplierPageType.list;

  @readonly
  var _listSuppliersByAddress = <SupplierNearbyMeModel>[];

  var _listSuppliersByAddressCache = <SupplierNearbyMeModel>[];

  var _nameSearchText = '';

  @readonly
  SupplierCategoryModel? _supplierCategoryFilterSelected;

  late ReactionDisposer findSuppliersReactionDisposer;

  HomeControllerBase({
    required AddressService addressService,
    required SupplierService supplierService,
  }) : _addressService = addressService,
       _supplierService = supplierService;

  @override
  void onInit([Map<String, dynamic>? params]) {
    findSuppliersReactionDisposer = reaction((_) => _addressEntity, (address) {
      findSupplierByAddress();
    });
  }

  @override
  void dispose() {
    findSuppliersReactionDisposer();
  }

  @override
  Future<void> onReady() async {
    try {
      Loader.show();
      await _getAddressSelected();
      await _getCategories();
      
    } finally {
      Loader.hide();

    }
  }

  @action
  Future<void> _getAddressSelected() async {
    _addressEntity ??= await _addressService.getAddressSelected();
    
    if(_addressEntity == null) {
      await goToAdrressPage();
    }
  }

  @action
  Future<void> goToAdrressPage() async {
    final address = await Modular.to.pushNamed<AddressEntity>('/address/');
    if(address != null) {
    _addressEntity = address;
    }  
  }

  @action
  Future<void> _getCategories() async {
    try {
      final categories = await _supplierService.getCategories();
      _listCategories = [...categories];
    }  catch (e) {
      Messages.alert('Erro ao buscar as categorias.');
      throw Exception();
    }
  }

  @action
  void changeTabSupplier(SupplierPageType supplierPageType) {
    _supplierPageTypeSelected = supplierPageType;
  }

  Future<void> findSupplierByAddress() async {
    if(_addressEntity != null) {
      final suppliers =  await _supplierService.findNearBy(_addressEntity!);
      _listSuppliersByAddress = [...suppliers];
      _listSuppliersByAddressCache = [...suppliers];
      filterSupplier();
    } else {
      Messages.alert('Para realizar a busca de PetShops você precisa selecionar um endereço');
    }
  }

  @action
  void filterSupplierCategory(SupplierCategoryModel category) {
    if(_supplierCategoryFilterSelected == category){
    _supplierCategoryFilterSelected = null;
    } else {
    _supplierCategoryFilterSelected = category;
    }
    filterSupplier();
  }

  void filterSupplierByName(String name){
    _nameSearchText = name;
    filterSupplier();
  }

  @action
  void filterSupplier(){

    var suppliers = [..._listSuppliersByAddressCache];
    
    if(_supplierCategoryFilterSelected != null) {
    suppliers = suppliers
        .where((supplier) => 
            supplier.category == _supplierCategoryFilterSelected?.id)
        .toList();
    }
    if(_nameSearchText.isNotEmpty){
      suppliers = suppliers
          .where((supplier) => supplier.name.toLowerCase()
          .contains(_nameSearchText.toLowerCase()))
          .toList();
    }

      _listSuppliersByAddress = [...suppliers];
  }

}
