import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:cuidapet_mobile/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {

  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);
    i.addLazySingleton<UserService>(UserServiceImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(FlutterSecureStorageLocalStorageImpl.new);
    i.addLazySingleton<SocialRepository>(SocialRepositoryImpl.new);
  }
  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => AuthHomePage(authStore: Modular.get<AuthStore>(),));
    r.module('/login', module: LoginModule());
    r.module('/register', module: RegisterModule());
    super.routes(r);
  }

}