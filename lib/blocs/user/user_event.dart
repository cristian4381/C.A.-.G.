part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class AutenticateUserEvent extends UserEvent{
  final String email;
  final String password;

  const AutenticateUserEvent({
    required this.email, 
    required this.password,

  });
}

class UserLoggedEvent extends UserEvent{
  final User user;


  const UserLoggedEvent({
    required this.user, 
  });
}

class UserLoggedFaildEvent extends UserEvent{}

class LogoutUserEvent extends UserEvent{}

class AutenticationFaild extends UserEvent{}

class RegistrarEvent extends UserEvent{
  final String correo;
  final String nombre;
  final String telefono;
  final String password;
  final String confirmPassword;

  const RegistrarEvent({
    required this.correo, 
    required this.nombre, 
    required this.telefono, 
    required this.password,
    required this.confirmPassword,
  });
  
}

class ActualizarError extends UserEvent{}
class CambiarPasswordEvent extends UserEvent{
  final String actualPassword;
  final String nuevoPassword;

  CambiarPasswordEvent({
    required this.actualPassword, 
    required this.nuevoPassword
  });
}
class ActualizarEstadoCambioPasswordEvent extends UserEvent{
  final int estado;

  ActualizarEstadoCambioPasswordEvent(this.estado);
}