import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/rest_client.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
   @override
   Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home Page',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              TextButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                }, 
                child: const Text('LogOut'),
              ),
              TextButton(
                onPressed: () async {
                  final categoriesResponse = await Modular.get<RestClient>().auth().get('/categories/');
                  debugPrint(categoriesResponse.data);
                }, 
                child: const Text('Teste Refresh Token'),
              ),
            ],
          ),
       );
  }
}