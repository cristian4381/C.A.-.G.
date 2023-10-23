import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiscelaneosServices {
  
  Map<int, String>? _tiposMascotas;
  Map<int, String>? _tiposEstablecimientos;

  List<Mascota>? _mascotas;
  List<EstablecimientosPublicos>? _establecimientos; 

  bool? _existeMascotas;
  bool? _existeEstablecimientos;

  MiscelaneosServices(){
    _existeEstablecimientos = false;
    _existeMascotas = false;
    _datosGuardados();
  }

  Map<int, String>? get tiposMascotas => _tiposMascotas;
  Map<int, String>? get tiposEstablecimientos => _tiposEstablecimientos;

  List<Mascota>? get  mascotas => _mascotas;
  List<EstablecimientosPublicos>? get  establecimientos => _establecimientos; 

  bool? get existeMascotas => _existeMascotas;
  bool? get existeEstablecimientos => _existeEstablecimientos;


  Future<void> _datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => MISCELANEOS########');
    final prefs = await SharedPreferences.getInstance();
    _existeEstablecimientos = prefs.containsKey('establecimiento');
    _existeMascotas = prefs.containsKey('mascotas');

    if(_existeEstablecimientos!){
      final establecimientosGuardado= json.decode(prefs.getString('establecimiento')!);
      _establecimientos = List<EstablecimientosPublicos>.from(establecimientosGuardado.map((establecimientoJson) => EstablecimientosPublicos.fromJson(establecimientoJson)));
    }

    if(_existeMascotas!){
      final mascotasGuardado = json.decode(prefs.getString('mascotas')!);
      _mascotas = List<Mascota>.from(mascotasGuardado.map((mascotaJson) => Mascota.fromJson(mascotaJson)));
    }
    
  }

  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    _tiposMascotas = { for (var element in informacion.tipoMascota) element.id : element.tipo };
    _tiposEstablecimientos = { for (var element in informacion.tipoEstablecimiento) element.id: element.tipo };

  }

  Future<void> agregarMascota(Mascota mascota) async{
    final prefs = await SharedPreferences.getInstance();
    List<Mascota> listaMascotas = await buscarMascotas();

    listaMascotas.add(mascota);
    _mascotas = listaMascotas;

    final listaStringActualizada = json.encode(listaMascotas.map((newMascota) => newMascota.toJson()).toList());
    prefs.setString('mascotas', listaStringActualizada);
  }

  Future<void> eliminarMascota(int index)async{
    final prefs = await SharedPreferences.getInstance();
    final List<Mascota> mascotas = await buscarMascotas();

    mascotas.removeAt(index);
    prefs.setString('mascotas', json.encode(mascotas));
    _mascotas = mascotas;
  }

  Future<List<Mascota>> buscarMascotas() async{
    final prefs = await SharedPreferences.getInstance();
    List<Mascota> mascotas = [];

    final listaString = prefs.getString('mascotas');

    if (listaString != null) {
      final listaJson = json.decode(listaString);
      mascotas = List<Mascota>.from(listaJson.map((mascotaJson) => Mascota.fromJson(mascotaJson)));
    }

    return mascotas;
  }

  Future<List<Mascota>> eliminarListaMascotas()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mascotas');

    debugPrint('############ ELIMINANDO INFORMACION => MASCOTAS ########## ');

    _mascotas = [];

    return _mascotas!;
  }

  Future<List<EstablecimientosPublicos>> buscarEstablecimientos() async{
    final prefs = await SharedPreferences.getInstance();
    List<EstablecimientosPublicos> establecimientos = [];
    
    final listaString = prefs.getString('establecimiento');

    if (listaString != null) {
      final listaJson = json.decode(listaString);
      establecimientos = List<EstablecimientosPublicos>.from(listaJson.map((establecimientoJson) => EstablecimientosPublicos.fromJson(establecimientoJson)));
    }

    return establecimientos;
  }

  Future<void> agregarEstablecimiento(EstablecimientosPublicos establecimiento) async{
    final prefs = await SharedPreferences.getInstance();

    List<EstablecimientosPublicos> listaEstablecimientos = await  buscarEstablecimientos();

    listaEstablecimientos.add(establecimiento);
    _establecimientos = listaEstablecimientos;

    final listaStringActualizada = json.encode(listaEstablecimientos.map((newEstablecimiento) => newEstablecimiento.toJson()).toList());
    prefs.setString('establecimiento', listaStringActualizada);
  }

  Future<void> eliminarEstablecimiento(int index) async{
    final prefs = await SharedPreferences.getInstance();
    final List<EstablecimientosPublicos> establecimientos = await buscarEstablecimientos();

    establecimientos.removeAt(index);
    _establecimientos = establecimientos;
    prefs.setString('establecimiento', json.encode(establecimientos));
  }

  Future<List<EstablecimientosPublicos>> eliminarListaEstablecimientos()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('establecimiento');

    debugPrint('############ ELIMINANDO INFORMACION DE => ESTABLECIMIENTOS ########## ');

    _establecimientos = [];

    return _establecimientos!;
  }
}