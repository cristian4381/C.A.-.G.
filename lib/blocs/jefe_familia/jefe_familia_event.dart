part of 'jefe_familia_bloc.dart';

abstract class JefeFamiliaEvent extends Equatable {
  const JefeFamiliaEvent();

  @override
  List<Object> get props => [];
}
class GuardarIformacionEvent extends JefeFamiliaEvent{
  final Map<String, dynamic> informacion;
  const GuardarIformacionEvent(this.informacion);
}
class ActualizarErroresEvent extends JefeFamiliaEvent{
  final Map<String, bool> errores;

  const ActualizarErroresEvent(this.errores);
}
class CargarDatosEvent extends JefeFamiliaEvent{
  final Map<int, String> estadoCivil;
  final Map<int, String> religion;
  final Map<int, String> procedencia;
  final Map<int, String> escolaridad;

  const CargarDatosEvent({
    required this.estadoCivil,
    required this.religion,
    required this.procedencia,
    required this.escolaridad
  });
}
class DatosCorrectosEvent extends JefeFamiliaEvent{}
class EliminarDatosvent extends JefeFamiliaEvent{}
class LimpiarDatosvent extends JefeFamiliaEvent{}
