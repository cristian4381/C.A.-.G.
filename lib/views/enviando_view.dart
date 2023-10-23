import 'package:flutter/material.dart';

class EnviandoView extends StatelessWidget {
  const EnviandoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/LOGO.png', // Ruta de la imagen (asegúrate de tenerla en la carpeta assets)
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16),
          const Text(
            'Enviando...',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}