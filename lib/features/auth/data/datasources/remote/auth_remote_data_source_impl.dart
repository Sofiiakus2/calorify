import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:calorify/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///remote data source implementation
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Future<String> enterUser(MyUser user) async{
    try{
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      return userCredential.user!.uid;
    }on FirebaseAuthException catch (e) {
      return '';
    } catch (e) {
      return '';
    }
  }

  @override
  Future<bool> registerUser(MyUser user) async{
    try{
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      final uid = userCredential.user?.uid;

      final userModel = UserModel.fromMyUser(user.copyWith(id: uid));

      await firestore.collection('users').doc(uid).set(userModel.toMap());

      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Future<MyUser> getUserById(String id) async{
    final doc = await firestore.collection('users').doc(id).get();
    final userModel = UserModel.fromMap(doc.data()!);

    return userModel;
  }

}
