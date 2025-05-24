import 'package:get_it/get_it.dart';
import '../cache/storage_token.dart';

final sl = GetIt.instance;

void setup() {
  registerNeededClasses();
}

void registerNeededClasses() {
  sl.registerLazySingleton<StorageToken>(() => StorageToken());
}
