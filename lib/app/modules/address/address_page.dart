import 'dart:async';
import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/mixins/location_mixin.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'widgets/address_search_widget/address_search_controller.dart';
part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {

  const AddressPage({ super.key });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends PageLifeCycleState<AddressController, AddressPage> with LocationMixin {

  final reactionDisposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    final reactionService = reaction<bool>((_) => controller.locationServiceUnavaliable, 
        (locationServiceUnavaliable) {
          if(locationServiceUnavaliable){
            showDialogLocationServiceUnavailable();
          }
        });
    final reactionLocationPermission = reaction<PermissionStatus?>((_) => controller.permissionStatus, 
        (permissionStatus) {
          if(permissionStatus != null && permissionStatus == PermissionStatus.denied) {
            showDialogLocationDenied(() => controller.myLocation());
          } else if(permissionStatus != null && permissionStatus == PermissionStatus.deniedForever) {
            showDialogLocationDeniedForever();
          }
        });

    reactionDisposers.addAll([reactionService,reactionLocationPermission]);
  }

  @override
  void dispose() {
    for (var reaction in reactionDisposers) {
      reaction();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<SqliteConnectionFactory>().openConnection();
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: context.primaryColorDark),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Text(
                    'Adicione ou escolha um endereço',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  _AddressSearchWidget(
                    addressSelectedCallback: (place) {
                      controller.goToAddressDetail(place);
                    },
                  ),
                  const SizedBox(
                    height: 30
                  ),
                  ListTile(
                    onTap: () => controller.myLocation(),
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: Icon(Icons.near_me, color: Colors.white,),
                    ),
                    title: Text(
                      'Localização Atual',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                     height: 20,
                  ),
                  Observer(
                    builder: (_) {
                      return Column(
                        children: controller.addresses
                            .map((a) => _ItemTile(address: a.address))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
       );
  }
}