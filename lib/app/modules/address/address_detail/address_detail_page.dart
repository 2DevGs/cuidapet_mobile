import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:mobx/mobx.dart';


class AddressDetailPage extends StatefulWidget {

  final PlaceModel place;

  const AddressDetailPage({
    super.key, 
    required this.place,
  });

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {

  final _additionalEC = TextEditingController();
  final controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressEntityDisposer;

  @override
  void initState() {
    super.initState();
    addressEntityDisposer = 
      reaction((_) => controller.addressEntity, (addressEntity) {
        if(addressEntity != null) {
          Navigator.pop(context, addressEntity);
        }
    });
  }

  @override
  void dispose() {
    _additionalEC.dispose();
    addressEntityDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: context.primaryColor,
            ),
          ),
           body: Column(
            children: [
              Text(
                'Confirme seu endereço',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                 height: 20,
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.place.lat,
                      widget.place.lng,
                    ),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('AddressID'),
                      position: LatLng(
                        widget.place.lat,
                        widget.place.lng,
                      ),
                      infoWindow: InfoWindow(
                        title: widget.place.address,
                      )
                    ),
                  },
                ),
              ),
              const SizedBox(
                 height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.place.address,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(widget.place);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _additionalEC,
                  decoration: InputDecoration(
                    labelText: 'Complemento',
                  ),
                ),
              ),
              SizedBox(
                width: .9.sw,
                height: 60.h,
                child: CuidapetDefaultButton(
                  label: 'Salvar', 
                  onPressed: (){
                    controller.saveAddress(widget.place, _additionalEC.text);
                  }
                ),
              ),
              const SizedBox(
                 height: 20,
              ),
            ],
           ),
       );
  }
}