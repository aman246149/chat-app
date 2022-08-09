import 'dart:ffi';

import 'package:chat_app/constants/Error.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/otp_screen.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserCredential? user;

  Future<Either<CustomError, String>> signIn(
      String phoneNumber, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              throw e;
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            try {
              final sms = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPscreen(),
                  ));

              // Create a PhoneAuthCredential with the code
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: sms);

              // Sign the user in (or link) with the credential
              user = await _auth.signInWithCredential(credential);
            } catch (e) {
              rethrow ;
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      return Right("");
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
