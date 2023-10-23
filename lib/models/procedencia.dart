// To parse this JSON data, do
//
//     final Procedencia = pisoFromJson(jsonString);

import 'dart:convert';

Procedencia procedenciaFromJson(String str) => Procedencia.fromJson(json.decode(str));

String procedenciaToJson(Procedencia data) => json.encode(data.toJson());

class Procedencia {
    int id;
    String tipo;

    Procedencia({
        required this.id,
        required this.tipo,
    });

    factory Procedencia.fromJson(Map<String, dynamic> json) => Procedencia(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
