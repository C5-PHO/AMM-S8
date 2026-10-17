import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/datos_academicos.dart';
import '../widgets/contenido.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key, required this.datos, this.alumno});
  final DatosAcademicos datos;
  final Map<String, dynamic>? alumno;

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _apellido;
  late final TextEditingController _nota;

  @override
  void initState() {
    super.initState();
    _nombre = TextEditingController(text: widget.alumno?['nombre'] as String?);
    _apellido = TextEditingController(text: widget.alumno?['apellido'] as String?);
    _nota = TextEditingController(text: widget.alumno?['nota']?.toString());
  }

  @override
  void dispose() {
    // Los controladores se liberan al salir para no retener recursos.
    _nombre.dispose();
    _apellido.dispose();
    _nota.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_form.currentState!.validate()) return;
    final alumno = <String, dynamic>{
      'nombre': _nombre.text.trim(),
      'apellido': _apellido.text.trim(),
      'nota': double.parse(_nota.text.trim().replaceAll(',', '.')),
      'imagen': widget.alumno?['imagen'] ?? 'ana.png',
    };
    if (widget.alumno == null) {
      widget.datos.alumnos.add(alumno);
    } else {
      widget.alumno!.addAll(alumno);
    }
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.alumno == null ? 'Alumno registrado' : 'Alumno actualizado')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.alumno == null ? 'Registrar alumno' : 'Editar alumno')),
    body: Contenido(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.person_add_alt_1_outlined, size: 48, color: Color(0xFF5942CE)),
          const SizedBox(height: 24),
          Form(
            key: _form,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TextFormField(
                key: const Key('student-name'),
                controller: _nombre,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nombre del alumno', prefixIcon: Icon(Icons.person_outline)),
                validator: (value) => (value ?? '').trim().isEmpty ? 'Ingresa el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('student-surname'),
                controller: _apellido,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Apellido', prefixIcon: Icon(Icons.badge_outlined)),
                validator: (value) => (value ?? '').trim().isEmpty ? 'Ingresa el apellido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('student-grade'),
                controller: _nota,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                // Acepta punto o coma decimal; validator comprueba el rango completo.
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                decoration: const InputDecoration(labelText: 'Nota (0 - 20)', prefixIcon: Icon(Icons.school_outlined)),
                validator: (value) {
                  final nota = double.tryParse((value ?? '').trim().replaceAll(',', '.'));
                  return nota == null || !nota.isFinite || nota < 0 || nota > 20 ? 'Ingresa una nota entre 0 y 20' : null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(onPressed: _guardar, icon: const Icon(Icons.save_outlined), label: const Text('Guardar')),
            ]),
          ),
        ],
      ),
    ),
  );
}
