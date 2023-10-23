// To parse this JSON data, do
//
//     final sector = sectorFromJson(jsonString);

import 'dart:convert';

Sector sectorFromJson(String str) => Sector.fromJson(json.decode(str));

String sectorToJson(Sector data) => json.encode(data.toJson());

class Sector {
    int id;
    String nombre;
    int comunidad;

    Sector({
        required this.id,
        required this.nombre,
        required this.comunidad,
    });

    factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        id: json["id"],
        nombre: json["nombre"],
        comunidad: json["comunidad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "comunidad": comunidad,
    };

    @override
  String toString() {
    return 'Sector {\n id: $id, \n nombre: $nombre, \n idComunidad: $comunidad}';
  }
}
