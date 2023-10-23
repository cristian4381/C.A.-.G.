import 'package:flutter/material.dart';

class MostrarInformacion extends StatelessWidget {
  final String titulo;
  final String contenido;
  const MostrarInformacion({
    super.key,
    required this.titulo, 
    required this.contenido,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$titulo: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold 
          ), 
        ),
        Text(contenido)
      ],
    );
  }
}