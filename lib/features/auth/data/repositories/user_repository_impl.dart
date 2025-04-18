
import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:calorify/features/auth/domain/repositories/user_repository.dart';


///
class UserRepositoryImpl implements UserRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  ///Constructor
  UserRepositoryImpl({
    required this.authRemoteDataSource,
});

  @override
  Future<String> enterUser(MyUser user) {
    return authRemoteDataSource.enterUser(user);
  }

  @override
  Future<void> registerUser(MyUser user) {
    return authRemoteDataSource.registerUser(user);
  }

  @override
  Future<MyUser> getUserById(String id) {
    return authRemoteDataSource.getUserById(id);
  }

}
