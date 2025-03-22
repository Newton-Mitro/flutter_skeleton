import 'package:get_it/get_it.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/auth/presentation/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:tafaling/features/auth/presentation/views/registration_screen/bloc/registration_screen_bloc.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'presentation/index.dart';

final sl = GetIt.instance;

void registerAuthModule() {
  // Register Data Sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  // Register Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegistrationUseCase>(
    () => RegistrationUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthUserUseCase>(
    () => GetAuthUserUseCase(authRepository: sl<AuthRepository>()),
  );

  // Register Bloc
  sl.registerFactory<LoginScreenBloc>(
    () => LoginScreenBloc(loginUseCase: sl<LoginUseCase>()),
  );

  sl.registerFactory<RegistrationScreenBloc>(
    () =>
        RegistrationScreenBloc(registrationUseCase: sl<RegistrationUseCase>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logoutUseCase: sl<LogoutUsecase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
