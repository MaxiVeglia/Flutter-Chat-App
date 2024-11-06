import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instancia de auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Iniciar sesión
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      // Autenticar usuario
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar si el usuario es válido
      if (userCredential.user == null) {
        throw Exception("Error de autenticación: Usuario no válido.");
      }

      // Guardar la información del usuario en Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de errores de autenticación
      throw Exception("Error de autenticación: ${e.code}");
    } catch (e) {
      // Manejo de otros posibles errores
      throw Exception("Error inesperado: ${e.toString()}");
    }
  }

  // Registrarse
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      // Crear usuario
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar si el usuario es válido
      if (userCredential.user == null) {
        throw Exception("Error de registro: Usuario no válido.");
      }

      // Guardar la información del usuario en Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de errores de autenticación
      throw Exception("Error de registro: ${e.code}");
    } catch (e) {
      // Manejo de otros posibles errores
      throw Exception("Error inesperado: ${e.toString()}");
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Error al cerrar sesión: ${e.toString()}");
    }
  }
}
