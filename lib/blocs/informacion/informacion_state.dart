part of 'informacion_bloc.dart';

 class InformacionState extends Equatable {

  final Map<int,String> ? escolaridad ;
  final Map<String, String>? sabeLeer;
  final Map<String, String>? sexo;
  final Map<int,String>? abastecimientoAgua;
  final Map<int,String>? disposicionAguasReciduales;
  final Map<int,String>? disposicionDesechosSolidos;
  final Map<int,String>? disposicionExcreta;
  final Map<int,String>? ambientes;
  final Map<int,String>? pared; 
  final Map<int,String>? piso; 
  final Map<int,String>? techo; 
  final Map<int,String>? tenencia; 
  final Map<int,String>? tipoCocina; 
  final Map<int,String>? ubicacionCocina; 
  final Map<String, String>? cielo;
  final Map<String, String>? iluminacion;
  final Map<String, String>? ventilacion;
  final Map<int, String>? tipoMascota;

  final Map<int, String>? estadoCivil;
  final Map<int, String>? religion;
  final Map<int, String>? procedencia;

  const InformacionState({
    escolaridad, 
    sabeLeer, 
    sexo, 
    abastecimientoAgua, 
    disposicionAguasReciduales, 
    disposicionDesechosSolidos, 
    disposicionExcreta, 
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
    tipoMascota,
    estadoCivil,
    religion,
    procedencia,
  }):
  escolaridad= escolaridad ?? const {}, 
  sexo=sexo ?? const{},
  abastecimientoAgua=abastecimientoAgua ?? const {},
  disposicionAguasReciduales=disposicionAguasReciduales ?? const {},
  disposicionDesechosSolidos=disposicionDesechosSolidos ?? const {},
  disposicionExcreta=disposicionExcreta ?? const {},
  ambientes=ambientes ?? const {},
  pared=pared ?? const {},
  piso=piso ?? const {},
  techo=techo ?? const {},
  tenencia=tenencia ?? const {},
  tipoCocina=tipoCocina ?? const {},
  ubicacionCocina=ubicacionCocina ?? const {},
  cielo=cielo ?? const {},
  iluminacion=iluminacion ?? const {},
  ventilacion=ventilacion ?? const {},
  tipoMascota=tipoMascota ?? const {},
  sabeLeer=sabeLeer ?? const{},
  estadoCivil = estadoCivil ?? const {},
  religion = religion ?? const {},
  procedencia = procedencia ?? const {};

  InformacionState copyWith({
    Map<int,String> ? escolaridad,
    Map<String, String>? sabeLeer,
    Map<String, String>? sexo,
    Map<int,String>? abastecimientoAgua,
    Map<int,String>? disposicionAguasReciduales,
    Map<int,String>? disposicionDesechosSolidos,
    Map<int,String>? disposicionExcreta,
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
    Map<int, String>? tipoMascota,
    Map<int, String>? estadoCivil,
    Map<int, String>? religion,
    Map<int, String>? procedencia,
  }) =>InformacionState(
    escolaridad: escolaridad ?? this.escolaridad,
    sabeLeer: sabeLeer ?? this.sabeLeer,
    sexo: sexo ?? this.sexo,
    abastecimientoAgua: abastecimientoAgua ?? this.abastecimientoAgua,
    disposicionAguasReciduales: disposicionAguasReciduales ?? this.disposicionAguasReciduales,
    disposicionDesechosSolidos: disposicionDesechosSolidos ?? this.disposicionDesechosSolidos,
    disposicionExcreta: disposicionExcreta ?? this.disposicionExcreta,
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
    tipoMascota: tipoMascota ?? this.tipoMascota,
    estadoCivil: estadoCivil ?? this.estadoCivil,
    religion: religion ?? this.religion,
    procedencia: procedencia ?? this.procedencia,
  );
  
  @override
  List<Object?> get props => [];
}
