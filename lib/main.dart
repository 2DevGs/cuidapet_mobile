import 'package:cuidapet_mobile/app/app_module.dart';
import 'package:cuidapet_mobile/app/app_widget.dart';
import 'package:cuidapet_mobile/app/core/application_config.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
void main() async {

  await ApplicationConfig().configureApp();
  
  runApp(ModularApp(
    module: AppModule(), 
    child: const AppWidget(),
  ));
}

