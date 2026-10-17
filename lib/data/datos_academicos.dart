class DatosAcademicos {
                  // Guarda los alumnos en una lista; cada mapa contiene los datos de un alumno
  final List<Map<String, dynamic>> alumnos = [
    {'nombre': 'Ana', 'apellido': 'Torres', 'nota': 18.0, 'imagen': 'ana.png'},
    {'nombre': 'Luis', 'apellido': 'García', 'nota': 12.0, 'imagen': 'luis.png'},
    {'nombre': 'María', 'apellido': 'López', 'nota': 9.0, 'imagen': 'docente.png'},
    {'nombre': 'Carlos', 'apellido': 'Ruiz', 'nota': 15.0, 'imagen': 'carlos.png'},
  ];
          // Guarda los datos del perfil mediante claves y valores de tipo texto

  final Map<String, String> perfil = {
    'nombre': 'Piero Tec',
    'email': 'piero@correo.com',
    'telefono': '912345678',
    'rol': 'Docente',
  };

  // Regla elegida para esta práctica: se aprueba desde 11 sobre 20.
  bool aprobado(Map<String, dynamic> alumno) => (alumno['nota'] as num) >= 11;
}
