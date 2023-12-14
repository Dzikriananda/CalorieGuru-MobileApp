import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory<Auth>(() => Auth());
  locator.registerFactory<ApiService>(() => ApiService());
  locator.registerFactory<Firestore>(() => Firestore());


}