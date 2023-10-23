part of 'vivienda_bloc.dart';

abstract class ViviendaEvent extends Equatable {
  const ViviendaEvent();

  @override
  List<Object> get props => [];
}


class ActualizarErroresEvent extends ViviendaEvent{
  final Map<String, bool> errores;

  const ActualizarErroresEvent(this.errores);
}
class CargarDatosEvent extends ViviendaEvent{
  final Map<int,String> ambientes;
  final Map<int,String> pared;
  final Map<int,String> piso;
  final Map<int,String> techo;
  final Map<int,String> tenencia;
  final Map<int,String> tipoCocina;
  final Map<int,String> ubicacionCocina;

  const CargarDatosEvent({
    required this.ambientes,
    required this.pared,
    required this.piso,
    required this.techo,
    required this.tenencia,
    required this.tipoCocina,
    required this.ubicacionCocina,
  });
}
class DatosCorrectosEvent extends ViviendaEvent{}
class EliminarViviendaEvent extends ViviendaEvent{}
class ErrorNoVivienda extends ViviendaEvent{}
class GuardarIformacionEvent extends ViviendaEvent{
  final Map<String, dynamic> informacion;
  const GuardarIformacionEvent(this.informacion);
}
class GuardarNoViviendaEvent extends ViviendaEvent{
  final int noVivienda;

  GuardarNoViviendaEvent(this.noVivienda);
}
