part of 'familia_bloc.dart';

abstract class FamiliaEvent extends Equatable {
  const FamiliaEvent();

  @override
  List<Object> get props => [];
}
class CargarDatos extends FamiliaEvent{
  final Map<int, String> escolaridad;

  const CargarDatos({
    required this.escolaridad
  });
}
class GuardarIformacionEvent extends FamiliaEvent{
  final Map<String, dynamic> informacion;
  const GuardarIformacionEvent(this.informacion);
}

class AgregarFamiliarEvent extends FamiliaEvent{
  final Map<String, dynamic> informacion;
  const AgregarFamiliarEvent(this.informacion);
}
class AvanzarEvent extends FamiliaEvent{
  final bool avanzar;

  const AvanzarEvent(this.avanzar);

}

class GuardarNoFamiliaEvent extends FamiliaEvent{

  final int noFamilia;

  GuardarNoFamiliaEvent(this.noFamilia);

}

class AgregarOtroFamiliarEvent extends FamiliaEvent{
  final bool otroFamiliar;

  const AgregarOtroFamiliarEvent(this.otroFamiliar);
}
class ActualizarErroresEvent extends FamiliaEvent{
  final Map<String, bool> errores;

  const ActualizarErroresEvent(this.errores);
}

class EliminarFamiliarEvent extends FamiliaEvent{
  final int index;
  const EliminarFamiliarEvent(this.index);
}

class EliminarFamiliaEvent extends FamiliaEvent{}
class ErroNoFamiliaEvent extends FamiliaEvent{}