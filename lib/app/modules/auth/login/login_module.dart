import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_page.dart';
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
import '../../../core/rest_client/dio/dio_rest_client.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../core/auth/auth_store.dart';

class LoginModule extends Module {

   @override
  void binds(Injector i) {
    i.addLazySingleton(LoginController.new);
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<UserService>(UserServiceImpl.new);
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new); 
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new); 
    i.addLazySingleton<SocialRepository>(SocialRepositoryImpl.new);
  }

   @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => LoginPage()); 
  }

}