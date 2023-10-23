import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/services/jefe_familia_services.dart';
import 'package:equatable/equatable.dart';

part 'jefe_familia_event.dart';
part 'jefe_familia_state.dart';

class JefeFamiliaBloc extends Bloc<JefeFamiliaEvent, JefeFamiliaState> {
  final JefeFamiliaServices jefeFamiliaServices = JefeFamiliaServices();


  JefeFamiliaBloc() : super(JefeFamiliaState(
    detalleJefeFamilia: JefeFamilia(
      estadoCivil        : 0, 
      religion           : 0, 
      procedencia        : 0
    ),
    jefeFamilia: Persona(
      nombre             : '', 
      sexo               : '', 
      fechaNacimiento    : DateTime.now(),
      escolaridad        : 0,
      ocupacion          : '',
      sabeLeer           : '',
    ),
    errores: const {
      'nombre'           : false,
      'fecha_nacimiento' : false,
      'ocupacion'        : false,
      'estado_civil'     : false,
      'religion'         : false,
      'procedencia'      : false,
      'sexo'             : false,
      'sabe_leer'        : false,
      'escolaridad'      : false,
      'noIntegrantes'    : false,
    },
    sexo: const {'Masculino': 'Masculino','Femenino': 'Femenino'},
    sabeLeer: const {'si': 'Si','no': 'No'},
  )) {
    on<GuardarIformacionEvent>((event, emit) async {
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);

      if(!event.informacion.containsKey('nombre') || event.informacion['nombre'] == ''){
        datosCorrecto = false;
        errores['nombre']=true;
      }else{
        errores['nombre']=false;
      }

      if(!event.informacion.containsKey('ocupacion') || event.informacion['ocupacion'] == ''){
        datosCorrecto = false;
        errores['ocupacion']=true;
      }else{
        errores['ocupacion']=false;
      }
      
      if(!event.informacion.containsKey('fecha_nacimiento') ){
        datosCorrecto = false;
        errores['fecha_nacimiento']=true;
      }else{
        errores['fecha_nacimiento']=false;
      }
      /*if(!event.informacion.containsKey('noIntegrantes') || event.informacion['noIntegrantes'] == 0){
        datosCorrecto = false;
         errores['noIntegrantes']=true;
      }else{
        errores['noIntegrantes']=false;
      }*/

      if(!event.informacion.containsKey('sexo') || event.informacion['sexo'] == ''){
        datosCorrecto = false;
         errores['sexo']=true;
      }else{
        errores['sexo']=false;
      }

      if(!event.informacion.containsKey('sabe_leer') || event.informacion['sabe_leer'] == ''){
        datosCorrecto = false;
         errores['sabe_leer']=true;
      }else{
        errores['sabe_leer']=false;
      }

      if(!event.informacion.containsKey('escolaridad') || event.informacion['escolaridad'] == 0){
        datosCorrecto = false;
        errores['escolaridad']=true;
      }else{
        errores['escolaridad']=false;
      }


      if(!event.informacion.containsKey('estado_civil') || event.informacion['estado_civil'] == 0){
        datosCorrecto = false;
        errores['estado_civil']=true;
      }
      else{
        errores['estado_civil']=false;
      }
      
      if(!event.informacion.containsKey('religion') || event.informacion['religion'] == 0){
        datosCorrecto = false;
        errores['religion']=true;
      }else{
        errores['religion']=false;
      }

      if(!event.informacion.containsKey('procedencia') || event.informacion['procedencia'] == 0){
        datosCorrecto = false;
        errores['procedencia']=true;
      }else{
        errores['procedencia']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES JEFE FAMILIA: $errores');
        add(ActualizarErroresEvent(errores));
      }else{
        //Map<String,dynamic> em = {};
        debugPrint('GUARDANDO DATOS JEFE FAMILIA');
        debugPrint('datos ${event.informacion}');
        //event.informacion['embarazada']= em;
        Persona jefeFamilia = Persona.fromJson(event.informacion);
        JefeFamilia detalleJefeFamilia = JefeFamilia.fromJson(event.informacion);
        
        await jefeFamiliaServices.guardarDatos(jefeFamilia,detalleJefeFamilia);
        //await censoServices.guardarJefeFamilia(jefeFamilia);
        //await censoServices.guardarDetalleJefeFamilia(detalleJefeFamilia);
        //await censoServices.guardarNoIntegrantes(event.informacion['noIntegrantes']);

        emit(state.copyWith(
          detalleJefeFamilia: detalleJefeFamilia,
          jefeFamilia: jefeFamilia,
          datosCorrectos: true,
          errores: errores
        ));
      }
      
    });

    on<DatosCorrectosEvent>((event, emit) => emit(state.copyWith(datosCorrectos: false)));
    on<ActualizarErroresEvent>((event, emit) => emit(state.copyWith(errores: event.errores)));
    on<LimpiarDatosvent>((event, emit) => emit(state.copyWith(limpiarDatos: false)));
    on<CargarDatosEvent>((event, emit) {

      Persona jefeFamilia = jefeFamiliaServices.existenJefeFamilia! 
      ? jefeFamiliaServices.jefeFamilia! 
      : state.jefeFamilia;

      JefeFamilia detalleJefeFamilia =  jefeFamiliaServices.existenDetalleFamilia! ? jefeFamiliaServices.detalleJefeFamilia! : state.detalleJefeFamilia;

      emit(
        state.copyWith(
          detalleJefeFamilia: detalleJefeFamilia,
          jefeFamilia : jefeFamilia,
          existenDetalleJefeFamilia: jefeFamiliaServices.existenDetalleFamilia,
          existenJefeFamilia: jefeFamiliaServices.existenJefeFamilia,
          estadoCivil : event.estadoCivil,
          procedencia : event.procedencia,
          religion    : event.religion,
          escolaridad : event.escolaridad
        )
      );
    });

    on<EliminarDatosvent>((event, emit) async{
      
      emit(
        state.copyWith(
          jefeFamilia: await jefeFamiliaServices.eliminarJefeFamilia(),
          detalleJefeFamilia: await jefeFamiliaServices.eliminarDetalleJefeFamilia(),
        )
      );

      
      //_init();
    });

    _init();
  }

  Future<void> _init() async {
    debugPrint('CARGADO DATOS JEFE FAMILIA');

    await jefeFamiliaServices.cargarDatos();

    add(CargarDatosEvent(

        estadoCivil : jefeFamiliaServices.estadoCivil!,
        procedencia : jefeFamiliaServices.procedencia!,
        religion    : jefeFamiliaServices.religion!,
        escolaridad : jefeFamiliaServices.escolaridad!,
      )
    );
  }
}
