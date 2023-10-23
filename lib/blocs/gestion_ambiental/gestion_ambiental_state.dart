part of 'gestion_ambiental_bloc.dart';

class GestionAmbientalState extends Equatable {
  final Map<int,String> abastecimientoAgua;
  final Map<int,String> disposicionAguasReciduales;
  final Map<int,String> disposicionDesechosSolidos;
  final Map<int,String> disposicionExcreta;

  final Map<String, bool> errores;
  final GestionAmbiental gestionAmbiental;
  final bool datosCorrectos;
  
  const GestionAmbientalState({ 
    abastecimientoAgua,
    disposicionAguasReciduales,
    disposicionDesechosSolidos,
    disposicionExcreta,
    required this.gestionAmbiental,
    required this.errores,
    this.datosCorrectos = false,
  }):
  abastecimientoAgua         = abastecimientoAgua ?? const {},
  disposicionAguasReciduales = disposicionAguasReciduales ?? const {},
  disposicionDesechosSolidos = disposicionDesechosSolidos ?? const {},
  disposicionExcreta         = disposicionExcreta ?? const {};
  
  GestionAmbientalState copyWith({
    Map<int,String>?    abastecimientoAgua,
    Map<int,String>?    disposicionAguasReciduales,
    Map<int,String>?    disposicionDesechosSolidos,
    Map<int,String>?    disposicionExcreta,
    Map<String, bool>?  errores,
    GestionAmbiental?   gestionAmbiental,
    bool? datosCorrectos
  }) => GestionAmbientalState(
    abastecimientoAgua          : abastecimientoAgua ?? this.abastecimientoAgua,
    disposicionAguasReciduales  : disposicionAguasReciduales ?? this.disposicionAguasReciduales,
    disposicionDesechosSolidos  : disposicionDesechosSolidos ?? this.disposicionDesechosSolidos,
    disposicionExcreta          : disposicionExcreta ?? this.disposicionExcreta,
    errores                     : errores ?? this.errores,
    gestionAmbiental            : gestionAmbiental ?? this.gestionAmbiental,
    datosCorrectos              : datosCorrectos ?? this.datosCorrectos,
  );


  @override
  List<Object> get props => [
    abastecimientoAgua,
    disposicionAguasReciduales,
    disposicionDesechosSolidos,
    disposicionExcreta,
    gestionAmbiental,
    errores,
    datosCorrectos,
  ];
}


