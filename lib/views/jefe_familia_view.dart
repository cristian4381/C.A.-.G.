import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../blocs/fumulario/formulario_bloc.dart';
import '../blocs/jefe_familia/jefe_familia_bloc.dart';
import '../widgets/widgets.dart';


class JefeFamiliaView extends StatefulWidget {

  const JefeFamiliaView({
    super.key, 
  });

  @override
  State<JefeFamiliaView> createState() => _JefeFamiliaViewState();
}

class _JefeFamiliaViewState extends State<JefeFamiliaView> {
  final nombre      = TextEditingController();
  final ocupacion   = TextEditingController();
  final miembros    = TextEditingController();
  final tiempoGestacion = TextEditingController();
  final lugar           = TextEditingController();
  final telefono        = TextEditingController();
  final noFamilia       = TextEditingController();
  final GlobalKey<CustomDropDownState> personaEmbarazada = GlobalKey<CustomDropDownState>();
    
  Map<String, dynamic> jefeFamilia ={};
  Map<String, dynamic>? embarazada ;
  bool sexo = false;

  void obtenerDatos(){
    jefeFamilia['nombre'] = nombre.text;
    jefeFamilia['ocupacion'] = ocupacion.text;
    jefeFamilia['noIntegrantes'] = int.tryParse(miembros.text) ?? 0;

    if(tiempoGestacion.text.trim().isNotEmpty){
      embarazada!['tiempo_gestacion'] = tiempoGestacion.text;
    }
    if(lugar.text.trim().isNotEmpty){
      embarazada!['lugar_control'] = lugar.text;
    }
    
    if(telefono.text.trim().isNotEmpty){
      embarazada!['telefono'] = telefono.text;
    }
    


    jefeFamilia['embarazada'] = embarazada;
  }

  @override
  Widget build(BuildContext context) {
    final JefeFamiliaBloc jefeFamiliaBloc = BlocProvider.of<JefeFamiliaBloc>(context,listen: false);
    

    return  BlocListener<JefeFamiliaBloc, JefeFamiliaState>(
      listener: (context, state) {
        if(state.datosCorrectos){
          debugPrint('JEFE FAMILIA VIEW => AVANAZAR STEP');
          BlocProvider.of<FormularioBloc>(context).add(IncrementStep());
         jefeFamiliaBloc.add(DatosCorrectosEvent());
        }
      },
      child: BlocBuilder<JefeFamiliaBloc, JefeFamiliaState>(
          builder: (context, state) {
            nombre.text = state.jefeFamilia.nombre != '' ? state.jefeFamilia.nombre : nombre.text;
            ocupacion.text = state.jefeFamilia.ocupacion != '' ? state.jefeFamilia.ocupacion : ocupacion.text;
            if(embarazada == null){
              embarazada = state.jefeFamilia.embarazada ?? {};
            } 

            miembros.text = state.noFamiliares.toString();
            if(jefeFamilia.isEmpty){
              jefeFamilia.addAll(state.jefeFamilia.toJson());
              jefeFamilia.addAll(state.detalleJefeFamilia.toJson());
            }
            
            return ListTile(
              title: const LabelCategoryForm(
                titulo: "Jefe familia", 
              ),
              subtitle: Column(
                children: [
                  CustomInput(
                    hintText: 'Ingrese el nombre', 
                    prefix: Icons.person, 
                    textController: nombre, 
                    nota: 'Nombre',
                    mostrarError: state.errores['nombre']!,
                  ),
                  CustomInput(
                    hintText: 'Ingrese la ocupacion', 
                    prefix: Icons.work, 
                    textController: ocupacion,
                    nota: 'Ocupacion',
                    mostrarError: state.errores['ocupacion']!,
                  ),
                  Dropdown(
                    options: state.sexo, 
                    onChanged: ( valor){
                      jefeFamilia['sexo'] = valor; 
                      setState(() {
                        
                      });
                    }, 
                    titulo: 'Sexo',
                    mostrarError: state.errores['sexo']!,
                    initialValue: state.jefeFamilia.sexo,
                  ),
                  if(jefeFamilia.containsKey('sexo') && jefeFamilia['sexo'] == 'Femenino')
                    CustomDropDown(
                      options: state.sabeLeer, 
                      onChanged: ( valor){

                        setState(() {
                          embarazada!['embarazada'] = valor; 
                        });
                      }, 
                      titulo: 'Embaraza',
                      key: personaEmbarazada,
                    ),
                  if(embarazada!.containsKey('embarazada') && embarazada!['embarazada'] == 'si')
                    DatosEmbarazada(
                      lugar: lugar,
                      onChanged: (value) {
                        embarazada!['lleva_control'] = value;
                      },
                      telefono: telefono,
                      tiempoGestacion: tiempoGestacion
                    ),

                  DatePicker(
                    onDateSelected: (valor){
                      jefeFamilia['fecha_nacimiento'] = valor.toString(); 
                    },
                    hintText: 'Fecha Nacimiento',
                    nota: 'Fecha Nacimiento',
                    mostrarError: state.errores['fecha_nacimiento']!,
                  ),
                  
                  Dropdown(
                    options: state.sabeLeer, 
                    onChanged: ( valor){
                      jefeFamilia['sabe_leer'] = valor; 
                    }, 
                    titulo: 'Sabe leer/escribir',
                    mostrarError: state.errores['sabe_leer']!,
                    initialValue: state.jefeFamilia.sabeLeer,
                  ),
                  Dropdown(
                    options: state.escolaridad, 
                    onChanged: ( valor){
                      jefeFamilia['escolaridad'] = valor; 
                    }, 
                    titulo: 'Escolaridad',
                    mostrarError: state.errores['escolaridad']!,
                    initialValue: state.jefeFamilia.escolaridad,
                  ),
                  Dropdown(
                    options: state.estadoCivil, 
                    onChanged: ( valor){
                      jefeFamilia['estado_civil'] = valor; 
                    }, 
                    titulo: 'Estado civil',
                    mostrarError: state.errores['estado_civil']!,
                    initialValue: state.detalleJefeFamilia.estadoCivil,
                  ),
                  Dropdown(
                    options: state.religion, 
                    onChanged: ( valor){
                      jefeFamilia['religion'] = valor; 
                    }, 
                    titulo: 'Religion',
                    mostrarError: state.errores['religion']!,
                    initialValue: state.detalleJefeFamilia.religion,
                  ),
                  Dropdown(
                    options: state.procedencia, 
                    onChanged: ( valor){
                      jefeFamilia['procedencia'] = valor; 
                    }, 
                    titulo: 'Procedencia',
                    mostrarError: state.errores['procedencia']!,
                    initialValue: state.detalleJefeFamilia.procedencia,
                  ),
                  Acciones(
                    finalizar: false,
                    volver: true,
                    onPressed: () async{
                      obtenerDatos();

                     jefeFamiliaBloc.add(GuardarIformacionEvent(jefeFamilia));
                    },
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            );
          },
        ),
    );
  }
}