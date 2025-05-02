import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/widgets/home_appbar.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/rest_client.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {

  AddressEntity? addressEntity;

   @override
   Widget build(BuildContext context) {
      return Scaffold(
        drawer: const Drawer(),
        backgroundColor: Colors.grey[100],
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                HomeAppBar(),
              ];
            },
            body: Container(),
          ),
       );
  }
}