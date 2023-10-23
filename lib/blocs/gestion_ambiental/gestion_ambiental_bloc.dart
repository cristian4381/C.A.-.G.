import 'package:bloc/bloc.dart';

import 'package:ca_and_g/models/models.dart';

import 'package:ca_and_g/services/gestion_ambiental_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'gestion_ambiental_event.dart';
part 'gestion_ambiental_state.dart';

class GestionAmbientalBloc extends Bloc<GestionAmbientalEvent, GestionAmbientalState> {
  //final CensoServices censoServices = CensoServices();
  final GestionAmbientalServices  gestionAmbientalServices = GestionAmbientalServices();
  GestionAmbientalBloc() : super(
    GestionAmbientalState(
      gestionAmbiental: GestionAmbiental(
        abastecimientoAgua: 0, 
        disposicionExcretas: 0, 
        disposicionAguasReciduales: 0, 
        disposicionDesechosSolidos: 0
      ), 
      errores: const {
        'abastecimiento_agua' : false,
        'disposicion_excretas' : false,
        'disposicion_aguas_reciduales' : false,
        'disposicion_desechos_solidos' : false,
      })
  ) {
    on<GuardarIformacionEvent>((event, emit) async {
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);
      if(event.informacion['abastecimiento_agua'] == 0){
        datosCorrecto = false;
         errores['abastecimiento_agua']=true;
      }else{
        errores['abastecimiento_agua']=false;
      }

      if(event.informacion['disposicion_excretas'] == 0){
        datosCorrecto = false;
         errores['disposicion_excretas']=true;
      }else{
        errores['disposicion_excretas']=false;
      }

      if(event.informacion['disposicion_aguas_reciduales'] == 0){
        datosCorrecto = false;
         errores['disposicion_aguas_reciduales']=true;
      }else{
        errores['disposicion_aguas_reciduales']=false;
      }

      if(event.informacion['disposicion_desechos_solidos'] == 0){
        datosCorrecto = false;
         errores['disposicion_desechos_solidos']=true;
      }else{
        errores['disposicion_desechos_solidos']=false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES GESTION AMBIENTAL: $errores');
        add(ActualizarErroresEvent(errores));
      }else{
        debugPrint('GUARDANDO DATOS GESTION AMBIENAL');
        GestionAmbiental gestionAmbiental = GestionAmbiental.fromJson(event.informacion);
        await gestionAmbientalServices.guardarGestionAmbiental(gestionAmbiental);

        emit(state.copyWith(
          gestionAmbiental: gestionAmbiental,
          errores: errores,
          datosCorrectos: true
        ));
      }
    });
    
   
    on<CargarDatosEvent>((event, emit) {
      GestionAmbiental gestionAmbiental = gestionAmbientalServices.existeGestionAmbiental! 
      ? gestionAmbientalServices.gestionAmbiental! 
      : state.gestionAmbiental;
      
      emit(state.copyWith(
        abastecimientoAgua: event.abastecimientoAgua,
        disposicionAguasReciduales  : event.disposicionAguasReciduales,
        disposicionDesechosSolidos  : event.disposicionDesechosSolidos,
        disposicionExcreta          : event.disposicionExcreta,
        gestionAmbiental            : gestionAmbiental
      ));
    });
    on<EliminarGestionAmbientalEvent>((event, emit) async{
      emit(state.copyWith(
        gestionAmbiental: await gestionAmbientalServices.eliminarGestionAmbienta(),
      ));  
    });

    on<ActualizarErroresEvent>((event, emit) => emit(state.copyWith(errores: event.errores)));
    on<DatosCorrectosEvent>((event, emit) => emit(state.copyWith(datosCorrectos: false)));
    _init();
  }

  Future<void> _init() async {
    debugPrint('CARGADO DATOS GESTION AMBIENTAL');

    await gestionAmbientalServices.cargarDatos();
    //GestionAmbiental gestionAmbiental = await censoServices.buscarGestionAmbiental();
  
    //final informacion = await censoServices.recuperarInformacion();

    add(CargarDatosEvent(
      abastecimientoAgua         : gestionAmbientalServices.abastecimientoAgua!,
      disposicionAguasReciduales : gestionAmbientalServices.disposicionAguasReciduales!,
      disposicionDesechosSolidos : gestionAmbientalServices.disposicionDesechosSolidos!,
      disposicionExcreta         : gestionAmbientalServices.disposicionExcreta!,
      //gestionAmbiental           : gestionAmbiental,
    ));
  }
}
