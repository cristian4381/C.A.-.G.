part of 'gestion_ambiental_bloc.dart';

abstract class GestionAmbientalEvent extends Equatable {
  const GestionAmbientalEvent();

  @override
  List<Object> get props => [];
}
class GuardarIformacionEvent extends GestionAmbientalEvent{
  final Map<String, dynamic> informacion;
  const GuardarIformacionEvent(this.informacion);
}
class ActualizarErroresEvent extends GestionAmbientalEvent{
  final Map<String, bool> errores;
  const ActualizarErroresEvent(this.errores);
}
class CargarDatosEvent extends GestionAmbientalEvent{
  final Map<int,String> abastecimientoAgua;
  final Map<int,String> disposicionAguasReciduales;
  final Map<int,String> disposicionDesechosSolidos;
  final Map<int,String> disposicionExcreta;
  //final GestionAmbiental gestionAmbiental;

  const CargarDatosEvent({
    required this.abastecimientoAgua,
    required this.disposicionAguasReciduales,
    required this.disposicionDesechosSolidos,
    required this.disposicionExcreta,
    //required this.gestionAmbiental,
  });
}
class DatosCorrectosEvent extends GestionAmbientalEvent {}
class EliminarGestionAmbientalEvent extends GestionAmbientalEvent {} 