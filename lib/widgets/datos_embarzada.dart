
import 'package:flutter/material.dart';

import './widgets.dart';

class DatosEmbarazada extends StatelessWidget {
  final TextEditingController tiempoGestacion;
  final TextEditingController lugar;
  final TextEditingController telefono;
  final ValueChanged<dynamic> onChanged;

  const DatosEmbarazada({
    super.key,
    required this.tiempoGestacion, 
    required this.lugar, 
    required this.telefono, 
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final optiones = {'si': 'Si','no': 'No'};
    return Column(
      children: [
        CustomInput(
          hintText: 'Tiempo de gestacion', 
          prefix: Icons.calendar_month_sharp, 
          textController: tiempoGestacion, 
          nota: 'Tiempo de gestacion',
        ),
        Dropdown(
          options: optiones, 
          onChanged: ( valor) => onChanged(valor), 
          titulo: 'Lleva control',
        ),
        CustomInput(
          hintText: 'Lugar de control', 
          prefix: Icons.place, 
          textController: lugar,
          nota: 'Lugar de control',
         
        ),
        CustomInput(
          hintText: 'telefono', 
          prefix: Icons.smartphone, 
          textController: telefono,
          nota: 'Numero telefono',
        ),
      ],
    );
  }
}