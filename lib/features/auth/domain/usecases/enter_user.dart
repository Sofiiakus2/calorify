import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/auth/domain/repositories/user_repository.dart';

///use case for registration
class EnterUser{
  final UserRepository repository;

  ///Constructor
  EnterUser(this.repository);

  ///Executes the logic for register.
  Future<void> call(MyUser user){
    return repository.enterUser(user);
  }
}
