import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;


final sl = GetIt.instance;

Future<void> initDependencies() async {

  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  _initHome();

}

void  _initHome(){

  // sl.registerLazySingleton<HomeRemoteDataSource>(
  //   () => HomeRemoteDataSourceImpl(client: sl(), networkInfo: sl()),
  // );

}