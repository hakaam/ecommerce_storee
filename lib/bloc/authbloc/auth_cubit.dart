import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        emit(AuthAuthenticated(currentUser));
      } else {
        emit(AuthError("User is null after authentication."));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateProfile(
        displayName: '$firstName $lastName',
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      emit(AuthAuthenticated(userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
    } catch (e) {
      if (e.toString().contains('email-already-in-use')) {
        emit(AuthError('Email already in use'));
      } else {
        emit(AuthError('Error: $e'));
      }
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }
}