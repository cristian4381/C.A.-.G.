import 'dart:convert';
import 'package:ca_and_g/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormularioService{


  bool? _comunidadGuardada;

  FormularioService(){
    _comunidadGuardada = false;
  }

  bool? get comunidadGuardada => _comunidadGuardada; 

  Future<Comunidad>  datosGuardados() async{
    debugPrint('######## VERIFICANDO DATOS => CONFIGURACION COMUNIDAD ########');
    final prefs = await SharedPreferences.getInstance();
    Comunidad comunidad = Comunidad(id: 0, nombre: '', sector: []);
    _comunidadGuardada = prefs.containsKey('comunidadSeleccionada');

    if(_comunidadGuardada!){
      final comunidadSeleccionada = await prefs.getString('comunidadSeleccionada');
      comunidad = comunidadFromJson(comunidadSeleccionada!);
      debugPrint('############ CONFIGURACION ENCONTRADA ########## ');
    }

    return comunidad;
  }

  Future<Sector>  sectorGuardado() async{
    debugPrint('######## VERIFICANDO DATOS => CONFIGURACION SECTOR ########');
    final prefs = await SharedPreferences.getInstance();
    Sector sector = Sector(id: 0, nombre: '', comunidad: 0);

    bool sectorGuardado = prefs.containsKey('sectorSeleccionado');

    if(sectorGuardado){
      final sectorSeleccionado = await prefs.getString('sectorSeleccionado');
      debugPrint(sectorSeleccionado);
      sector = sectorFromJson(sectorSeleccionado!);
      debugPrint('############ CONFIGURACION ENCONTRADA ########## ');
    }

    return sector;
  }


  Future<void> guardarComunidadSeleccionada(Comunidad comunidad, Sector sector) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('comunidadSeleccionada', jsonEncode(comunidad.toJson()));
    await prefs.setString('sectorSeleccionado', jsonEncode(sector.toJson()));
    debugPrint('############ CONFIGURACION GUARDADA ########## ');
  }

  Future<void> eliminarComunidadSeleccionada() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('comunidadSeleccionada');
    await prefs.remove('sectorSeleccionado');
    debugPrint('############ CONFIGURACION ELIMINADO ########## ');
  }

  Future<void> guardarNoStep(int noStep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('noStep', noStep);
  }

  Future<int> buscarNoStep()async{
    final prefs = await SharedPreferences.getInstance();
    int? noStep = prefs.getInt('noStep');
    return noStep ?? 0 ;
  }

  Future<Map<int, String>> comunidades () async {
    final prefs = await SharedPreferences.getInstance();
    final informacionMap = jsonDecode(prefs.getString('informacion')!) as Map<String, dynamic>;
    InformacionResponse informacion = InformacionResponse.fromJson(informacionMap);

    Map<int, String> comunidad = { for (var element in informacion.comunidad) element.id : element.nombre };
    return comunidad;
  }

  Future<void> actualizarListaBoletas(Boleta boleta) async{
    final prefs = await SharedPreferences.getInstance();
    final listaString = prefs.getString('boletas');
    List<Boleta> listaBoletas = [];

    if(listaString != null){
      final listaJson = json.decode(listaString);
      listaBoletas = List<Boleta>.from(listaJson.map((boletaJson) => Boleta.fromJson(boletaJson)));
    }
    listaBoletas.add(boleta);
    final listaStringActualizada = json.encode(listaBoletas.map((newBoleta) => newBoleta.toJson()).toList());
    prefs.setString('boletas', listaStringActualizada);

    debugPrint('######## BOLETAS ACTUALIZADOS ########');
  }

  Future<List<Boleta>> buscarListaBoletas()async{
    final prefs = await SharedPreferences.getInstance();
    List<Boleta> listaBoletas = [];
    final listaString = prefs.getString('boletas');

    if (listaString != null) {
      debugPrint('######## BOLETAS ENCONTRADAS ########');
      final listaJson = json.decode(listaString);
      listaBoletas = List<Boleta>.from(listaJson.map((boletaJson) => Boleta.fromJson(boletaJson)));
    }

    return listaBoletas;
  }

  Future<void> eliminarBoletas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('boletas');
    debugPrint('############ BOLETAS ELIMINADO ########## ');
  }
}