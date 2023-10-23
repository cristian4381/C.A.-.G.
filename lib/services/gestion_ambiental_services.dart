import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GestionAmbientalServices{

  GestionAmbiental? _gestionAmbiental;
  bool? _existeGestionAmbiental;

  Map<int,String>? _abastecimientoAgua;
  Map<int,String>? _disposicionAguasReciduales;
  Map<int,String>? _disposicionDesechosSolidos;
  Map<int,String>? _disposicionExcreta;

  GestionAmbientalServices(){
    _datosGuardados();
  }

  GestionAmbiental? get gestionAmbiental =>  _gestionAmbiental;
  bool? get existeGestionAmbiental =>  _existeGestionAmbiental;

  Map<int,String>? get abastecimientoAgua =>  _abastecimientoAgua;
  Map<int,String>? get disposicionAguasReciduales =>  _disposicionAguasReciduales;
  Map<int,String>? get disposicionDesechosSolidos =>  _disposicionDesechosSolidos;
  Map<int,String>? get disposicionExcreta =>  _disposicionExcreta;

  Future<void> _datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => GESTION AMBIENAL ########');
    final prefs = await SharedPreferences.getInstance();

    _existeGestionAmbiental = prefs.containsKey('gestionAmbiental');

    if(_existeGestionAmbiental!){
      final jefeFamiliaGuardado= prefs.getString('gestionAmbiental');
      _gestionAmbiental = gestionAmbientalFromJson(jefeFamiliaGuardado!);
    }


  }

  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    _abastecimientoAgua = { for (var element in informacion.abastecimientoAgua) element.id : element.tipo };
    _disposicionAguasReciduales = { for (var element in informacion.disposicionAguasReciduales) element.id : element.tipo };
    _disposicionDesechosSolidos = { for (var element in informacion.disposicionDesechosSolidos) element.id : element.tipo };
    _disposicionExcreta = { for (var element in informacion.disposicionExcretas) element.id : element.tipo };

  }

  Future<void> guardarGestionAmbiental(GestionAmbiental gestionAmbiental)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gestionAmbiental', jsonEncode(gestionAmbiental.toJson()));
    _gestionAmbiental = gestionAmbiental;
  }

  Future<GestionAmbiental> eliminarGestionAmbienta()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('gestionAmbiental');

    debugPrint('############ ELIMINANDO INFORMACION => GESTION AMBIENAL ########## ');
    
    _gestionAmbiental = GestionAmbiental(
      abastecimientoAgua: 0, 
      disposicionExcretas: 0, 
      disposicionAguasReciduales: 0, 
      disposicionDesechosSolidos: 0
    );

    return _gestionAmbiental!;
  }
}