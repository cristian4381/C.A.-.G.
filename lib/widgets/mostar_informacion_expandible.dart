import 'package:flutter/material.dart';

class MostrarInformacionExpandible extends StatelessWidget {
  final String titulo;
  final String contenido;
  const MostrarInformacionExpandible({
    super.key, 
    required this.titulo, 
    required this.contenido
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$titulo',
          style: const TextStyle(
            fontWeight: FontWeight.bold 
          ), 
        ),
        Text(
          contenido
        ),
      ],
    );
  }
}