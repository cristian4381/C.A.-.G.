part of 'miscelaneo_bloc.dart';

class MiscelaneoState extends Equatable {
  final Map<String, dynamic> errores;
  final Map<String, dynamic> opciones;
  final Map<int, String> tiposMascotas;
  final Map<int, String> tiposEstablecimientos;
  final Map<String, String> ubicacacionMascota;

  final List<Mascota> mascotas;
  final List<EstablecimientosPublicos> establecimientosPublicos;
  

  const MiscelaneoState({
    required this.errores,
    establecimientosPublicos,
    mascotas,
    opciones,
    tiposMascotas,
    tiposEstablecimientos,
    ubicacacionMascota
  }):
  establecimientosPublicos = establecimientosPublicos ?? const [],
  mascotas = mascotas ?? const [],
  opciones = opciones ?? const{'si': 'Si','no': 'No'},
  tiposEstablecimientos = tiposEstablecimientos ?? const {},
  tiposMascotas = tiposMascotas ?? const {},
  ubicacacionMascota = ubicacacionMascota ?? const {'Adecuado':'Adecuado','Inadecuado':'Inadecuado'};

  MiscelaneoState copyWith({
    Map<String, dynamic> ? errores,
    List<Mascota>? mascotas,
    List<EstablecimientosPublicos>? establecimientosPublicos,
    Map<String, dynamic>? opciones,
    Map<int, String>? tiposMascotas,
    Map<int, String>? tiposEstablecimientos,

  }) => MiscelaneoState(
    errores : errores ?? this.errores,
    establecimientosPublicos : establecimientosPublicos ?? this.establecimientosPublicos,
    mascotas : mascotas ?? this.mascotas,
    opciones : opciones ?? this.opciones,
    tiposEstablecimientos: tiposEstablecimientos ?? this.tiposEstablecimientos,
    tiposMascotas: tiposMascotas ?? this.tiposMascotas,
   
  );
  
  @override
  List<Object> get props => [
    errores,
    establecimientosPublicos,
    mascotas,
    opciones,
    tiposEstablecimientos,
    tiposMascotas,

  ];
}


