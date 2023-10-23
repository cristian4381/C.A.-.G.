import 'package:ca_and_g/blocs/fumulario/formulario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_and_g/blocs/vivienda/vivienda_bloc.dart';
import 'package:ca_and_g/widgets/widgets.dart';

class ViviendaView extends StatelessWidget {

  const ViviendaView({
    Key? key, 
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final noVivienda= TextEditingController();
    Map<String, dynamic> vivienda = {};
    return BlocListener<ViviendaBloc, ViviendaState>(
      listener: (context, state) {
        if(state.datosCorrectos){
          debugPrint('AVANAZAR STEP');
          BlocProvider.of<FormularioBloc>(context).add(IncrementStep());
          BlocProvider.of<ViviendaBloc>(context).add(DatosCorrectosEvent());
        }
      },
      child: BlocBuilder<ViviendaBloc, ViviendaState>(
          builder: (context, state) {
            if(vivienda.isEmpty){
              vivienda = Map.from(state.vivienda.toJson());
              noVivienda.text = state.vivienda.noVivienda.toString();
            }
            
            return Card(
              child: ListTile(
                title: const LabelCategoryForm(
                  titulo: "Vivienda", 
                ),
                subtitle: Column(
                  children: [
                    /*CustomInput(
                      hintText: 'Ingrese el No. Casa', 
                      prefix: Icons.home_outlined, 
                      textController: noVivienda, 
                      nota: 'NO. Vivienda',
                      mostrarError: state.errores['no_vivienda']!,
                      keyboardType: TextInputType.number,
                    ),*/
                    Dropdown(
                      options: state.pared, 
                      titulo: 'Pared', 
                      onChanged: ( value){
                        vivienda['pared'] = value;
                      },
                      initialValue: state.vivienda.pared,
                      mostrarError: state.errores['pared']!,
                    ),
                    Dropdown(
                      options: state.piso, 
                      titulo: 'Piso', 
                      onChanged: ( value){
                        vivienda['piso'] = value;
                      },
                      initialValue: state.vivienda.piso,
                      mostrarError: state.errores['piso']!,
                    ),
                    Dropdown(
                      options: state.techo, 
                      titulo: 'Techo', 
                      onChanged: ( value){
                        vivienda['techo'] = value;
                      },
                      initialValue: state.vivienda.techo,
                      mostrarError: state.errores['techo']!,
                    ),
                    Dropdown(
                      options: state.cielo, 
                      titulo: 'Cielo', 
                      onChanged: ( value){
                        vivienda['cielo'] = value;
                      },
                      initialValue: state.vivienda.cielo,
                      mostrarError: state.errores['cielo']!,
                    ),
                    Dropdown(
                      options: state.ambientes, 
                      titulo: 'Ambientes', 
                      onChanged: ( value){
                        vivienda['ambiente'] = value;
                      },
                      initialValue: state.vivienda.ambiente,
                      mostrarError: state.errores['ambiente']!,
                    ),
                    Dropdown(
                      options: state.ubicacionCocina, 
                      titulo: 'Ubicacion Cocina', 
                      onChanged: ( value){
                        vivienda['ubicacion_cocina'] = value;
                      },
                      initialValue: state.vivienda.ubicacionCocina,
                      mostrarError: state.errores['ubicacion_cocina']!,
                    ),
                      Dropdown(
                      options: state.tipoCocina, 
                      titulo: 'Tipo Cocina', 
                      onChanged: ( value){
                        vivienda['tipo_cocina'] = value;
                      },
                      initialValue: state.vivienda.tipoCocina,
                      mostrarError: state.errores['tipo_cocina']!,
                    ),
                    Dropdown(
                      options: state.ventilacion, 
                      titulo: 'Ventilacion', 
                      onChanged: ( value){
                        vivienda['ventilacion'] = value;
                      },
                      initialValue: state.vivienda.ventilacion,
                      mostrarError: state.errores['ventilacion']!,
                    ),
                    Dropdown(
                      options: state.iluminacion, 
                      titulo: 'Iluminacion', 
                      onChanged: ( value){
                        vivienda['iluminacion'] = value;
                      },
                      initialValue: state.vivienda.iluminacion,
                      mostrarError: state.errores['iluminacion']!,
                    ),
                    Dropdown(
                      options: state.tenencia, 
                      titulo: 'Tenencia', 
                      onChanged: ( value){
                        vivienda['tenencia'] = value;
                      },
                      initialValue: state.vivienda.tenencia,
                      mostrarError: state.errores['tenencia']!,
                    ),
                    Acciones(
                      finalizar: false, 
                      volver: true, 
                      onPressed: () async{
                        //vivienda['no_vivienda'] = int.tryParse(noVivienda.text) ?? 0;
                        BlocProvider.of<ViviendaBloc>(context,listen: false).add(GuardarIformacionEvent(vivienda));
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