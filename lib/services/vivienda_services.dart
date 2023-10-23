import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViviendaServices {

  Map<int,String>? _ambientes;
  Map<int,String>? _pared;
  Map<int,String>? _piso;
  Map<int,String>? _techo;
  Map<int,String>? _tenencia;
  Map<int,String>? _tipoCocina;
  Map<int,String>? _ubicacionCocina;

  Vivienda? _vivienda;
  bool? _existeVivienda;


  ViviendaServices(){
    _existeVivienda = false;
    _datosGuardados();
  }

  Map<int,String>? get ambientes => _ambientes;
  Map<int,String>? get pared => _pared;
  Map<int,String>? get piso => _piso;
  Map<int,String>? get techo => _techo;
  Map<int,String>? get tenencia => _tenencia;
  Map<int,String>? get tipoCocina => _tipoCocina;
  Map<int,String>? get ubicacionCocina => _ubicacionCocina;
  Vivienda? get vivienda => _vivienda;
  bool? get existeVivienda => _existeVivienda;

  Future<void> _datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => VIVIENDA ########');
    final prefs = await SharedPreferences.getInstance();
    _existeVivienda = prefs.containsKey('vivienda');

    if(_existeVivienda!){
      final viviendaGuardada= prefs.getString('vivienda');
      _vivienda = viviendaFromJson(viviendaGuardada!);
  
      debugPrint('######## DATOS ENCONTRADOS => VIVIENDA ########');
    }
  }

  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);


    _ambientes = { for (var element in informacion.ambiente) element.id : element.tipo };
    _pared = { for (var element in informacion.pared) element.id : element.tipo };
    _piso ={ for (var element in informacion.piso) element.id : element.tipo };
    _techo ={ for (var element in informacion.techo) element.id : element.tipo };
    _tenencia ={ for (var element in informacion.tenencia) element.id : element.tipo };
    _tipoCocina ={ for (var element in informacion.tipoCocina) element.id : element.tipo };
    _ubicacionCocina ={ for (var element in informacion.ubicacionCocina) element.id : element.ubicacion };
  }

  Future<void> guardarViviena(Vivienda vivienda)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vivienda', jsonEncode(vivienda.toJson()));
  }

  Future<Vivienda> eliminarVIvienda()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('vivienda');

    debugPrint('############ ELIMINANDO INFORMACION => VIVIENDA ########## ');

    _vivienda = Vivienda(
      noVivienda: 0, 
      cielo: '', 
      ventilacion: '', 
      iluminacion: '', 
      piso: 0, 
      pared: 0, 
      techo: 0, 
      ambiente: 0, 
      ubicacionCocina: 0, 
      tipoCocina: 0, 
      tenencia: 0
    );
    
    return _vivienda!;
  }
}