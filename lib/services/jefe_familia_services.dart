import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JefeFamiliaServices{

  Persona? _jefeFamilia;
  JefeFamilia? _detalleJefeFamilia;
  bool? _existenJefeFamilia;
  bool? _existenDetalleFamilia;

  Map<int, String>? _estadoCivil;
  Map<int, String>? _religion;
  Map<int, String>? _procedencia;
  Map<int, String>? _escolaridad;
  
  JefeFamiliaServices(){
    _existenDetalleFamilia = false;
    _existenJefeFamilia = false;
    _datosGuardados();
  } 

  Persona? get jefeFamilia => _jefeFamilia;
  JefeFamilia? get detalleJefeFamilia => _detalleJefeFamilia;
  bool? get existenJefeFamilia=> _existenJefeFamilia;
  bool? get existenDetalleFamilia=> _existenDetalleFamilia;
  Map<int, String>? get estadoCivil => _estadoCivil;
  Map<int, String>? get religion => _religion;
  Map<int, String>? get procedencia => _procedencia;
  Map<int, String>? get escolaridad => _escolaridad;

  Future<void> _datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => JEFE FAMILIA ########');
    final prefs = await SharedPreferences.getInstance();
    _existenJefeFamilia = prefs.containsKey('JefeFamilia');
    _existenDetalleFamilia = prefs.containsKey('detalleJefeFamilia');

    if(_existenJefeFamilia!){
      final jefeFamiliaGuardado= prefs.getString('JefeFamilia');
      _jefeFamilia = personaFromJson(jefeFamiliaGuardado!);
    }

    if(_existenDetalleFamilia!){
      final detallJefeFamiliaGuardado = prefs.getString('detalleJefeFamilia');
      _detalleJefeFamilia = jefeFamiliaFromJson(detallJefeFamiliaGuardado!);
    }
    
  }


  Future<void> cargarDatos()async{
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    _estadoCivil = { for (var element in informacion.estadoCivil) element.id : element.tipo };
    _procedencia = { for (var element in informacion.procedencia) element.id : element.tipo };
    _religion    = { for (var element in informacion.religion) element.id : element.tipo };
    _escolaridad = { for (var element in informacion.escolaridad) element.id : element.tipo };
  }

  Future<void> guardarDatos(Persona persona, JefeFamilia jefeFamilia) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('JefeFamilia', jsonEncode(persona.toJson()));
    await prefs.setString('detalleJefeFamilia', jsonEncode(jefeFamilia.toJson()));
  }

  Future<Persona> eliminarJefeFamilia()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('JefeFamilia');
    debugPrint('############ ELIMINANDO INFORMACION DEL JEFE DE FAMILIA ########## ');

    return  Persona(
      nombre: '', 
      sexo: '', 
      fechaNacimiento: DateTime.now(), 
      ocupacion: '', 
      sabeLeer: '', 
      escolaridad: 1
    );
  }

  Future<JefeFamilia> eliminarDetalleJefeFamilia()async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('detalleJefeFamilia');
    debugPrint('############ DETALLE JEFE DE FAMILIA ELIMINADO ########## ');

    _detalleJefeFamilia = JefeFamilia(
      estadoCivil: 1, 
      religion: 1, 
      procedencia: 1
    );
    return _detalleJefeFamilia!;
  }
  
}