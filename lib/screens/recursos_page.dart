import 'package:flutter/material.dart';

import '../widgets/contenido.dart';

class RecursosPage extends StatelessWidget {
  const RecursosPage({super.key});

  static const _imagePaths = [
    'assets/images/ana.png',
    'assets/images/luis.png',
    'assets/images/carlos.png',
    'assets/images/docente.png',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Fuentes e imágenes')),
    body: Contenido(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fuentes personalizadas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Texto con fuente Jacquard Regular',
                    style: TextStyle(fontFamily: 'Jacquard', fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Texto con fuente Roboto Bold',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Texto con fuente normal Hugo Renzo',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Imágenes locales',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ..._imagePaths.map(
            (imagePath) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  imagePath,
                  height: 180,
                  fit: BoxFit.contain,
                  semanticLabel: imagePath.split('/').last,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
