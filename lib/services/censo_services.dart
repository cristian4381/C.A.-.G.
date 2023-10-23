import 'dart:convert';


import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ca_and_g/global/environment.dart';


class CensoServices{

  Future<void> getInformacion(String token) async{
    final uri = Uri.parse('${Environment.apiUrl}/censo/informacion');

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString(),
      },
    );

    if (resp.statusCode == 200){
      final informacion = informacionResponseFromJson(resp.body);

      await _guardarInformacion(informacion);
    }
    
  }

  Future<void> _guardarInformacion(InformacionResponse informacion) async{
    final prefs = await SharedPreferences.getInstance();
    final userJson = informacion.toJson(); 
    await prefs.setString('informacion', jsonEncode(userJson));

    
  }

  Future<bool> enviarFormulario (
    {
      required Boleta boleta
    }
  )async{

    debugPrint(boleta.toString());

    final uri =Uri.parse('${Environment.apiUrl}/censo/new');

    try{
      final resp = await http.post(uri,
        body:  jsonEncode(boleta.toJson()),
        headers: {
          'Content-Type':'application/json'
        }
      );

      if(resp.statusCode == 200){
        debugPrint('FORMULARIO GUARDADO EXITOSAMENTE');
        return true;
      }else{
        return false;
      }
    }catch (e){
      debugPrint('Ocurrio un error: $e');
      return false;
    }

    
  }

  Future<bool> existeInformacion()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('informacion');
  }

  Future<InformacionResponse> recuperarInformacion() async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    final informacion =  InformacionResponse.fromJson(informacionMap);

    return informacion;
  }

  Future<bool> sincronizarBoletas(List<Boleta> boletas) async {
    final uri =Uri.parse('${Environment.apiUrl}/censo/sicronizar');
    List<Map<String, dynamic>> boletasMaps = boletas.map((boleta) => boleta.toJson()).toList();
    final data = {
      'boletas' : boletasMaps
    };
    //List<Map<String, dynamic>> listaMapas = ubicaciones.map((ubicacion) => ubicacion.toJson()).toList();
    try {
      final resp = await http.post(uri,
        body:  jsonEncode(data),
        headers: {
          'Content-Type':'application/json'
        }
      );

      if(resp.statusCode == 200){
        debugPrint('FORMULARIO GUARDADO EXITOSAMENTE');
        return true;
      }else{
        return false;
      }
    } catch (e) {
      debugPrint('Ocurrio un error $e');
      return false;
    }

  }
}

