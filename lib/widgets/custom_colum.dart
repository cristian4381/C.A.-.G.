import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomColum extends StatelessWidget {
  final String titulo;
  final List<Widget> contenido;
  final void Function() onPressed;
  final bool mostrarTitulo;
  const CustomColum({
    super.key, 
    required this.contenido, 
    required this.titulo, 
    required this.onPressed,
    this.mostrarTitulo = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5,left: 20,bottom: 5,right: 20),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(mostrarTitulo)
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                titulo,
                style: AppTheme.notaTheme(context),
              ),
            ),
          if(!mostrarTitulo)
            const SizedBox(height: 10),
          Column(
            children: contenido,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: CustomButton(texto: 'Eliminar', 
              onPressed: onPressed, 
              color: Colors.red
            )
          )
        ],
      ),
    );
  }
}