import 'dart:convert';

import 'package:ca_and_g/global/environment.dart';
import 'package:ca_and_g/models/login_response.dart';
import 'package:ca_and_g/models/user.dart';
import 'package:ca_and_g/services/censo_services.dart';
import 'package:ca_and_g/services/connectivity_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthServices{
  User? _usuario;

  bool autenticando =false;

  final _storage = const FlutterSecureStorage();
  User? get usuario => _usuario;
  //Getters staticos token
  static Future<String?>getToken()async{
    const storage =  FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;

  }

  static Future<void> deletToken() async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password)async{
    autenticando=true;
    final data = {
      'correo' : email,
      'password': password
    };

    final uri =Uri.parse('${Environment.apiUrl}/login');
    //print(uri);

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type':'application/json'
      }
    );
    autenticando=false;
    debugPrint(resp.body);
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      
      _usuario=loginResponse.user;

      debugPrint('USUARIO LOGUEADO => $_usuario');
      
      //guardar TOken
      await _guardarToken(loginResponse.token);
      await _guardarusuario(_usuario!);

      final info = CensoServices();

      await info.getInformacion(loginResponse.token);


      return true;
    }else{
      return false;
    }
  }

  Future<bool> register(String nombre,String email, String password, int rol, String telefono)async{
    autenticando=true;

    final data = {
      'nombre': nombre,
      'correo' : email,
      'telefono' : telefono,
      'password': password,
      'rol': rol
    };

    final uri =Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type':'application/json'
      }
    );
    autenticando=false;
    debugPrint('resp: ${resp.body}');
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      _usuario=loginResponse.user;

      //guardar TOken
      await _guardarToken(loginResponse.token);
      await _guardarusuario(_usuario!);

      final info = CensoServices();

      await info.getInformacion(loginResponse.token);


      return true;
    }else{
      return false;
    }
  }

  Future<bool> isLoggedIn() async {

    //final conectivity = ConnectivityServices();
    
    if(!await _storage.containsKey(key: 'token')){
      debugPrint('El token no existe');
      return false;
    }

    if(!await ConnectivityServices.internetconnection() || !await ConnectivityServices.serverConnection()){
      final prefs = await SharedPreferences.getInstance();
      final userMap = jsonDecode(prefs.getString('usuario')!) as Map<String, dynamic>;      
      _usuario = User.fromJson(userMap);
      return true;
    }

    debugPrint('El token existe');
    return renewToken(await _storage.read(key: 'token'));  

  }

  Future<bool> renewToken(String? token)async{
    final uri = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString(),
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _usuario = loginResponse.user;


      await _guardarToken(loginResponse.token);
      return true;
    } else {

      return false;
    }
  }

  Future _guardarToken(String token) async{
    await _storage.write(key: 'token', value: token);
  }
  Future<void> _guardarusuario(User usuario) async{
    final prefs = await SharedPreferences.getInstance();
    final userJson = usuario.toJson(); // Suponiendo que tienes un método toJson() en tu clase User
    await prefs.setString('usuario', jsonEncode(userJson));
  }
  Future logout()async{
    final prefs = await SharedPreferences.getInstance();
    await _storage.delete(key: 'token');
    await prefs.remove('usuario');
  }

  Future<int> changePassword({
    required String correo,
    required String oldPassword,
    required String newPassword,
  }) async {
     /*
      state => 3 success 
      state => 4 error 
      state => 5 error server
    */

    try {

      final data = {
        'correo' : correo,
        'oldPassword': oldPassword,
        'newPassword': newPassword
      };

      final uri =Uri.parse('${Environment.apiUrl}/login/cambiarPassword');

      debugPrint('$uri');

      final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type':'application/json'
        }
      );

      debugPrint(resp.body);

      if(resp.statusCode == 200){
        return 3;
      }else{
        return 4;
      }
      
    } catch (e) {
      debugPrint('######## OCURRIO UN ERROR AL CAMBIAR LA CONTRASEÑA ########');
      debugPrint('$e');
      return 5;
    }
  } 
}