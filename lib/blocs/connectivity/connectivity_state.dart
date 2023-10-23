part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  final bool isConnectedToInternet;
  final bool isConnectedToServer;
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  final double latitud;
  final double longitud;

  final int estado;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const ConnectivityState({
    this.isConnectedToInternet = false, 
    this.isConnectedToServer = false, 
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted,
    this.latitud = 0,
    this.longitud = 0,
    this.estado = 1,
  });

  ConnectivityState copyWith({
    bool? isConnectedToInternet,
    bool? isConnectedToServer,
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    double? latitud,
    double? longitud,
    int? estado,
  }) => ConnectivityState(
    isConnectedToInternet: isConnectedToInternet ?? this.isConnectedToInternet, 
    isConnectedToServer: isConnectedToServer ?? this.isConnectedToServer, 
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted,
    latitud : latitud ?? this.latitud,
    longitud : longitud ?? this.longitud,
    estado: estado ?? this.estado
  );
  
  @override
  List<Object?> get props => [
    isConnectedToInternet, 
    isConnectedToServer, 
    isGpsEnabled,
    isGpsPermissionGranted,
    latitud,
    longitud,
    estado
  ];

  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
}


