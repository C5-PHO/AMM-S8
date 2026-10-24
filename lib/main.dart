import 'package:flutter/material.dart';

import 'data/datos_academicos.dart';
import 'screens/alumnos_page.dart';
import 'screens/login_page.dart';
import 'screens/menu_page.dart';
import 'screens/perfil_page.dart';
import 'screens/registro_page.dart';
import 'screens/recursos_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Una sola instancia comparte las listas y mapas entre las rutas
  // Los datos viven en memoria: al reiniciar la app vuelven a los iniciales
  final datos = DatosAcademicos();

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5942CE);
    return MaterialApp(
      title: 'Aula | Gestión de alumnos',
      debugShowCheckedModeBanner: false,
                                      // Define el tema global para mantener los mismos estilos en toda la app

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDDE0EA)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Color(0xFFE5E7EF)),
          ),
        ),
      ), 
      initialRoute: '/',
                          // Asocia cada nombre de ruta con la pantalla que se abrirá al navegar

      routes: {
        '/': (_) => const LoginPage(),
        '/menu': (_) => MenuPage(datos: datos),
        '/alumnos': (_) => AlumnosPage(datos: datos),
        '/registro': (_) => RegistroPage(datos: datos),
        '/perfil': (_) => PerfilPage(datos: datos),
        '/recursos': (_) => const RecursosPage(),
      },
    );
  }
}
