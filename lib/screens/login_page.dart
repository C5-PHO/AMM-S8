import 'package:flutter/material.dart';

import '../widgets/contenido.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // GlobalKey permite consultar la validación conjunta del Form.
  final _form = GlobalKey<FormState>();
  bool _ocultar = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Contenido(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.school_rounded, size: 72, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                const Text('Aula', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Iniciar sesión', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('Bienvenido a tu espacio académico', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 32),
                TextFormField(
                  key: const Key('login-email'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.mail_outline)),
                  validator: (value) => RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch((value ?? '').trim()) ? null : 'Ingresa un correo válido',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('login-password'),
                  obscureText: _ocultar,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: _ocultar ? 'Mostrar contraseña' : 'Ocultar contraseña',
                      onPressed: () => setState(() => _ocultar = !_ocultar),
                      icon: Icon(_ocultar ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                  validator: (value) => (value ?? '').length >= 6 ? null : 'Usa al menos 6 caracteres',
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    // Acceso de demostración: valida el formato, sin servidor de autenticación.
                    if (_form.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/menu');
                    }
                  },
                  child: const Text('Ingresar'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Acceso de demostración'),
                      content: const Text('Utiliza un correo con formato válido y una contraseña de al menos 6 caracteres. No uses tu contraseña real.'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))],
                    ),
                  ),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
