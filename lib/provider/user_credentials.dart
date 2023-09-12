/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// Fazer login com e-mail e senha
Future<User?> signInWithEmailAndPassword(String email, String password) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    if (kDebugMode) {
      print('Erro ao fazer login: $e');
    }
    return null;
  }
}

// Fazer logout
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}*/
