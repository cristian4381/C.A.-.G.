import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:ca_and_g/blocs/blocs.dart';
import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/widgets/widgets.dart';

class MiembroView extends StatefulWidget {
  const MiembroView({super.key});

  @override
  State<MiembroView> createState() => _MiembroViewState();
}

class _MiembroViewState extends State<MiembroView> {
  int edad = 0;

  Map<String, dynamic> embarazada = {};


  Map<String, dynamic> integrante ={
    'nombre': '',
    'sexo': '',
    'fecha_nacimiento': DateTime.now().toString(),
    'ocupacion': '',
    'sabe_leer': '',
    'escolaridad': 1
  };

  final nombre          = TextEditingController();
  final ocupacion       = TextEditingController();
  final tiempoGestacion = TextEditingController();
  final lugar           = TextEditingController();
  final telefono        = TextEditingController();
  final noFamilia       = TextEditingController();

  bool formularioActivo = false;

  void limparDatos(){
    
    embarazada = {};

    nombre.text = '';
    ocupacion.text = '';
    tiempoGestacion.text = '';
    lugar.text = '';
    telefono.text = '';
    edad = 0; 
    integrante = {
      'nombre': '',
      'sexo': '',
      'fecha_nacimiento': DateTime.now().toString(),
      'ocupacion': '',
      'sabe_leer': '',
      'escolaridad': 1
    };

    personaEmbarazada.currentState?.clearSelection();
    sexo.currentState?.clearSelection();
    personaEmbarazada.currentState?.clearSelection();
  }

  void obtenerDatos(){

    integrante['nombre'] = nombre.text;
    integrante['ocupacion'] = ocupacion.text;

    if(tiempoGestacion.text.trim().isNotEmpty){
      embarazada['tiempo_gestacion'] = tiempoGestacion.text;
    }
    if(lugar.text.trim().isNotEmpty){
      embarazada['lugar_control'] = lugar.text;
    }
    
    if(telefono.text.trim().isNotEmpty){
      embarazada['telefono'] = telefono.text;
    }
    


    integrante['embarazada'] = embarazada;
  }

  final GlobalKey<CustomDropDownState> sexo = GlobalKey<CustomDropDownState>();
  final GlobalKey<CustomDropDownState> sabeLeer = GlobalKey<CustomDropDownState>();
  final GlobalKey<CustomDropDownState> personaEmbarazada = GlobalKey<CustomDropDownState>();

  @override
  Widget build(BuildContext context) {
    final FamiliaBloc familiaBloc =  BlocProvider.of<FamiliaBloc>(context,listen: false);
    return BlocListener<FamiliaBloc, FamiliaState>(
      listener: (context, state) {
        if(state.otroFamilar){
          if(!formularioActivo){
            formularioActivo = true;
          }
          familiaBloc.add(const AgregarOtroFamiliarEvent(false));
        }
        if(state.avanzar){
          debugPrint('avanzar => familia');
          limparDatos();
          BlocProvider.of<FormularioBloc>(context).add(IncrementStep());
          familiaBloc.add(const AvanzarEvent(false));
        }
      },
      child: BlocBuilder<FamiliaBloc, FamiliaState>(
          builder: (context, state) {
            if(noFamilia.text.trim().isEmpty && state.noFamilia>0){
              noFamilia.text = state.noFamilia.toString();
            }
            
            return Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const LabelCategoryForm(titulo: 'Familia'),
                    if(state.familiares.isNotEmpty)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.familiares.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Persona persona = state.familiares[index];
                          return DatosFamiliar(familiar: persona, nofamilar: index+1,);
                        },
                      ),

                    if(formularioActivo)
                      _formulario(state),
                      
                    _accionesFormulario(familiaBloc, state),
                     
                    Acciones(
                      finalizar: false, 
                      volver: true, 
                      onPressed: ()async{
                        int _noFamilia =  int.tryParse(noFamilia.text) ?? 0;
                        if(formularioActivo){
                          obtenerDatos();
                          integrante['noFamilia'] = _noFamilia;
                          familiaBloc.add(GuardarIformacionEvent(integrante));
                          
                        }else{
                          //familiaBloc.add(GuardarNoFamiliaEvent(_noFamilia));
                          debugPrint('#######FORMULARIO NO ACTIVO ${state.avanzar} #####');
                          familiaBloc.add(AvanzarEvent(true));
                        }
                        
                      }
                    ),
                  ],
                ),
              )
            );
          },
        ),
    );
  }

  Column _formulario(FamiliaState state) {
    return Column(
      children: [
        CustomInput(
          hintText: 'Ingrese el nombre', 
          prefix: Icons.person, 
          textController: nombre,
          nota: 'Nombre',
          mostrarError: state.errores['nombre']!,
        ),
        CustomDropDown(
          options: state.sexo, 
          onChanged: ( valor){
            integrante['sexo'] = valor; 
          }, 
          titulo: 'sexo',
          key: sexo,
        ),
        DatePicker(
          onDateSelected: (valor){
            DateTime fechaActual = DateTime.now(); // La fecha actual
    
            Duration diferencia = fechaActual.difference(valor!);
            edad = (diferencia.inDays / 365).floor();
            setState(() {
              edad = (diferencia.inDays / 365).floor();
              integrante['fecha_nacimiento'] = valor.toString();
            });
          },
          hintText: 'Fecha Nacimiento',
          nota: 'Fecha Nacimiento',
          mostrarError: state.errores['fecha_nacimiento']!,
        ),
        if(edad>15)
          CustomInput(
            hintText: 'Ingrese la ocupacion', 
            prefix: Icons.work, 
            textController: ocupacion,
            nota: 'Ocupacion',
          ),
        if(edad>5)
          CustomDropDown(
            options: state.sabeLeer, 
            onChanged: ( valor){
              
              setState(() {
                integrante['sabe_leer'] = valor; 
              });
            }, 
            titulo: 'Sabe leer',
            key: sabeLeer,
          ),
        if(integrante.containsKey('sabe_leer') && integrante['sabe_leer'] == 'si')
          Dropdown(
            options: state.escolaridad, 
            onChanged: ( valor){
              integrante['escolaridad'] = valor; 
            }, 
            titulo: 'Escolaridad',
          ),
        if(integrante.containsKey('sexo') && integrante['sexo'] == 'Femenino')
        CustomDropDown(
            options: state.sabeLeer, 
            onChanged: ( valor){
              
              setState(() {
                embarazada['embarazada'] = valor; 
              });
            }, 
            titulo: 'Embaraza',
            key: personaEmbarazada,
          ),
        if(embarazada.containsKey('embarazada') && embarazada['embarazada'] == 'si')
          DatosEmbarazada(
            lugar: lugar,
            onChanged: (value) {
              embarazada['lleva_control'] = value;
            },
            telefono: telefono,
            tiempoGestacion: tiempoGestacion
          ),
        const SizedBox(height: 16)
      ],
    );
  }

  Row _accionesFormulario(FamiliaBloc familiaBloc, FamiliaState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(formularioActivo)
          CustomButton(
            texto: 'Cancelar', 
            onPressed: () => setState(() {formularioActivo = false;}), 
            color: Colors.red
          ),
        const SizedBox(width: 10),
        CustomButton(
          onPressed: () {
            if(formularioActivo){
              obtenerDatos();
              familiaBloc.add(AgregarFamiliarEvent(integrante));
              limparDatos();

              
              return;
            }
            familiaBloc.add(const AgregarOtroFamiliarEvent(true));
          },
          color: Colors.blue,
          texto: state.familiares.isEmpty ? 'Agregar Familar' : 'Agregar otro \nfamiliar',
        ),
      ]
    );
  }
}





