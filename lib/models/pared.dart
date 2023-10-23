// To parse this JSON data, do
//
//     final pared = paredFromJson(jsonString);

import 'dart:convert';

Pared paredFromJson(String str) => Pared.fromJson(json.decode(str));

String paredToJson(Pared data) => json.encode(data.toJson());

class Pared {
    int id;
    String tipo;

    Pared({
        required this.id,
        required this.tipo,
    });

    factory Pared.fromJson(Map<String, dynamic> json) => Pared(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
