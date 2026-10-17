import 'package:flutter/material.dart';

import '../data/datos_academicos.dart';
import '../widgets/contenido.dart';
import 'registro_page.dart';

class AlumnosPage extends StatefulWidget {
  const AlumnosPage({super.key, required this.datos});
  final DatosAcademicos datos;

  @override
  State<AlumnosPage> createState() => _AlumnosPageState();
}

class _AlumnosPageState extends State<AlumnosPage> {
  String _busqueda = '';

  Future<void> _registrar() async {
    await Navigator.pushNamed(context, '/registro');
    if (mounted) setState(() {});
  }

  Future<void> _accion(String accion, Map<String, dynamic> alumno) async {
    if (accion == 'editar') {
      await Navigator.push(context, MaterialPageRoute<void>(builder: (_) => RegistroPage(datos: widget.datos, alumno: alumno)));
      if (mounted) setState(() {});
      return;
    }
    // showDialog devuelve la elección del usuario antes de modificar la lista.
    final eliminar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar alumno'),
        content: Text('¿Eliminar a ${alumno['nombre']} ${alumno['apellido']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (eliminar == true && mounted) setState(() => widget.datos.alumnos.remove(alumno));
  }

  @override
  Widget build(BuildContext context) {
    // where filtra los alumnos según la búsqueda sin modificar la lista original
    final visibles = widget.datos.alumnos.where((alumno) => '${alumno['nombre']} ${alumno['apellido']}'.toLowerCase().contains(_busqueda.toLowerCase().trim())).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumnos'),
        actions: [IconButton(tooltip: 'Registrar alumno', onPressed: _registrar, icon: const Icon(Icons.add))],
      ),
      body: Contenido(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: TextField(
              onChanged: (value) => setState(() => _busqueda = value),
              decoration: const InputDecoration(hintText: 'Buscar alumno...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Align(alignment: Alignment.centerLeft, child: Text('${visibles.length} alumnos', style: const TextStyle(color: Colors.black54))),
          ),
          Expanded(
            child: visibles.isEmpty
              ? Center(child: Text(widget.datos.alumnos.isEmpty ? 'Aún no hay alumnos registrados' : 'No se encontraron alumnos'))
                      // Construye una fila por alumno de la lista filtrada
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: visibles.length,
                  itemBuilder: (context, index) {
                    final alumno = visibles[index];
                    final aprobado = widget.datos.aprobado(alumno);
                    final color = aprobado ? const Color(0xFF18764A) : const Color(0xFFB3261E);
                    return Card(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16, right: 4, top: 8),
                          leading: AvatarAlumno(imagen: alumno['imagen'] as String),
                          title: Text('${alumno['nombre']} ${alumno['apellido']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text('Nota: ${(alumno['nota'] as num).toStringAsFixed(1)} / 20'),
                          trailing: PopupMenuButton<String>(
                            tooltip: 'Opciones de ${alumno['nombre']}',
                            onSelected: (accion) => _accion(accion, alumno),
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'editar', child: Text('Editar')),
                              PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, bottom: 16, right: 16),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(aprobado ? Icons.check_circle_outline : Icons.cancel_outlined, size: 15, color: color),
                            const SizedBox(width: 6),
                            Text(aprobado ? 'Aprobado' : 'Desaprobado', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ]),
                    );
                  },
                ),
          ),
        ]),
      ),
    );
  }
}
