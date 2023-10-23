part of 'familia_bloc.dart';

class FamiliaState extends Equatable {

  final Map<int, String> escolaridad;
  final Map<String, String> sabeLeer;
  final Map<String, String> sexo;

  final List<Persona> familiares;
  final Map<String, bool> errores;
  final bool avanzar;
  final bool otroFamilar;
  final int noFamilia;

  const FamiliaState({
    escolaridad,
    sabeLeer,
    sexo,
    familiares ,
    this.avanzar = false,
    this.otroFamilar = false,
    required this.errores,
    this.noFamilia = 0,
  }): familiares = familiares ?? const [],
   escolaridad = escolaridad      ?? const {},
   sabeLeer = sabeLeer ?? const{'si': 'Si','no': 'No'},
    sexo = sexo ?? const{'Masculino': 'Masculino','Femenino': 'Femenino'};
  
  FamiliaState copyWith({
    Map<int, String>? escolaridad,
    Map<String, String>? sabeLeer,
    Map<String, String>? sexo,
    List<Persona>? familiares,
    bool? avanzar,
    bool? otroFamilar,
    Map<String, bool>? errores,
    int? noFamilia, 
  }) => FamiliaState(
    escolaridad: escolaridad ?? this.escolaridad,
    sabeLeer: sabeLeer ?? this.sabeLeer,
    sexo: sexo ?? this.sexo,
    familiares: familiares ?? this.familiares,
    avanzar: avanzar ?? this.avanzar,
    otroFamilar: otroFamilar ?? this.otroFamilar,
    errores: errores ?? this.errores,
    noFamilia: noFamilia ?? this.noFamilia
  );


  @override
  List<Object> get props => [
    escolaridad,
    sabeLeer,
    sexo,
    familiares,
    avanzar,
    otroFamilar,
    errores,
    noFamilia,
  ];
}


