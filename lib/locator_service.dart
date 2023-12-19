import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_i_morty/feature/data/datasources/person_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/data/datasources/person_remote_data_source.dart';
import 'feature/data/repositories/person_repository_impl.dart';
import 'feature/domain/repositories/person_repository.dart';
import 'feature/domain/usecases/get_all_persons.dart';
import 'feature/domain/usecases/search_person.dart';
import 'core/platform/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => PersonListCubit(
      getAllPersons: sl(),
    ),
  );

  sl.registerFactory(
    () => PersonSearchBloc(
      searchPerson: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllPersons(sl()));

  sl.registerLazySingleton(() => SearchPerson(sl()));

  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(
    () => http.Client(),
  );

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
