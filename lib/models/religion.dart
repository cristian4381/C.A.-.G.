// To parse this JSON data, do
//
//     final Religion = pisoFromJson(jsonString);

import 'dart:convert';

Religion religionFromJson(String str) => Religion.fromJson(json.decode(str));

String religionToJson(Religion data) => json.encode(data.toJson());

class Religion {
    int id;
    String tipo;

    Religion({
        required this.id,
        required this.tipo,
    });

    factory Religion.fromJson(Map<String, dynamic> json) => Religion(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
