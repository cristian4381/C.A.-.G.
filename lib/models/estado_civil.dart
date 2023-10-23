// To parse this JSON data, do
//
//     final EstadoCivil = pisoFromJson(jsonString);

import 'dart:convert';

EstadoCivil estadoCivilFromJson(String str) => EstadoCivil.fromJson(json.decode(str));

String estadoCivilToJson(EstadoCivil data) => json.encode(data.toJson());

class EstadoCivil {
    int id;
    String tipo;

    EstadoCivil({
        required this.id,
        required this.tipo,
    });

    factory EstadoCivil.fromJson(Map<String, dynamic> json) => EstadoCivil(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
