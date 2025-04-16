
import 'package:calorify/core/entities/my_user.dart';

///remote user data source
abstract class AuthRemoteDataSource{
  ///method for registration
  Future<bool> registerUser(MyUser user);

  ///method for entering
  Future<bool> enterUser(MyUser user);
}
