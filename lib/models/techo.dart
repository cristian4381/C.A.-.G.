// To parse this JSON data, do
//
//     final techo = techoFromJson(jsonString);

import 'dart:convert';

Techo techoFromJson(String str) => Techo.fromJson(json.decode(str));

String techoToJson(Techo data) => json.encode(data.toJson());

class Techo {
    int id;
    String tipo;

    Techo({
        required this.id,
        required this.tipo,
    });

    factory Techo.fromJson(Map<String, dynamic> json) => Techo(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
