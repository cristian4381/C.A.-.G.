import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConfrimarEnvioDialog extends StatelessWidget {
  final String title;
  final String comunidad;
  final String sector;

  const ConfrimarEnvioDialog({
    super.key, 
    required this.title,
    required this.comunidad,
    required this.sector,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
      ),
      title: Text(title,textAlign: TextAlign.center),
      content: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Los botones ocuparán todo el ancho
          children: [
            Text(
              'Los datos estan asociados ha: ', 
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'Comunidad:', 
              textAlign: TextAlign.justify,
            ),
            Text(
              '$comunidad', 
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sector:', 
              textAlign: TextAlign.justify,
            ),
            Text(
              sector, 
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '¿Desea continuar?', 
              textAlign: TextAlign.center,
            ),  // Espacio entre el texto y los botones
            const SizedBox(height: 16),
            CustomButton(
              texto: 'Si', 
              onPressed: () {
                Navigator.of(context).pop(true); // Pop con valor 'true' para indicar respuesta afirmativa
              }, 
              color: Colors.green
            ),
            CustomButton(
              texto: 'No', 
              onPressed: () {
                Navigator.of(context).pop(false); // Pop con valor 'false' para indicar respuesta negativa
              }, 
              color: Colors.red
            ),
          ],
        ),
      ),
    );
  }
}
