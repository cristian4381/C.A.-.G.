part of 'miscelaneo_bloc.dart';

abstract class MiscelaneoEvent extends Equatable {
  const MiscelaneoEvent();

  @override
  List<Object> get props => [];
}

class AgregarMascotaEvent extends MiscelaneoEvent{
  final Map<String, dynamic> informacion;
  const AgregarMascotaEvent(this.informacion);
}

class AgregarEstablecimientoEvent extends MiscelaneoEvent{
  final Map<String, dynamic> informacion;
  const AgregarEstablecimientoEvent(this.informacion);
}

class CargarDatosEvent extends MiscelaneoEvent{
  //final List<Mascota> mascotas;
  //final List<EstablecimientosPublicos> establecimientosPublicos;
  final Map<int, String> tiposMascotas;
  final Map<int, String> tiposEstablecimientos;

  const CargarDatosEvent({
    required this.tiposEstablecimientos, 
    required this.tiposMascotas,
    //required this.mascotas, 
    //required this.establecimientosPublicos
  });
}

class EliminarMascotaEvent extends MiscelaneoEvent{
  final int index;
  const EliminarMascotaEvent(this.index);
}

class EliminarEstablecimientoEvent extends MiscelaneoEvent{
  final int index;
  const EliminarEstablecimientoEvent(this.index);
}

class EliminarDatosGuardados extends MiscelaneoEvent{}
