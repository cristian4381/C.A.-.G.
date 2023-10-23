import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as permiso;

import '../../services/connectivity_services.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityServices connectivityServices = ConnectivityServices();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;
  StreamSubscription? gpsServiceSubscription;

  ConnectivityBloc() : super(const ConnectivityState(isGpsEnabled: false, isGpsPermissionGranted: false)) {

    on<DisconnectedInternetEvent>((event, emit) => emit(state.copyWith(
      isConnectedToInternet: false, 
      isConnectedToServer: false
    )));

    on<ConnectedToInternetEvent>((event, emit) => emit(state.copyWith(
      isConnectedToInternet: true, 
      isConnectedToServer: event.serverConnect
    )));

    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      isGpsEnabled: event.isGpsEnabled,
      isGpsPermissionGranted: event.isGpsPermissionGranted,
      estado: event.estado
    )));

    on<UbicacionGuardadaEvent>((event, emit) => emit(state.copyWith(
      estado: 4,
      latitud: event.ubicacion['latitud'],
      longitud: event.ubicacion['longitud'],
    )));
    on<EliminarUbicacionGuardadaEvent>((event, emit) async {
      await connectivityServices.eliminarUbicacion();
      await _gpsEstado();

      emit(state.copyWith(
        longitud: 0,
        latitud: 0
      ));
    });
    on<GuardarUbicacionEvent>((event, emit) async {
      final position = await Geolocator.getCurrentPosition();
      debugPrint('Latitud: ${position.latitude}, Longitud: ${position.longitude}');

      Map<String,double> ubicacion = {
        'latitud':position.latitude,
        'longitud':position.longitude,
      };

      await connectivityServices.guardarUbicacion(ubicacion);

      emit(state.copyWith(
        estado: 4,
        latitud: position.latitude,
        longitud: position.longitude,
      ));

      gpsServiceSubscription?.cancel();
    });

    on<EliminarUbicacionEvent>((event, emit) async {
      await _gpsEstado();

      emit(state.copyWith(
        longitud: 0,
        latitud: 0
      ));
    });

    _init();
  }


  Future <void> _init() async{

    final connection = Connectivity();
    bool connectivity = false;

    connectivitySubscription = connection.onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        add(DisconnectedInternetEvent());
        debugPrint('Se ha perdido la conexión a Internet');
        connectivity = false;
      } else {
        connectivity = await ConnectivityServices.serverConnection();
        add(ConnectedToInternetEvent(connectivity));
        debugPrint('conexion: internet = true , servidor = $connectivity');
      }
    });

    if(await connectivityServices.existeUbicacion()){
      add(UbicacionGuardadaEvent(ubicacion: await connectivityServices.recuperarUbicacion()));
      return;
    }


    debugPrint('####### NO HAY UBICACION PREVIA #######');

    await _gpsEstado();

  }

  Future<void> _gpsEstado() async {
    int estado = 0;

    final gpsInitStatus = await Future.wait([
        _checkGpsStatus(),
        _isPermissionGranted(),
    ]);


    if(gpsInitStatus[0] && gpsInitStatus[1]){
      estado = 3;
    }
    if(gpsInitStatus[0] && !gpsInitStatus[1]){
      estado = 2;
    }
    if(!gpsInitStatus[0] ){
      estado = 1;
    }

    add( GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
      estado: estado
    ));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await permiso.Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {

    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true : false;
      debugPrint('####### GPS ACTIVO $isEnabled #######');
      int estado = 0;

      if(state.isGpsPermissionGranted){
        estado = 3;
      }else{
        estado = 2;
      }


      add( GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
        estado: isEnabled ?  estado : 1,
      ));
    });

    return isEnable;  
  }


  Future<void> askGpsAccess() async {

    final status = await permiso.Permission.location.request();

    switch ( status ) {
      case permiso.PermissionStatus.granted:
        add( 
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, 
            isGpsPermissionGranted: true,
            estado: 3
          ) 
        );
        break;
      
      case permiso.PermissionStatus.denied:
      case permiso.PermissionStatus.restricted:
      case permiso.PermissionStatus.limited:
      case permiso.PermissionStatus.permanentlyDenied:
      case permiso.PermissionStatus.provisional:
        add( 
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, 
            isGpsPermissionGranted: false,
            estado: 2
          )
        );
        permiso.openAppSettings();
    }

  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}


