
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/rest_client/dio/dio_rest_client.dart';

class SupplierCoreModule extends Module {

  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<SupplierRepository>(SupplierRepositoryImpl.new);
    i.addLazySingleton<SupplierService>(SupplierServiceImpl.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
  }

}