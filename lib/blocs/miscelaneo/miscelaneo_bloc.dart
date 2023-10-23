

import 'package:bloc/bloc.dart';
import 'package:ca_and_g/models/models.dart';

import 'package:ca_and_g/services/miscelaneos_services.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'miscelaneo_event.dart';
part 'miscelaneo_state.dart';

class MiscelaneoBloc extends Bloc<MiscelaneoEvent, MiscelaneoState> {

  final MiscelaneosServices miscelaneosServices = MiscelaneosServices();
  MiscelaneoBloc() : super( const MiscelaneoState(
    errores: {
      'tipo_mascota': false,
      'ubicacion' : false,
      'cantidad'  : false,
      'tipo' : false
    }
  )) {
    on<AgregarMascotaEvent>((event, emit) async{
      debugPrint('GUARDAR DATOS MASCOTA ${event.informacion}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);

      if(event.informacion['tipo_mascota'] == 0){
        datosCorrecto = false;
        errores['tipo_mascota'] = true;
      }else{
        errores['tipo_mascota'] = false;
      }

      if(event.informacion['ubicacion'] == ''){
        datosCorrecto = false;
        errores['ubicacion'] = true;
      }else{
        errores['ubicacion'] = false;
      }

      if(event.informacion['cantidad'] == 0){
        datosCorrecto = false;
        errores['cantidad'] = true;
      }else{
        errores['cantidad'] = false;
      }

      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES MASCOTA: $errores');
        emit(state.copyWith(errores: errores));
      }else{
        event.informacion['nombre_tipo_mascota'] = state.tiposMascotas[event.informacion['tipo_mascota']];
        debugPrint('Mascota ${event.informacion}');
        Mascota mascota = Mascota.fromJson(event.informacion);
        await miscelaneosServices.agregarMascota(mascota);
        emit(
          state.copyWith(
            errores: errores,
            mascotas: miscelaneosServices.mascotas
          )
        );
      }

      
    });

    on<AgregarEstablecimientoEvent>((event, emit) async{
      debugPrint('GUARDAR DATOS ESTABLECIMIENTO ${event.informacion}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);
      if(event.informacion['tipo']==0){
        datosCorrecto = false;
        errores['tipo'] = true;
      }else{
        errores['tipo'] = false;
      }
      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES ESTABLECIMIENTOS: $errores');
        emit(state.copyWith(errores: errores));
      }else{
        event.informacion['nombre'] = state.tiposEstablecimientos[event.informacion['tipo']];
        EstablecimientosPublicos establecimiento = EstablecimientosPublicos.fromJson(event.informacion);
        await miscelaneosServices.agregarEstablecimiento(establecimiento);
        emit(
          state.copyWith(
            errores: errores,
            establecimientosPublicos: miscelaneosServices.establecimientos,
          )
        );
      }
      
    });

    on<CargarDatosEvent>((event, emit) {

      List<Mascota> mascotas = miscelaneosServices.existeMascotas! 
      ? miscelaneosServices.mascotas! 
      : state.mascotas;
      
      List<EstablecimientosPublicos> establecimientos = miscelaneosServices.existeEstablecimientos! 
      ? miscelaneosServices.establecimientos! 
      : state.establecimientosPublicos;

      emit(
        state.copyWith(
          tiposEstablecimientos: event.tiposEstablecimientos,
          tiposMascotas: event.tiposMascotas,
          mascotas: mascotas,
          establecimientosPublicos: establecimientos,
        )
      );
    });

    on<EliminarMascotaEvent>((event, emit) async{
      //List<Mascota> mascotas = List.from(state.mascotas);
      //mascotas.removeAt(event.index);
      debugPrint('ELEIMINAR MASCOTA: ${event.index}');
      await miscelaneosServices.eliminarMascota(event.index);
      emit(
        state.copyWith(
          mascotas: miscelaneosServices.mascotas
        )
      );
    });
    on<EliminarEstablecimientoEvent>((event, emit) async{
      //List<EstablecimientosPublicos> establecimientos = List.from(state.establecimientosPublicos);
      //establecimientos.removeAt(event.index);
      debugPrint('ELEIMINAR ESTABLECIMIENTO: ${event.index}');
      await miscelaneosServices.eliminarEstablecimiento(event.index);
      emit(
        state.copyWith(
          establecimientosPublicos: miscelaneosServices.establecimientos,
        )
      );
    });

    on<EliminarDatosGuardados>((event, emit) async {
      
      emit(state.copyWith(
        mascotas: await miscelaneosServices.eliminarListaMascotas(),
        establecimientosPublicos: await miscelaneosServices.eliminarListaEstablecimientos(),
      ));
    });

    _init();
  }
  Future<void> _init()async{
    await miscelaneosServices.cargarDatos();
    //final informacion = await censoServices.recuperarInformacion();
    //final List<Mascota> mascotas = await censoServices.buscarMascotas();
    //final List<EstablecimientosPublicos> establecimientos = await censoServices.buscarEstablecimientos(); 
    add(
      CargarDatosEvent(
        tiposMascotas: miscelaneosServices.tiposMascotas!, 
        tiposEstablecimientos: miscelaneosServices.tiposEstablecimientos!,
        //establecimientosPublicos: establecimientos,
        //mascotas: mascotas,

      )
    );
  }
}
