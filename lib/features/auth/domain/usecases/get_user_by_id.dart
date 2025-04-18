
import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/auth/domain/repositories/user_repository.dart';

///use case getting user by id
class GetUserById {
  final UserRepository repository;

  ///Constructor
  GetUserById(this.repository);

  Future<MyUser> call(String uid) {
    return repository.getUserById(uid);
  }
}
