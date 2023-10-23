import 'dart:convert';

import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamiliaService {

  List<Persona>? _familia;
  bool? _exisFamilia;
  Map<int, String>? _escolaridad;
  int? _noFamilia;
  
  FamiliaService(){
    _familia = [];
    _exisFamilia = false;
    _noFamilia = 0;
    _datosGuardados();
  }

  bool? get existenDatos => _exisFamilia;
  List<Persona>? get familia => _familia;
  Map<int, String>? get escolaridad => _escolaridad;
  int? get noFamilia => _noFamilia;
  
  Future<void> _datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => FAMILIA ########');
    final prefs = await SharedPreferences.getInstance();
    _exisFamilia = prefs.containsKey('familia');


    if(_exisFamilia!){
      final familiaGuardada = json.decode(prefs.getString('familia')!);
      _familia = List<Persona>.from(familiaGuardada.map((personaJson) => Persona.fromJson(personaJson)));
      debugPrint('######## DATOS ENCONTRADOS => FAMILIA ########');
    }
    _noFamilia = await buscarNofamilia();
  }

  Future<int> buscarNofamilia()async{
    final prefs = await SharedPreferences.getInstance();
    int? noStep = prefs.getInt('noFamilia');
    return noStep ?? 0 ;
  }

  Future<void> cargarDatos()async{
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    _escolaridad = { for (var element in informacion.escolaridad) element.id : element.tipo };
  }
  Future<void> eliminarMiembroFamilia(int index) async{
    final prefs = await SharedPreferences.getInstance();
    final List<Persona> familia = await buscarListaFamilia();

    familia.removeAt(index);
    _familia = familia;

    prefs.setString('familia', json.encode(familia));
    debugPrint('######## ELIMINANDO MIEMBRO FAMILIA ########');
  }

  Future<void> eliminarListaFamilia() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('familia');
    await prefs.remove('noFamilia');
    _familia = [];
    _noFamilia = 0;
    debugPrint('######## DATOS ELIMINADOS => FAMILIA ########');
  }

  Future<void> guardarNoFamilia(int noFamilia) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('noFamilia', noFamilia);
  }

  Future<void> actualizarListafamilia(Persona persona) async{
    final prefs = await SharedPreferences.getInstance();


    final listaString = prefs.getString('familia');
    List<Persona> listaPersonas = [];

    if (listaString != null) {

      final listaJson = json.decode(listaString);
      listaPersonas = List<Persona>.from(listaJson.map((personaJson) => Persona.fromJson(personaJson)));
    }


    listaPersonas.add(persona);
    _familia = listaPersonas;

    final listaStringActualizada = json.encode(listaPersonas.map((persona) => persona.toJson()).toList());
    prefs.setString('familia', listaStringActualizada);

    debugPrint('######## MIEMBROS FAMILIA ACTUALIZADOS ########');
  }


  Future<List<Persona>> buscarListaFamilia()async{
    final prefs = await SharedPreferences.getInstance();
    List<Persona> listaPersonas = [];
    final listaString = prefs.getString('familia');

    if (listaString != null) {
      final listaJson = json.decode(listaString);
      listaPersonas = List<Persona>.from(listaJson.map((personaJson) => Persona.fromJson(personaJson)));
    }

    return listaPersonas;
  }
}