import 'package:chat_app/cleanArchitecture/chats/domain/entities/user.dart';
import 'package:chat_app/constants/Error.dart';
import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<CustomError, UserCredential>> signUp(
      String email, String password, String username) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel =
          UserModel(userName: username, userEmail: email, uid: user.user!.uid);

      await _firestore
          .collection("users")
          .doc(user.user!.uid)
          .set(userModel.toJson());

      return Right(user);
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }

  Future<Either<CustomError, UserCredential>> signIn(
      String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return Right(user);
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
