import 'package:ca_and_g/blocs/fumulario/formulario_bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/views/views.dart';
import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacionPage extends StatelessWidget {
  const SincronizacionPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos Guardados"),
      ),
      body: BlocListener<FormularioBloc, FormularioState>(
        listener: (context, state) {
          if(state.sincronizacionEstado == 3){
            
            showDialog(
              context: context, 
              builder: (context) => InformDialog(
                title: 'Listo', 
                content: 'Sincronizacion Exitosa', 
                onPressed: (){
                  formularioBloc.add(SincronizacionExitosaEvent());
                }
              )
            );
          }

          if(state.sincronizacionEstado == 4){
            showDialog(
              context: context, 
              builder: (context) => InformDialog(
                title: 'Error', 
                content: 'No se logro sincronizar los datos, intente mas tarde', 
                onPressed: (){
                  formularioBloc.add(ErrorSincronizacionEvent());
                }
              )
            );
          }
        },
        child: BlocBuilder<FormularioBloc, FormularioState>(
          builder: (context, state) {
      
            if(state.sincronizacionEstado == 2){
              return const EnviandoView();
            }
      
      
      
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.boletas.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Boleta boleta = state.boletas[index];
                          return _Informacion(boleta: boleta);
                        },
                      ),
                      CustomButton(
                        texto: 'Sincronizar', 
                        onPressed: (){
                          formularioBloc.add(SicronizarBoletasEvent());
                        }, 
                        color: Colors.green
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}

class _Informacion extends StatelessWidget {
  const _Informacion({
    required this.boleta,
  });

  final Boleta boleta;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 20,left: 20,bottom: 20,),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MostrarInformacion(
            titulo: 'Jefe familia', 
            contenido: boleta.jefeFamilia.nombre
          ),
          MostrarInformacion(
            titulo: 'No. Viivenda', 
            contenido: boleta.vivienda.noVivienda.toString()
          ),
          MostrarInformacion(
            titulo: 'No. Miembros Familia', 
            contenido: boleta.familia.length.toString()
          ),
        ],
      ),
    );
  }
}