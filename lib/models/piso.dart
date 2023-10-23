// To parse this JSON data, do
//
//     final piso = pisoFromJson(jsonString);

import 'dart:convert';

Piso pisoFromJson(String str) => Piso.fromJson(json.decode(str));

String pisoToJson(Piso data) => json.encode(data.toJson());

class Piso {
    int id;
    String tipo;

    Piso({
        required this.id,
        required this.tipo,
    });

    factory Piso.fromJson(Map<String, dynamic> json) => Piso(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
