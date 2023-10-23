// To parse this JSON data, do
//
//     final escolaridad = escolaridadFromJson(jsonString);

import 'dart:convert';

Escolaridad escolaridadFromJson(String str) => Escolaridad.fromJson(json.decode(str));

String escolaridadToJson(Escolaridad data) => json.encode(data.toJson());

class Escolaridad {
    int id;
    String tipo;

    Escolaridad({
        required this.id,
        required this.tipo,
    });

    factory Escolaridad.fromJson(Map<String, dynamic> json) => Escolaridad(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
