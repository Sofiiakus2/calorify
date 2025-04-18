
import 'package:calorify/core/entities/my_user.dart';

///User repository
abstract class UserRepository{
  ///method for register
  Future<void> registerUser(MyUser user);

  ///method for enter
  Future<String> enterUser(MyUser user);

  ///method get user by id
  Future<MyUser> getUserById(String id);

}
