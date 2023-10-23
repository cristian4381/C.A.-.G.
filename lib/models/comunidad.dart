// To parse this JSON data, do
//
//     final comunidad = comunidadFromJson(jsonString);

import 'dart:convert';

import 'package:ca_and_g/models/models.dart';

Comunidad comunidadFromJson(String str) => Comunidad.fromJson(json.decode(str));

String comunidadToJson(Comunidad data) => json.encode(data.toJson());

class Comunidad {
    int id;
    String nombre;
    List<Sector> sector;

    Comunidad({
        required this.id,
        required this.nombre,
        required this.sector,
    });

    factory Comunidad.fromJson(Map<String, dynamic> json) => Comunidad(
        id: json["id"],
        nombre: json["nombre"],
        sector: List<Sector>.from(json["Sector"].map((x) => Sector.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "Sector": List<dynamic>.from(sector.map((x) => x.toJson())),
    };
}
