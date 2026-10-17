import 'package:flutter/material.dart';

import '../data/datos_academicos.dart';
import '../widgets/contenido.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.datos});
  final DatosAcademicos datos;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<void> _abrir(String ruta) async {
    // await espera el regreso; mounted comprueba que esta pantalla siga activa.
    await Navigator.pushNamed(context, ruta);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final opciones = [
      {'titulo': 'Registrar alumno', 'icono': Icons.person_add_outlined, 'ruta': '/registro'},
      {'titulo': 'Listar alumnos', 'icono': Icons.format_list_bulleted, 'ruta': '/alumnos'},
      {'titulo': 'Perfil', 'icono': Icons.person_outline, 'ruta': '/perfil'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Menú')),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(children: [
            const Padding(padding: EdgeInsets.all(24), child: Text('Aula', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
            ...opciones.map((opcion) => ListTile(
              leading: Icon(opcion['icono'] as IconData),
              title: Text(opcion['titulo'] as String),
              onTap: () { Navigator.pop(context); _abrir(opcion['ruta'] as String); },
            )),
            const Divider(),
            ListTile(leading: const Icon(Icons.logout), title: const Text('Cerrar sesión'), onTap: () => cerrarSesion(context)),
          ]),
        ),
      ),
      body: Contenido(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text('MI ESPACIO ACADÉMICO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
            const SizedBox(height: 12),
            Text('Hola, ${widget.datos.perfil['nombre']!.split(' ').first}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${widget.datos.alumnos.length} alumnos en tu aula', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 32),
            ...opciones.map((opcion) => Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                leading: Icon(opcion['icono'] as IconData, color: Theme.of(context).colorScheme.primary),
                title: Text(opcion['titulo'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _abrir(opcion['ruta'] as String),
              ),
            )),
            const SizedBox(height: 12),
            ListTile(leading: const Icon(Icons.logout, color: Color(0xFFB3261E)), title: const Text('Cerrar sesión'), onTap: () => cerrarSesion(context)),
          ],
        ),
      ),
    );
  }
}
