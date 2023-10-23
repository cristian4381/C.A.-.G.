import 'package:bloc/bloc.dart';
import 'package:ca_and_g/models/models.dart';

import 'package:ca_and_g/services/familia_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'familia_event.dart';
part 'familia_state.dart';

class FamiliaBloc extends Bloc<FamiliaEvent, FamiliaState> {

  final FamiliaService familiaService = FamiliaService();
  FamiliaBloc() : super( const FamiliaState(
    errores: {
      'nombre'           : false,
      'fecha_nacimiento' : false,
      'sexo'             : false,
      'no_Familia'       : false,
    }
  )) {
    on<GuardarIformacionEvent>((event, emit) async{
      debugPrint('GUARDAR DATOS FAMILIA ${event.informacion}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);
      if(event.informacion['nombre']==''){
        datosCorrecto = false;
        errores['nombre']=true;
      }else{
        errores['nombre']=false;
      }
      if(event.informacion['fecha_nacimiento'] == ''){
        datosCorrecto = false;
        errores['fecha_nacimiento']=true;
      }else{
        errores['fecha_nacimiento']=false;
      }
      if(event.informacion['sexo'] == ''){
        datosCorrecto = false;
        errores['sexo']=true;
      }else{
        errores['sexo']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES FAMILIA: $errores');
        emit(state.copyWith(errores: errores));
      }else{
        Persona miembro = Persona.fromJson(event.informacion);

        debugPrint('DATOS FAMILIAR: $miembro');
        await familiaService.actualizarListafamilia(miembro);
        
        emit(state.copyWith(
          familiares: [...state.familiares, miembro],
          errores: errores,
          avanzar: true,
          noFamilia: event.informacion['noFamilia'],
        ));
      }

    });
    on<AgregarFamiliarEvent>((event, emit) async {
      debugPrint('FAMILIAR A AGREGAR ${event.informacion}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);


      if(event.informacion['nombre']==''){
        datosCorrecto = false;
        errores['nombre']=true;
      }else{
        errores['nombre']=false;
      }
      if(event.informacion['fecha_nacimiento'] == ''){
        datosCorrecto = false;
        errores['fecha_nacimiento']=true;
      }else{
        errores['fecha_nacimiento']=false;
      }
      if(event.informacion['sexo'] == ''){
        datosCorrecto = false;
        errores['sexo']=true;
      }else{
        errores['sexo']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES JEFE FAMILIA: $errores');
        emit(state.copyWith(errores: errores));
      }else{
        Persona miembro = Persona.fromJson(event.informacion);
        
        debugPrint('DATOS FAMILIAR: $miembro');
        await familiaService.actualizarListafamilia(miembro);
        emit(state.copyWith(
          familiares: [...state.familiares, miembro],
          errores: errores,
          otroFamilar: true
        ));
      }
    });
    on<EliminarFamiliarEvent>((event, emit) async {
      await familiaService.eliminarMiembroFamilia(event.index);
      emit(
        state.copyWith(
          familiares: familiaService.familia
        )
      );

    });
    on<EliminarFamiliaEvent>((event, emit) async {
      await familiaService.eliminarListaFamilia();
      emit(
        state.copyWith(
          familiares: [],
          noFamilia: 0
        )
      );
    });
    on<AvanzarEvent>((event, emit) {
      debugPrint('VALOR ESTADO DE AVANZAR EVENT => ${state.avanzar}');
      debugPrint('VALOR RECIBIDO DE AVANZAR EVENT => ${event.avanzar}');
      emit(state.copyWith(avanzar: event.avanzar));
    });
    on<AgregarOtroFamiliarEvent>((event, emit) => emit(state.copyWith(otroFamilar: event.otroFamiliar)));

    on<GuardarNoFamiliaEvent>((event, emit) async {
      debugPrint('FAMILIAR A NO. FAMILIA ${event.noFamilia}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);

      if(event.noFamilia == 0){
        datosCorrecto = false;
        errores['no_Familia']=true;
      }else{
        errores['no_Familia']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES FAMILIA: $errores');
        emit(state.copyWith(errores: errores));
      }else{

        
        debugPrint('No. Familia: ${event.noFamilia}');
        await familiaService.guardarNoFamilia(event.noFamilia);
        emit(state.copyWith(
          noFamilia: event.noFamilia,
          errores: errores
        ));
      }
    });
    on<CargarDatos>((event, emit) {

      List<Persona> familiares = familiaService.existenDatos!
      ? familiaService.familia! 
      : state.familiares;

      emit(
        state.copyWith(
          familiares: familiares,
          escolaridad: event.escolaridad,
          noFamilia: familiaService.noFamilia
        )
      );
    });
    on<ErroNoFamiliaEvent>((event, emit) {
      Map<String, bool> errores= Map.from(state.errores);
      errores['no_Familia']=true;
      emit(state.copyWith(errores: errores));
    });
    _init();
  }

  Future<void> _init() async {
    debugPrint('CARGANDO DATOS FAMILIA');

    await familiaService.cargarDatos();

    add(CargarDatos(

      escolaridad: familiaService.escolaridad!,
    ));


  }
}

