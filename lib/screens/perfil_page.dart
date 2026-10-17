import 'package:flutter/material.dart';

import '../data/datos_academicos.dart';
import '../widgets/contenido.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key, required this.datos});
  final DatosAcademicos datos;

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Future<void> _editar() async {
    // El diálogo devuelve un mapa solo al guardar; cancelar conserva los datos.
    final cambios = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => _EditarPerfilDialog(perfil: widget.datos.perfil),
    );
    if (cambios != null && mounted) {
      setState(() => widget.datos.perfil.addAll(cambios));
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfil = widget.datos.perfil;
    final campos = [
      {'clave': 'nombre', 'etiqueta': 'Nombre', 'icono': Icons.person_outline},
      {'clave': 'email', 'etiqueta': 'Correo electrónico', 'icono': Icons.mail_outline},
      {'clave': 'telefono', 'etiqueta': 'Teléfono', 'icono': Icons.phone_outlined},
      {'clave': 'rol', 'etiqueta': 'Rol', 'icono': Icons.work_outline},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Contenido(child: ListView(padding: const EdgeInsets.all(24), children: [
        const SizedBox(height: 8),
        const Center(child: AvatarAlumno(imagen: 'docente.png', radio: 48)),
        const SizedBox(height: 16),
        Text(perfil['nombre']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(perfil['rol']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 32),
        ...campos.map((campo) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(campo['icono'] as IconData),
          title: Text(campo['etiqueta'] as String, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          subtitle: Text(perfil[campo['clave']]!, style: const TextStyle(fontSize: 16, color: Colors.black87)),
        )),
        const SizedBox(height: 24),
        OutlinedButton.icon(onPressed: _editar, icon: const Icon(Icons.edit_outlined), label: const Text('Editar perfil')),
      ])),
    );
  }
}

class _EditarPerfilDialog extends StatefulWidget {
  const _EditarPerfilDialog({required this.perfil});
  final Map<String, String> perfil;

  @override
  State<_EditarPerfilDialog> createState() => _EditarPerfilDialogState();
}

class _EditarPerfilDialogState extends State<_EditarPerfilDialog> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _email;
  late final TextEditingController _telefono;

  @override
  void initState() {
    super.initState();
    _nombre = TextEditingController(text: widget.perfil['nombre']);
    _email = TextEditingController(text: widget.perfil['email']);
    _telefono = TextEditingController(text: widget.perfil['telefono']);
  }

  @override
  void dispose() {
    _nombre.dispose();
    _email.dispose();
    _telefono.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Editar perfil'),
    content: SingleChildScrollView(
      child: Form(key: _form, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(controller: _nombre, decoration: const InputDecoration(labelText: 'Nombre'), validator: (v) => (v ?? '').trim().isEmpty ? 'Ingresa tu nombre' : null),
        const SizedBox(height: 16),
        TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Correo electrónico'), validator: (v) => RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch((v ?? '').trim()) ? null : 'Ingresa un correo válido'),
        const SizedBox(height: 16),
        TextFormField(controller: _telefono, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Teléfono'), validator: (v) => RegExp(r'^\d{9}$').hasMatch((v ?? '').trim()) ? null : 'Ingresa 9 dígitos'),
      ])),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
      FilledButton(onPressed: () {
        if (_form.currentState!.validate()) {
          Navigator.pop(context, {'nombre': _nombre.text.trim(), 'email': _email.text.trim(), 'telefono': _telefono.text.trim()});
        }
      }, child: const Text('Guardar')),
    ],
  );
}
