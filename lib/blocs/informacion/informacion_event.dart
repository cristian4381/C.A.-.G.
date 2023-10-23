part of 'informacion_bloc.dart';

abstract class InformacionEvent extends Equatable {
  const InformacionEvent();

  @override
  List<Object> get props => [];
}

class CargarInfomacionEvent extends  InformacionEvent{}
