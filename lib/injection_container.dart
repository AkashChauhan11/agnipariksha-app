import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';

// Auth
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ========================
  // Features - Auth
  // ========================

  // Cubit
  sl.registerFactory(
    () => AuthCubit(authRepository: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl(),
      storageService: sl(),
    ),
  );

  // ========================
  // Core
  // ========================

  // Services
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
  sl.registerLazySingleton<StorageService>(() => StorageService(sl()));

  // ========================
  // External
  // ========================

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

