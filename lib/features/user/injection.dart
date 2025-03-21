import 'package:get_it/get_it.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/bloc/user_tile_bloc.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'presentation/index.dart';

final sl = GetIt.instance;

void registerUserModule() {
  // Data Sources
  sl.registerLazySingleton<UsersDataSource>(
    () => UserProfileRemoteDataSourceImpl(authApiService: sl<ApiService>()),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<UsersDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => FetchProfileUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => FollowUserUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => UnFollowUserUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetFollowersUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetFollowingUsersUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => SearchUsersUseCase(userRepository: sl<UserRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      followUserUseCase: sl<FollowUserUseCase>(),
      unFollowUserUseCase: sl<UnFollowUserUseCase>(),
    ),
  );
  sl.registerFactory(
    () => FollowingUsersBloc(
      getFollowingUsersUseCase: sl<GetFollowingUsersUseCase>(),
    ),
  );
  sl.registerFactory(
    () => UserFollowersBloc(getFollowersUseCase: sl<GetFollowersUseCase>()),
  );

  sl.registerFactory(
    () => SearchScreenBloc(
      searchUsersUseCase: sl<SearchUsersUseCase>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  sl.registerFactory(
    () => UserTileBloc(
      followUserUseCase: sl<FollowUserUseCase>(),
      unFollowUserUseCase: sl<UnFollowUserUseCase>(),
    ),
  );
}
