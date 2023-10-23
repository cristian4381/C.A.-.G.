// To parse this JSON data, do
//
//     final tenencia = tenenciaFromJson(jsonString);

import 'dart:convert';

Tenencia tenenciaFromJson(String str) => Tenencia.fromJson(json.decode(str));

String tenenciaToJson(Tenencia data) => json.encode(data.toJson());

class Tenencia {
    int id;
    String tipo;

    Tenencia({
        required this.id,
        required this.tipo,
    });

    factory Tenencia.fromJson(Map<String, dynamic> json) => Tenencia(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}