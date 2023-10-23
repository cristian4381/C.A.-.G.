import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/widgets/widgets.dart';


class DatosFamiliar extends StatelessWidget {
  final Persona familiar;
  final int nofamilar;
  const DatosFamiliar({
    super.key,
    required this.familiar,
    required this.nofamilar
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
          Container(
            alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Datos familar No.$nofamilar',
                style: AppTheme.notaTheme(context),
              ),
            ),
          MostrarInformacion(
            titulo: 'Nombre', 
            contenido: familiar.nombre
          ),
          MostrarInformacion(
            titulo: 'Sexo', 
            contenido: familiar.sexo
          ),
          MostrarInformacion(
            titulo: 'Fecha nacimiento', 
            contenido: DateFormat('yyyy-MM-dd').format(familiar.fechaNacimiento)
          ),
          
          if(familiar.ocupacion.isNotEmpty)
            MostrarInformacion(
              titulo: 'Ocupacion', 
              contenido: familiar.ocupacion
            ),
          
          if(familiar.embarazada!.containsKey('embarazada') && familiar.embarazada?['embarazada'] == 'si')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MostrarInformacion(
                  titulo: 'Tiempo Gestacion',
                  contenido: familiar.embarazada?['tiempo_gestacion'], 
                ),
                MostrarInformacion(
                  titulo: 'Lugar de control', 
                  contenido: familiar.embarazada?['lugar_control'] ?? 'No disponible'
                ),
                MostrarInformacion(
                  titulo: 'Telefono', 
                  contenido: familiar.embarazada?['telefono'] ?? 'No disponible'
                ),
              ],
            ),
          
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerRight,
            child: CustomButton(texto: 'Eliminar', 
            onPressed: () => BlocProvider.of<FamiliaBloc>(context,listen: false).add(EliminarFamiliarEvent(nofamilar-1)), 
            color: Colors.red)
          ),
        ],
      ),
    );
  }
}