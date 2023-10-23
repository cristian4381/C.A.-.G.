
import 'package:ca_and_g/blocs/connectivity/connectivity_bloc.dart';
import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UbicacionView extends StatelessWidget {
  const UbicacionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConnectivityBloc connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
    return Card(
      child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) {
          return Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const LabelCategoryForm(titulo: 'Ubicacion'),
                  if(state.estado == 1)
                    const _EnableGpsMessage(),
                  if(state.estado == 2)
                    CustomButton(
                      texto: 'Solicitar acceso', 
                      onPressed: (){
                        connectivityBloc.askGpsAccess();
                      }, 
                      color: Colors.green
                    ),
                  if(state.estado == 3) 
                    CustomButton(
                      texto: 'Agregar Ubicacion', 
                      onPressed: (){
                        connectivityBloc.add(GuardarUbicacionEvent());
                      }, 
                      color: Colors.green
                    ),
                  if(state.estado == 4)
                    _Ubicacion(
                      latitud: state.latitud,
                      longitud: state.longitud,
                    ),
                  
                ],
              ),
            );
        },
      ),
    );
  }
  
}

class _Ubicacion extends StatelessWidget {
  final double longitud;
  final double latitud;

  const _Ubicacion({
    required this.longitud, 
    required this.latitud
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5,left: 20,bottom: 5,right: 20),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        children: [
          const SizedBox(height: 10),
          MostrarInformacion(titulo: 'Longitud', contenido: longitud.toString()),
          MostrarInformacion(titulo: 'Latitud', contenido: latitud.toString()),
          Container(
            alignment: Alignment.centerRight,
            child: CustomButton(texto: 'Eliminar', 
              onPressed: (){
                BlocProvider.of<ConnectivityBloc>(context).add(EliminarUbicacionEvent());
              }, 
              color: Colors.red
            )
          ),
        ],
        
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe de habilitar el GPS',
      style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),
    );
  }
}

