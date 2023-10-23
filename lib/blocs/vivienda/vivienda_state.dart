part of 'vivienda_bloc.dart';

class ViviendaState extends Equatable {

  final Map<int,String> ambientes;
  final Map<int,String> pared;
  final Map<int,String> piso;
  final Map<int,String> techo;
  final Map<int,String> tenencia;
  final Map<int,String> tipoCocina;
  final Map<int,String> ubicacionCocina;
  final Map<String, String> cielo;
  final Map<String, String> iluminacion;
  final Map<String, String> ventilacion;

  final Map<String, bool> errores;
  final Vivienda vivienda;
  final bool datosCorrectos;

  const ViviendaState({
    ambientes,
    pared,
    piso,
    techo,
    tenencia,
    tipoCocina,
    ubicacionCocina,
    cielo,
    iluminacion,
    ventilacion,
    required this.vivienda,
    required this.errores,
    this.datosCorrectos = false
  }):ambientes=ambientes ?? const {},
  pared=pared ?? const {},
  piso=piso ?? const {},
  techo=techo ?? const {},
  tenencia=tenencia ?? const {},
  tipoCocina=tipoCocina ?? const {},
  ubicacionCocina=ubicacionCocina ?? const {},
  cielo=cielo ?? const {'tiene': 'Tiene','no tiene': 'No tiene'},
  iluminacion=iluminacion ?? const {'buena': 'Buena','mala': 'Mala'},
  ventilacion=ventilacion ?? const {'buena': 'Buena','mala': 'Mala'};

  ViviendaState copyWith({
    Map<int,String>? ambientes,
    Map<int,String>? pared,
    Map<int,String>? piso,
    Map<int,String>? techo,
    Map<int,String>? tenencia,
    Map<int,String>? tipoCocina,
    Map<int,String>? ubicacionCocina,
    Map<String, String>? cielo,
    Map<String, String>? iluminacion,
    Map<String, String>? ventilacion,
    Map<String, bool>?    errores,
    Vivienda? vivienda,
    bool? datosCorrectos,
  }) => ViviendaState(
    ambientes: ambientes ?? this.ambientes,
    pared: pared ?? this.pared,
    piso: piso ?? this.piso,
    techo: techo ?? this.techo,
    tenencia: tenencia ?? this.tenencia,
    tipoCocina: tipoCocina ?? this.tipoCocina,
    ubicacionCocina: ubicacionCocina ?? this.ubicacionCocina,
    cielo: cielo ?? this.cielo,
    iluminacion: iluminacion ?? this.iluminacion,
    ventilacion: ventilacion ?? this.ventilacion,
    vivienda: vivienda ?? this.vivienda,
    errores            : errores            ?? this.errores,
    datosCorrectos: datosCorrectos ?? this.datosCorrectos,
  );
  
  @override
  List<Object> get props => [
    ambientes,
    pared,
    piso,
    techo,
    tenencia,
    tipoCocina,
    ubicacionCocina,
    cielo,
    iluminacion,
    ventilacion,
    vivienda,
    errores,
    datosCorrectos
  ];
}


