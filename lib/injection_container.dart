import 'package:agni_pariksha/features/auth/domain/usecase/register.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/login.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/verify_otp.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/resend_otp.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/forgot_password.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/reset_password.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/get_current_user.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/logout.dart';
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

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl(),
      storageService: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));

  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      registerUsecase: sl(),
      loginUsecase: sl(),
      verifyOtpUsecase: sl(),
      resendOtpUsecase: sl(),
      forgotPasswordUsecase: sl(),
      resetPasswordUsecase: sl(),
      getCurrentUserUsecase: sl(),
      logoutUsecase: sl(),
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

