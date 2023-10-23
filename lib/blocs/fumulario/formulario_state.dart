part of 'formulario_bloc.dart';

class FormularioState extends Equatable {

  final int noStep;
  final bool guardando;
  final int estado;
  final Map<int,String> comunidades;
  final Comunidad comunidadSeleccionada;
  final Sector sector;
  final bool comunidadConfigurada;
  final Map<String, bool> errores;
  final List<Boleta> boletas;

  final int sincronizacionEstado;
  /*
    estados:
    1 => llenando formulario
    2 => procesando
    3 => confirmar guardar en local
    4 => guardado => limpar datos
    5 => limpiar => limpar datos para nuevas configuraciones

    sincronizacionEstado
    1 => mostrar datos
    2 => enviando datos
    3 => datos enviados correctamente
    4 => ocurrio un error

  */

  const FormularioState({
    this.noStep=0,
    this.guardando = false,
    this.estado = 1,
    comunidades,
    required this.comunidadSeleccionada,
    required this.sector,
    this.comunidadConfigurada = false,
    required this.errores,
    boletas,
    this.sincronizacionEstado = 1
  }):comunidades = comunidades ?? const {}, boletas = boletas ?? const [];

  FormularioState copyWith({
    int? noStep,
    bool? guardando,
    int? estado,
    Map<int,String>? comunidades,
    Comunidad? comunidadSeleccionada,
    Sector? sector,
    bool? comunidadConfigurada,
    Map<String, bool>? errores,
    int? sincronizacionEstado,
    List<Boleta>? boletas
  }) => FormularioState(
    noStep: noStep ?? this.noStep,
    guardando: guardando ?? this.guardando,
    estado: estado ?? this.estado,
    comunidades: comunidades ?? this.comunidades,
    comunidadSeleccionada: comunidadSeleccionada ?? this.comunidadSeleccionada,
    sector: sector ?? this.sector,
    comunidadConfigurada: comunidadConfigurada ?? this.comunidadConfigurada,
    errores: errores ?? this.errores,
    boletas: boletas ?? this.boletas,
    sincronizacionEstado: sincronizacionEstado ?? this.sincronizacionEstado,
  );
  
  @override
  List<Object?> get props => [
    noStep,
    guardando,
    estado,
    comunidades,
    comunidadSeleccionada,
    sector,
    comunidadConfigurada,
    errores,
    boletas,
    sincronizacionEstado
  ];
}
