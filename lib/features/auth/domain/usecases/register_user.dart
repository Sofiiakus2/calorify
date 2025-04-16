import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/auth/domain/repositories/user_repository.dart';

///use case for registration
class RegisterUser{
  final UserRepository repository;

  ///Constructor
  RegisterUser(this.repository);

  ///Executes the logic for register.
  Future<void> call(MyUser user){
    return repository.registerUser(user);
  }
}
