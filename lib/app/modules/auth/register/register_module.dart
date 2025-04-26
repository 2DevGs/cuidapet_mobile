import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_page.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:cuidapet_mobile/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';

class RegisterModule extends Module {

@override
  void binds(Injector i) {
    i.addLazySingleton<RegisterController>(RegisterController.new);
    i.addLazySingleton<UserService>(UserServiceImpl.new);  //AuthModule
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);  //CoreModule
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new); 
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new); 
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<SocialRepository>(SocialRepositoryImpl.new);
  }

   @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const RegisterPage());
    super.routes(r);
  }

}