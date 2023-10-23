
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../blocs/fumulario/formulario_bloc.dart';
import '../blocs/gestion_ambiental/gestion_ambiental_bloc.dart';
import '../widgets/widgets.dart';


class GestionAmbiental extends StatelessWidget {

  const GestionAmbiental({
    super.key, 

  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> gestionAmbintal = {};

    return BlocListener<GestionAmbientalBloc, GestionAmbientalState>(
      listener: (context, state) {
        if(state.datosCorrectos){
          debugPrint('AVANAZAR STEP');
          BlocProvider.of<FormularioBloc>(context).add(IncrementStep());
          BlocProvider.of<GestionAmbientalBloc>(context,listen: false).add(DatosCorrectosEvent());
        }
      },
      child: BlocBuilder<GestionAmbientalBloc, GestionAmbientalState>(
          builder: (context, state) {
            if(gestionAmbintal.isEmpty){
              gestionAmbintal = Map.from(state.gestionAmbiental.toJson());
            }
            
            return Card(
              child: ListTile(
                title: const LabelCategoryForm(
                  titulo: "Gestion Ambiental", 
                ),
                subtitle: Column(
                  children: [
                    Dropdown(
                      options: state.abastecimientoAgua, 
                      titulo: 'Abastecimiento de agua', 
                      onChanged: ( valor){
                        gestionAmbintal['abastecimiento_agua']= valor;
                      },
                      mostrarError: state.errores['abastecimiento_agua']!,
                      initialValue: state.gestionAmbiental.abastecimientoAgua,
                    ) ,
                    Dropdown(
                      options: state.disposicionAguasReciduales, 
                      titulo: 'Disposicion de aguas reciduales', 
                      onChanged: ( valor){
                        gestionAmbintal['disposicion_aguas_reciduales'] = valor;
                      },
                      mostrarError: state.errores['disposicion_aguas_reciduales']!,
                      initialValue: state.gestionAmbiental.disposicionAguasReciduales,
                    ),
                    Dropdown(
                      options: state.disposicionDesechosSolidos, 
                      titulo: 'Disposicion de desechos solidos', 
                      onChanged: ( valor){
                        gestionAmbintal['disposicion_desechos_solidos'] = valor;
                      },
                      mostrarError: state.errores['disposicion_desechos_solidos']!,
                      initialValue: state.gestionAmbiental.disposicionDesechosSolidos,
                    ),
                    Dropdown(
                      options: state.disposicionExcreta, 
                      titulo: 'Disposicion de excretas', 
                      onChanged: ( valor){
                        gestionAmbintal['disposicion_excretas']= valor;
                      },
                      mostrarError: state.errores['disposicion_excretas']!,
                      initialValue: state.gestionAmbiental.disposicionExcretas,
                    ),
                    Acciones(
                      finalizar: false, 
                      volver: true, 
                      onPressed: ()async{
    
                        BlocProvider.of<GestionAmbientalBloc>(context,listen: false).add(GuardarIformacionEvent(gestionAmbintal));
    
                      }
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}