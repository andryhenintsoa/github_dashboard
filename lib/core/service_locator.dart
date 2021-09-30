import 'package:get_it/get_it.dart';
import 'package:github_dashboard/core/service/api.dart';
import 'package:github_dashboard/core/viewmodel/app_model.dart';
import 'package:github_dashboard/core/viewmodel/search_model.dart';
import 'package:github_dashboard/core/viewmodel/user_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => AppModel());
  locator.registerFactory(() => SearchModel());
  locator.registerFactory(() => UserModel());
}
