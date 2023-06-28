import 'package:app_seu_madeu_sucos/Model/UserModel.dart';
import 'package:app_seu_madeu_sucos/Service/Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RequestStatus.dart';

class AuthServiceImp extends Service {
  static const REQ_TITLE_AUTHENTICATE = "Authenticate Request";
  static const REQ_TITLE_SIGNOUT = "Sign Out Request";
  static const REQ_TITLE_CREATE_USER = "Create User Request";

  static final AuthServiceImp instance = AuthServiceImp._internal();
  AuthServiceImp._internal();

  final _firebaseAuth = FirebaseAuth.instance;

  Future authenticate(UserModel user) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: user.getEmail, password: user.getPassword
      );

      notify(
      requestTitle: AuthServiceImp.REQ_TITLE_AUTHENTICATE,
      responseStatus: RequestStatus.SUCCESSFUL,
      object: [user],
    );
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        debugPrint('[Auth Service] No user found for that email');
      } else if (e.code == 'wrong-password') {
        debugPrint('[Auth Service] Wrong password provided for that user');
      }

      notify(
        requestTitle: AuthServiceImp.REQ_TITLE_AUTHENTICATE,
        responseStatus: RequestStatus.FAILED,
        object: [user],
      );
    }
  }

  Future signOut() async {
    try{
      await _firebaseAuth.signOut();

      notify(
        requestTitle: AuthServiceImp.REQ_TITLE_SIGNOUT,
        responseStatus: RequestStatus.SUCCESSFUL,
        object: [],
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("[Auth Service] signOut error: ${e.code.toString()}");
      notify(
        requestTitle: AuthServiceImp.REQ_TITLE_SIGNOUT,
        responseStatus: RequestStatus.FAILED,
        object: [e.code.toString()],
      );
    }
  }

  Future createUser(UserModel user) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: user.getEmail, password: user.getPassword,);
      notify(
        requestTitle: AuthServiceImp.REQ_TITLE_CREATE_USER,
        responseStatus: RequestStatus.SUCCESSFUL,
        object: [user],
      );
    } on FirebaseAuthException catch(e){
      debugPrint("[Auth Service] create user error: ${e.code.toString()}");
      notify(
        requestTitle: AuthServiceImp.REQ_TITLE_CREATE_USER,
        responseStatus: RequestStatus.FAILED,
        object: [e.code.toString()],
      );
    }
  }
}