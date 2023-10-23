part of 'formulario_bloc.dart';

abstract class FormularioEvent extends Equatable {
  const FormularioEvent();

  @override
  List<Object> get props => [];
}

class CargarDatosEvent extends FormularioEvent{

  final int noStep;

  const CargarDatosEvent({
    required this.noStep, 
  });
}
class EnviarFormularioEvent extends FormularioEvent{
  final Persona jefeFamilia;
  final JefeFamilia detalleJefeFamilia;
  final List<Persona> familia;
  final GestionAmbiental gestionAmbiental;
  final Vivienda vivienda ;
  final List<Mascota> mascotas;
  final List<EstablecimientosPublicos> establecimientos;
  final User usuario ;
  final double latitud;
  final double longitud;
  final int noFamilia;

  const EnviarFormularioEvent({
    required this.jefeFamilia, 
    required this.detalleJefeFamilia, 
    required this.familia, 
    required this.gestionAmbiental, 
    required this.vivienda, 
    required this.mascotas, 
    required this.establecimientos,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    required this.noFamilia,
  });
}
class IncrementStep extends FormularioEvent{} 
class DecrementStep extends FormularioEvent{}
class GuardarLocalEvent extends FormularioEvent{
  final Persona jefeFamilia;
  final JefeFamilia detalleJefeFamilia;
  final List<Persona> familia;
  final GestionAmbiental gestionAmbiental;
  final Vivienda vivienda ;
  final List<Mascota> mascotas;
  final List<EstablecimientosPublicos> establecimientos;
  final User usuario ;

  final double latitud;
  final double longitud;
  final int noFamilia;

  const GuardarLocalEvent({
    required this.jefeFamilia,
    required this.detalleJefeFamilia,
    required this.familia,
    required this.gestionAmbiental,
    required this.vivienda,
    required this.mascotas,
    required this.establecimientos,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    required this.noFamilia,
  });

}
class NoGuardarLocalEvent extends FormularioEvent{}
class ConfirmationEvent extends FormularioEvent{}
class ActualizarEstadoEvent extends FormularioEvent{
  final int estado;

  const ActualizarEstadoEvent(this.estado);
}

class ConfiguracionEvent extends FormularioEvent{
  final int comunidad;
  final int sector;

  const ConfiguracionEvent({
    required this.comunidad,
    required this.sector
  });

}
class EliminarConfiguracionEvent extends FormularioEvent{}
class SicronizarBoletasEvent extends FormularioEvent{}
class SincronizacionExitosaEvent extends FormularioEvent{}
class ErrorSincronizacionEvent extends FormularioEvent{}
class ErrorNoComunidadEvent extends FormularioEvent{}
class ErrorNoSectorEvent extends FormularioEvent{}