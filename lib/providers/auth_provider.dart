import 'package:chat_app/constants/Error.dart';
import 'package:chat_app/resources/FirebaseMethod.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  UserCredential? _user;

  String _errormsg = "";

  String get errormsg => _errormsg;
  bool get isLoading => _isLoading;

  UserCredential? get user => _user;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> setSignUp(String username, String email, String password) async {
    setLoading(true);
    final result = await FirebaseMethods().signUp(email, password, username);

    result.fold((left) async => _errormsg = left.errormsg, (right) {});
    _isLoading = false;

    setLoading(false);
  }

  Future<void> setSignIn(String email, String password) async {
    setLoading(true);
    final result = await FirebaseMethods().signIn(email, password);

    result.fold((left) async => _errormsg = left.errormsg, (right) => null);
    _isLoading = false;
    setLoading(false);
  }
}
