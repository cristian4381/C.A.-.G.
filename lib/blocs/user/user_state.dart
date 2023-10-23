part of 'user_bloc.dart';

 class UserState extends Equatable {
  final bool existUser;
  final bool authenticatedFaild;
  final User? user;
  final Map<String, bool> errores;

  final bool confirmarPassword;
  final bool error;
  final bool autenticando;
  final String mensaje;

  final int estadoCambioPassword;
   /*
    state => 1 inital state
    state => 2 process 
    state => 3 success 
    state => 4 error 
    state => 5 error server
  */


  const UserState({
    required this.existUser,
    required this.authenticatedFaild,
    this.user,
    required this.errores,
    this.confirmarPassword = true,
    this.error = false,
    this.autenticando = false,
    this.mensaje = '',
    this.estadoCambioPassword = 1,
  });

  UserState copyWith({
    bool? existUser,
    bool? authenticatedFaild,
    User? user,
    Map<String, bool>? errores,
    bool? confirmarPassword,
    bool? error,
    bool? autenticando,
    String? mensaje,
    int? estadoCambioPassword
  }) {
    return UserState(
      existUser: existUser ?? this.existUser,
      authenticatedFaild: authenticatedFaild ?? this.authenticatedFaild,
      user: user ?? this.user,
      errores: errores ?? this.errores,
      confirmarPassword: confirmarPassword ?? this.confirmarPassword,
      error: error ?? this.error,
      autenticando: autenticando ?? this.autenticando,
      mensaje: mensaje ?? this.mensaje,
      estadoCambioPassword: estadoCambioPassword ?? this.estadoCambioPassword
    );
  }

  @override
  List<Object?> get props => [
    existUser, 
    authenticatedFaild, 
    user, 
    errores,
    confirmarPassword,
    error,
    autenticando,
    mensaje,
    estadoCambioPassword,
  ];
}

