// To parse this JSON data, do
//
//     final ambiente = ambienteFromJson(jsonString);

import 'dart:convert';

Ambiente ambienteFromJson(String str) => Ambiente.fromJson(json.decode(str));

String ambienteToJson(Ambiente data) => json.encode(data.toJson());

class Ambiente {
    int id;
    String tipo;

    Ambiente({
        required this.id,
        required this.tipo,
    });

    factory Ambiente.fromJson(Map<String, dynamic> json) => Ambiente(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
