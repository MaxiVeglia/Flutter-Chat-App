import 'package:chat_app_max/services/auth/auth_services.dart';
import 'package:chat_app_max/components/my_botton.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  final TextEditingController _confirmPwController = TextEditingController();

  void register(BuildContext context) {
    // Implementar la lógica de inicio de sesión
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signInWithEmailPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("Error"), content: Text("Contraseña incorrecta")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 25),

            // Bienvenida
            Text(
              "¡Registrate y crea tu Cuenta!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            // Email
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
              focusNode: null,
            ),
            const SizedBox(height: 10),

            // Contraseña
            MyTextfield(
              hintText: "Contraseña",
              obscureText: true,
              controller: _pwController,
              focusNode: null,
            ),

            const SizedBox(height: 10),

            // Contraseña
            MyTextfield(
              hintText: "Confirmar Contraseña",
              obscureText: true,
              controller: _confirmPwController,
              focusNode: null,
            ),

            const SizedBox(height: 25),

            // Botón de Ingresar
            MyBotton(text: "Registrar", onTap: () => register(context)),
            const SizedBox(height: 25),

            // Registrar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Ya tienes una cuenta?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap, // Acción para registrarse
                  child: Text(
                    "¡Ingresa ahora!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
