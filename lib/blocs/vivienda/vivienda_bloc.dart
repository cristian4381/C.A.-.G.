import 'package:bloc/bloc.dart';

import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/services/vivienda_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


part 'vivienda_event.dart';
part 'vivienda_state.dart';

class ViviendaBloc extends Bloc<ViviendaEvent, ViviendaState> {
  //final CensoServices censoServices = CensoServices();
  final ViviendaServices viviendaServices = ViviendaServices();

  ViviendaBloc() : super(
    ViviendaState(
      vivienda: Vivienda(
        noVivienda        : 0, 
        cielo             : '', 
        ventilacion       : '',
        iluminacion       : '', 
        piso              : 0, 
        pared             : 0, 
        techo             : 0, 
        ambiente          : 0, 
        ubicacionCocina   : 0, 
        tipoCocina        : 0, 
        tenencia          : 0
      ),
      errores: const {
        'no_vivienda'      : false,
        'cielo'           : false,
        'ventilacion'     : false,
        'iluminacion'     : false,
        'piso'            : false,
        'pared'           : false,
        'techo'           : false,
        'ambiente'        : false,
        'ubicacion_cocina' : false,
        'tipo_cocina'      : false,
        'tenencia'        : false,
      }
    )
  ) {
    on<GuardarIformacionEvent>((event, emit) async {
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);

/*      if(event.informacion['no_vivienda'] == 0){
        datosCorrecto = false;
         errores['no_vivienda']=true;
      }else{
        errores['no_vivienda']=false;
      }
*/
      if(event.informacion['cielo'] == ''){
        datosCorrecto = false;
        errores['cielo']=true;
      }else{
        errores['cielo']=false;
      }

      if(event.informacion['ventilacion'] == ''){
        datosCorrecto = false;
        errores['ventilacion']=true;
      }else{
        errores['ventilacion']=false;
      }

      if(event.informacion['iluminacion'] == ''){
        datosCorrecto = false;
        errores['iluminacion']=true;
      }else{
        errores['iluminacion']=false;
      }

      if(event.informacion['piso'] == 0){
        datosCorrecto = false;
         errores['piso']=true;
      }else{
        errores['piso']=false;
      }

      if(event.informacion['pared'] == 0){
        datosCorrecto = false;
         errores['pared']=true;
      }else{
        errores['pared']=false;
      }

      if(event.informacion['techo'] == 0){
        datosCorrecto = false;
         errores['techo']=true;
      }else{
        errores['techo']=false;
      }

      if(event.informacion['ambiente'] == 0){
        datosCorrecto = false;
         errores['ambiente']=true;
      }else{
        errores['ambiente']=false;
      }

      if(event.informacion['ubicacion_cocina'] == 0){
        datosCorrecto = false;
         errores['ubicacion_cocina']=true;
      }else{
        errores['ubicacion_cocina']=false;
      }

      if(event.informacion['tipo_cocina'] == 0){
        datosCorrecto = false;
         errores['tipo_cocina']=true;
      }else{
        errores['tipo_cocina']=false;
      }

      if(event.informacion['tenencia'] == 0){
        datosCorrecto = false;
         errores['tenencia']=true;
      }else{
        errores['tenencia']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES VIVIENDA: $errores');
        add(ActualizarErroresEvent(errores));
      }else{
        debugPrint('GUARDANDO DATOS VIVIENDA');
        Vivienda vivienda = state.vivienda.copyWith(
          ambiente: event.informacion['ambiente'],
          cielo: event.informacion['cielo'],
          iluminacion: event.informacion['iluminacion'],
          pared: event.informacion['pared'],
          piso: event.informacion['piso'],
          techo: event.informacion['techo'],
          tenencia: event.informacion['tenencia'],
          tipoCocina: event.informacion['tipo_cocina'],
          ubicacionCocina: event.informacion['ubicacion_cocina'],
          ventilacion: event.informacion['ventilacion'],
        );
        await viviendaServices.guardarViviena(vivienda);

        emit(state.copyWith(
          vivienda: vivienda,
          errores: errores,
          datosCorrectos: true
        ));
      }
    });
    on<ActualizarErroresEvent>((event, emit) => emit(state.copyWith(errores: event.errores)));
    on<DatosCorrectosEvent>((event, emit) => emit(state.copyWith(datosCorrectos: false)));
    on<EliminarViviendaEvent>((event, emit) async {
      emit(state.copyWith(
        vivienda: await viviendaServices.eliminarVIvienda()
      ));
    });
    on<CargarDatosEvent>((event, emit) {
      Vivienda vivienda = viviendaServices.existeVivienda! ? viviendaServices.vivienda! : state.vivienda;
      emit(
      state.copyWith(
        ambientes: event.ambientes,
        pared: event.pared,
        piso: event.piso,
        techo: event.techo,
        tenencia: event.tenencia,
        tipoCocina: event.tipoCocina,
        ubicacionCocina: event.ubicacionCocina,
        vivienda: vivienda,
      )
      );
    });
    on<ErrorNoVivienda>((event, emit) {
      Map<String, bool> errores= Map.from(state.errores);
      errores['no_vivienda']=true;
      emit(state.copyWith(errores: errores));
    });
    on<GuardarNoViviendaEvent>((event, emit) async {
      Map<String, bool> errores= Map.from(state.errores);
      if(event.noVivienda == 0){
        errores['no_vivienda']=true;
        emit(state.copyWith(errores: errores));
      }else{
        Vivienda vivienda = state.vivienda.copyWith(noVivienda: event.noVivienda);
        await viviendaServices.guardarViviena(vivienda);
        errores['no_vivienda']=false;
        emit(state.copyWith(
          errores: errores,
          vivienda: vivienda
        ));
      }
    });
    _init();
  }

  Future<void> _init() async {
    debugPrint('CARGADO DATOS VIVIENDA');

    await viviendaServices.cargarDatos();

    add(CargarDatosEvent(
       ambientes: viviendaServices.ambientes!,
       pared: viviendaServices.pared!,
       piso: viviendaServices.piso!,
       techo: viviendaServices.techo!,
       tenencia: viviendaServices.tenencia!,
       tipoCocina: viviendaServices.tipoCocina!,
       ubicacionCocina: viviendaServices.ubicacionCocina!,

      )
    );
  }
}
