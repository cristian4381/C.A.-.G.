import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ca_and_g/global/environment.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectivityServices{
  final bool _connectivity=false;

  bool get connectivity => _connectivity;

  static Future<bool> internetconnection() async{
    final connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
  
  static Future<bool> serverConnection() async{
    try{
      final response = await http.get(Uri.parse(Environment.url));
      return response.statusCode == 200;

    } catch (e) {
      debugPrint('No hay conexion con el servidor');
      return false;
    }
  }

  //revisar si existe ubicacion
  Future<bool> existeUbicacion() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('ubicacion') ? true : false;
  }

  Future<void> guardarUbicacion(Map<String,dynamic> ubicacion) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(ubicacion);
    await prefs.setString('ubicacion', jsonString);

    
    debugPrint('####### Ubicacion Guardada #######');
  }

  Future<Map<String, dynamic>> recuperarUbicacion() async{
    Map<String, dynamic> ubicacion = {};
    
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('ubicacion');
    if (jsonString != null) {
      ubicacion = jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return ubicacion;
  }

  Future<void> eliminarUbicacion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ubicacion');
    debugPrint('############ UBICACION ELIMINADO ########## ');
  }
}