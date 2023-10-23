part of 'jefe_familia_bloc.dart';

class JefeFamiliaState extends Equatable {
  final Persona jefeFamilia;
  final JefeFamilia detalleJefeFamilia;
  final Map<String, String> sexo;
  final Map<String, bool> errores;
  final int noFamiliares;
  final Map<int, String> estadoCivil;
  final Map<int, String> religion;
  final Map<int, String> procedencia;
  final Map<int, String> escolaridad;
  final Map<String, String> sabeLeer;
  final bool datosCorrectos;
  final bool existenJefeFamilia;
  final bool existenDetalleJefeFamilia;
  final bool limpiarDatos;

  const JefeFamiliaState( {
    required this.jefeFamilia, 
    required this.detalleJefeFamilia,
    required this.errores,
    required this.sexo,
    estadoCivil,
    religion,
    procedencia,
    escolaridad,
    noFamiliares,
    required this.sabeLeer,
    this.datosCorrectos = false,
    this.existenJefeFamilia = false,
    this.existenDetalleJefeFamilia = false,
    this.limpiarDatos = false,
  }):
    estadoCivil = estadoCivil   ?? const {},
    religion = religion         ?? const {},
    procedencia = procedencia      ?? const {},
    escolaridad = escolaridad      ?? const {},
    noFamiliares = noFamiliares ??  0;

  JefeFamiliaState copyWith({
    Persona?              jefeFamilia,
    JefeFamilia?          detalleJefeFamilia,
    Map<String, String>?  sexo,
    Map<String, bool>?    errores,
    int?                  noFamiliares,
    Map<int, String>? estadoCivil,
    Map<int, String>? religion,
    Map<int, String>? procedencia,
    Map<int, String>? escolaridad,
    Map<String, String>? sabeLeer,
    bool? datosCorrectos,
    bool? existenDetalleJefeFamilia,
    bool? existenJefeFamilia,
    bool? limpiarDatos,
  }) => JefeFamiliaState(
    jefeFamilia        : jefeFamilia        ?? this.jefeFamilia,
    detalleJefeFamilia : detalleJefeFamilia ?? this.detalleJefeFamilia,
    sexo               : sexo               ?? this.sexo,
    errores            : errores            ?? this.errores,
    estadoCivil        : estadoCivil        ?? this.estadoCivil ,
    religion           : religion           ?? this.religion ,
    procedencia        : procedencia        ?? this.procedencia ,
    noFamiliares       : noFamiliares       ?? this.noFamiliares,
    escolaridad        : escolaridad        ?? this.escolaridad,
    sabeLeer           : sabeLeer           ?? this.sabeLeer, 
    datosCorrectos: datosCorrectos ?? this.datosCorrectos,
    existenJefeFamilia : existenJefeFamilia ?? this.existenJefeFamilia,
    existenDetalleJefeFamilia : existenDetalleJefeFamilia ?? this.existenDetalleJefeFamilia,
    limpiarDatos: limpiarDatos ?? this.limpiarDatos,
  );
  
  @override
  List<Object> get props => [ 
    jefeFamilia, 
    detalleJefeFamilia, 
    sexo, 
    errores,
    estadoCivil,
    religion,
    procedencia,
    noFamiliares,
    sabeLeer,
    escolaridad,
    datosCorrectos,
    existenJefeFamilia,
    existenDetalleJefeFamilia,
    limpiarDatos,
  ];
}


