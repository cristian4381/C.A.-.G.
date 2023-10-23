import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComunidadServices{

  Future<Map<int, String>> buscarSectores (int idComunidad) async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    List<Comunidad> comunidades = informacion.comunidad;
    List<Sector> sectores =  [];

    for (var com in comunidades) {
      if(com.id == idComunidad){
        sectores = com.sector;
      }
    }


    Map<int, String> mapSectores = { for (var element in sectores) element.id : element.nombre };
    return mapSectores;
  }

  Future<Sector> buscarSector (int idComunidad, int idSector) async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    List<Comunidad> comunidades = informacion.comunidad;
    List<Sector> sectores =  [];
    Sector sector = Sector(id: 0, nombre: '', comunidad: 0);

    for (var com in comunidades) {
      if(com.id == idComunidad){
        sectores = com.sector;
      }
    }

    for(var sect in sectores){
      if(sect.id == idSector){
        sector = sect;
      }
    }

    return sector;

  }

}