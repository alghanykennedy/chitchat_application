import 'package:bloc/bloc.dart';
import 'package:chitchat_application/Screens/Chats/chats_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthInitial());

  Future<void> onLogin(email, password) async {
    try {
      final auth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await _firebaseAuth.currentUser.getIdToken();
      emit(AuthLogin(token, auth.user.email));
    } on FirebaseAuthException catch (e) {
      emit(
        AuthLoginFailure(
          e.message ?? e.toString(),
        ),
      );
    } catch (e) {
      emit(
        AuthLoginFailure(
          e.message ?? e.toString(),
        ),
      );
    }
  }
}
