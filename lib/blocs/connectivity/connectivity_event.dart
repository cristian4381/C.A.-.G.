part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectedToInternetEvent extends ConnectivityEvent{
  final bool serverConnect;

  const ConnectedToInternetEvent(this.serverConnect);
}
class DisconnectedInternetEvent extends ConnectivityEvent{}

class GpsAndPermissionEvent extends ConnectivityEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final int estado;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted,
    required this.estado,
  });
}

class UbicacionGuardadaEvent extends ConnectivityEvent{
  final Map<String,dynamic> ubicacion;

  const UbicacionGuardadaEvent({
    required this.ubicacion
  });
}

class GuardarUbicacionEvent extends ConnectivityEvent{}
class EliminarUbicacionEvent extends ConnectivityEvent{}
class EliminarUbicacionGuardadaEvent extends ConnectivityEvent{}