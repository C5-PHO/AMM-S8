# Recursos complementarios a los apuntes

Los apuntes compartidos muestran composición con Row/Column y navegación con Navigator.push/pop. Esta nota explica los recursos que amplían ese material. Los comentarios correspondientes también están junto al código.

| Recurso | Para qué se utiliza | Archivo |
| --- | --- | --- |
| `GlobalKey<FormState>` y `validator` | Consultar todos los campos y guardar solo si son válidos. | `screens/login_page.dart`, `screens/registro_page.dart` |
| `TextEditingController` | Leer los textos y precargar valores al editar; se libera con `dispose`. | `screens/registro_page.dart`, `screens/perfil_page.dart` |
| `where` y `toList` | Obtener los alumnos que coinciden con la búsqueda sin eliminar datos originales. | `screens/alumnos_page.dart` |
| `async` y `await` | Esperar el regreso de una ruta o la respuesta de un diálogo. | Pantallas de menú, alumnos y perfil |
| `mounted` | Comprobar que el widget sigue en pantalla antes de usar `setState` tras un `await`. | Pantallas de menú, alumnos y perfil |
| `showDialog<T>` y `Navigator.pop(context, resultado)` | Devolver la confirmación de eliminación o el mapa del perfil editado. | Pantallas de alumnos y perfil |
| `pushReplacementNamed` | Reemplazar login por menú para que Atrás no vuelva al formulario de acceso. | `screens/login_page.dart` |
| `pushNamedAndRemoveUntil` | Limpiar el historial al cerrar sesión. | `widgets/contenido.dart` |
| `ConstrainedBox`, `SafeArea` y listas desplazables | Limitar el ancho en escritorio y permitir desplazamiento en pantallas pequeñas. | `widgets/contenido.dart` y pantallas |
| `FilteringTextInputFormatter` | Permitir caracteres numéricos; el validador comprueba que la nota sea válida. | `screens/registro_page.dart` |

## Datos compartidos

`MyApp` crea una instancia de `DatosAcademicos` y la pasa a cada pantalla mediante sus constructores. Al regresar desde registro o perfil, el menú llama a `setState` y muestra los datos actualizados. Esto permite practicar listas y mapas sin agregar bibliotecas de gestión de estado.

## Recorrido para exposición

1. Intentar ingresar con campos vacíos y mostrar los errores.
2. Ingresar con `demo@aula.pe` y `demo123`.
3. Abrir el listado y buscar a un alumno por apellido.
4. Registrar un alumno, intentar nota 21 y luego guardar con nota 16.
5. Editar su nota y observar el estado de aprobación.
6. Cancelar una eliminación y luego confirmarla.
7. Editar el perfil y volver para ver el saludo actualizado.
8. Cerrar sesión y comprobar que Atrás no abre el menú.

El login es de demostración. No hay servidor, recuperación real de contraseña ni persistencia. Recargar restablece los datos iniciales.
