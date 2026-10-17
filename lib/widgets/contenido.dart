import 'package:flutter/material.dart';

class Contenido extends StatelessWidget {
  const Contenido({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // ConstrainedBox limita el ancho en web; en móvil ocupa el espacio disponible.
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: child,
        ),
      ),
    );
  }
}

class AvatarAlumno extends StatelessWidget {
  const AvatarAlumno({super.key, required this.imagen, this.radio = 24});

  final String imagen;
  final double radio;

  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: radio,
    backgroundColor: const Color(0xFFEAE5FF),
    backgroundImage: AssetImage('assets/images/$imagen'),
  );
}

void cerrarSesion(BuildContext context) {
  // Elimina las rutas protegidas para que Atrás no regrese al menú tras salir.
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}
