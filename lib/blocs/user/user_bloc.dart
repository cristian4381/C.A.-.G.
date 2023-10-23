import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final authServices = AuthServices();

  UserBloc() : super(
    const UserState(
      existUser: false, 
      authenticatedFaild: false,
      errores: {
        'nombre'      : false,
        'correo'           : false,
        'telefono'     : false,
        'password'     : false,
        'confirmPassword'     : false,
      }
    )) {
    
    on<UserLoggedEvent>((event, emit)=>emit(state.copyWith(existUser: true, user: event.user)));
    on<UserLoggedFaildEvent>((event, emit)=>emit(state.copyWith(existUser: false)));
    on<AutenticationFaild>((event, emit)=>emit(state.copyWith(authenticatedFaild: false)));
    on<ActualizarEstadoCambioPasswordEvent>((event, emit) => emit(state.copyWith(estadoCambioPassword: event.estado)));
    on<CambiarPasswordEvent>((event, emit) async {
      emit(state.copyWith(estadoCambioPassword: 2));
      int estado = await authServices.changePassword(
        correo: state.user!.correo, 
        oldPassword: event.actualPassword, 
        newPassword: event.nuevoPassword
      );
      emit(state.copyWith(estadoCambioPassword: estado));
    });
    on<AutenticateUserEvent>((event, emit)async{
      final sucess = await authServices.login(event.email, event.password);

      sucess
      ? emit(state.copyWith(existUser: true, user: authServices.usuario))
      : emit(state.copyWith(authenticatedFaild: true));
      
      debugPrint('USUARIO LOGUEADO => ${state.user!.nombre}');
    });
    on<RegistrarEvent>((event, emit) async{
      bool datosCorrecto = true;
      bool confirPassword = true;
      bool error = false;
      String mensaje = '';
      Map<String, bool> errores= Map.from(state.errores);

      if(event.nombre == ''){
        errores['nombre'] = true;
        datosCorrecto= false;
      }else{
        errores['nombre'] = false;
      }
      if(event.correo == ''){
        errores['correo'] = true;
        datosCorrecto= false;
      }else{
        errores['correo'] = false;
      }

      if(event.telefono == ''){
        errores['telefono'] = true;
        datosCorrecto= false;
      }else{
        errores['telefono'] = false;
      }

      if(event.password.length < 8 || event.confirmPassword.length <8){
        error = true;
        errores['confirmPassword'] = true;
        errores['password'] = true;
        datosCorrecto= false;
        mensaje = 'la contraseña debe tener como minimo 8  caracteres';
      }else{
        errores['confirmPassword'] = false;
        errores['password'] = false;
      }

      if(event.password != event.confirmPassword){
        datosCorrecto = false;
        error = true;
        mensaje = 'las contraseña no son iguales';
        errores['confirmPassword'] = true;
        errores['password'] = true;
      }else{
        errores['confirmPassword'] = false;
        errores['password'] = false;
      }

      debugPrint('Nombre: ${event.nombre}, Correo: ${event.correo}, Telefono: ${event.telefono}, pass: ${event.password}, confirmPass: ${event.confirmPassword}, ');
      debugPrint('errores $errores');
      if(!datosCorrecto){
        emit(
          state.copyWith(
            errores: errores,
            confirmarPassword: confirPassword,
            error: error,
            mensaje: mensaje
          )
        );
      }else{
        emit(
          state.copyWith(
            errores: errores,
            confirmarPassword: confirPassword,
            error: error,
            autenticando: true
          )
        );
        bool sucess = await authServices.register(event.nombre, event.correo, event.password, 2,event.telefono);

        sucess
        ? emit(state.copyWith(existUser: true, user: authServices.usuario, autenticando: false))
        : emit(state.copyWith(autenticando: false, error: true, mensaje: 'El usuario ya esta registrado'));
      }
    });
    on<ActualizarError>((event, emit) => emit(state.copyWith(error: false)));
    on<LogoutUserEvent>((event, emit){
      authServices.logout();
      emit(state.copyWith(existUser: false, user: null,estadoCambioPassword: 1));
    });
    _init();
    
  }
  Future _init()async{
    await Future.delayed(const Duration(seconds: 2));
    final logged = await authServices.isLoggedIn();

    if(!logged){
      add(UserLoggedFaildEvent());
      
      return;
    }
    
    add(UserLoggedEvent(user: authServices.usuario!));

  }
}

