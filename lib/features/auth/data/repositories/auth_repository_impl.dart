import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/network_old/network_info.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkService networkService;

  AuthRepositoryImpl(this.remoteDataSource, this.networkService);

  @override
  Future<AuthUserModel> login(String email, String password) async {
    if (await networkService.isConnected == true) {
      try {
        return remoteDataSource.login(email, password);
      } on ServerException {
        throw Exception('Server exception.');
      }
    } else {
      try {
        // TODO: Local data source impl
        return remoteDataSource.login(email, password);
      } on CacheException {
        throw Exception('No local data found');
      }
    }
  }

  @override
  Future<String> register(String name, String email, String password,
      String confirmPassword) async {
    var result =
        await remoteDataSource.register(name, email, password, confirmPassword);
    return result;
  }

  @override
  Future<String> logout() async {
    return remoteDataSource.logout();
  }
}
