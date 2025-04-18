
import 'package:calorify/core/entities/my_user.dart';

///remote user data source
abstract class AuthRemoteDataSource{
  ///method for registration
  Future<bool> registerUser(MyUser user);

  ///method for entering
  Future<String> enterUser(MyUser user);

  ///get user by id
  Future<MyUser> getUserById(String id);
}
