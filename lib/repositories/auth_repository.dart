// lib/repositories/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
// FirestoreRepository больше не нужен, убираем импорт

class AuthRepository {
  // AuthRepository теперь зависит ТОЛЬКО от FirebaseAuth.
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Возвращает Stream, который уведомляет об изменении состояния аутентификации в Firebase.
  /// AppCubit будет слушать этот stream, чтобы понимать, залогинен пользователь или нет.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Метод регистрации.
  /// 1. Создает пользователя в Firebase Auth.
  /// 2. Больше НИЧЕГО не делает. Создание профиля в PostgreSQL - задача ApiRepository.
  Future<User?> signUp({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Пароль слишком слабый.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Аккаунт с таким E-mail уже существует.');
      }
      rethrow; // Пробрасываем другие ошибки Firebase
    }
  }

  /// Метод входа в систему.
  /// Просто входит в Firebase. Получением JWT и профиля с нашего сервера займется AppCubit.
  Future<User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException {
      throw Exception('Неверный E-mail или пароль.');
    }
  }

  /// Метод выхода.
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}