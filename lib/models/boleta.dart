// To parse this JSON data, do
//
//     final boleta = boletaFromJson(jsonString);

import 'dart:convert';

import 'package:ca_and_g/models/models.dart';

Boleta boletaFromJson(String str) => Boleta.fromJson(json.decode(str));

String boletaToJson(Boleta data) => json.encode(data.toJson());

class Boleta {
    int usuario;
    int noFamilia;
    int comunidad;
    int sector;
    Vivienda vivienda;
    Persona jefeFamilia;
    JefeFamilia detalleJefeFamilia;
    List<Persona> familia;
    List<Mascota> mascotas;
    GestionAmbiental gestionAmbiental;
    List<EstablecimientosPublicos> establecimientosPublicos;
    Map<String, dynamic> ubicacion;

    Boleta({
      required this.usuario,
      required this.noFamilia,
      required this.comunidad,
      required this.sector,
      required this.vivienda,
      required this.jefeFamilia,
      required this.detalleJefeFamilia,
      required this.familia,
      required this.mascotas,
      required this.gestionAmbiental,
      required this.establecimientosPublicos,
      required this.ubicacion,
    });

    factory Boleta.fromJson(Map<String, dynamic> json) => Boleta(
        usuario: json["usuario"],
        noFamilia: json["no_familia"],
        comunidad: json["comunidad"],
        sector: json["sector"],
        vivienda: Vivienda.fromJson(json["vivienda"]),
        jefeFamilia: Persona.fromJson(json["jefe_familia"]),
        detalleJefeFamilia: JefeFamilia.fromJson(json["detalle_jefe_familia"]),
        familia: List<Persona>.from(json["familia"].map((x) => Persona.fromJson(x))),
        mascotas: List<Mascota>.from(json["mascotas"].map((x) => Mascota.fromJson(x))),
        gestionAmbiental: GestionAmbiental.fromJson(json["gestion_ambiental"]),
        establecimientosPublicos: List<EstablecimientosPublicos>.from(json["establecimientos_publicos"].map((x) => EstablecimientosPublicos.fromJson(x))),
        ubicacion: json["ubicacion"]
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "no_familia": noFamilia,
        "comunidad": comunidad,
        "sector" : sector,
        "vivienda": vivienda.toJson(),
        "jefe_familia": jefeFamilia.toJson(),
        "detalle_jefe_familia": detalleJefeFamilia.toJson(),
        "familia": List<dynamic>.from(familia.map((x) => x.toJson())),
        "mascotas": List<dynamic>.from(mascotas.map((x) => x.toJson())),
        "gestion_ambiental": gestionAmbiental.toJson(),
        "establecimientos_publicos": List<dynamic>.from(establecimientosPublicos.map((x) => x.toJson())),
        "ubicacion": ubicacion,
    };

    @override
  String toString() {
    
    return 'Boleta {\n'
    ' Usuario: ${usuario}, \n'
    ' no_familia: $noFamilia,\n'
    ' comunidad: $comunidad,\n'
    ' sector: $sector,\n'
    ' vivienda: ${vivienda.toJson()},\n'
    ' jefe_familia: ${detalleJefeFamilia.toJson()},\n'
    ' detalle_jefe_familia: ,\n'
    ' familia: $familia,\n'
    ' mascotas: $mascotas,\n'
    ' gestion_ambiental: ${gestionAmbiental.toJson()},\n'
    ' establecimientos_publicos: $establecimientosPublicos,\n'
    ' ubicacion: $ubicacion,\n';
  }
}