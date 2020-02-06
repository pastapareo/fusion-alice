import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fusion_alice/features/ffdc/retail_intl/domain/usecases/get_account_balances.dart'
    as useCase;
import 'package:fusion_alice/features/ffdc/retail_intl/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/ffdc/retail_intl/data/datasources/account_info_local_data_source.dart';
import 'features/ffdc/retail_intl/data/datasources/account_info_remote_data_source.dart';
import 'features/ffdc/retail_intl/data/datasources/ffdc_account_info_data_source.dart';
import 'features/ffdc/retail_intl/data/datasources/shared_pref_account_info_data_source.dart';
import 'features/ffdc/retail_intl/data/repositories/data_account_info_repository.dart';
import 'features/ffdc/retail_intl/domain/repositories/account_info_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // *Features
  // *BLOC
  sl.registerFactory(
    () => AccountInfoBloc(
      getAccountBalances: sl(),
    ),
  );

  // *Use cases
  sl.registerLazySingleton(() => useCase.GetAccountBalances(sl()));

  // *Repository
  sl.registerLazySingleton<AccountInfoRepository>(() => DataAccountInfoRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // *Data sources
  sl.registerLazySingleton<AccountInfoRemoteDataSource>(
    () => FfdcAccountInfoDataSource(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<AccountInfoLocalDataSource>(
    () => SharedPreferencesAccountInfoDataSource(
      sharedPreferences: sl(),
    ),
  );

  // *External
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
