// To parse this JSON data, do
//
//     final disposicionExcretas = disposicionExcretasFromJson(jsonString);

import 'dart:convert';

DisposicionExcretas disposicionExcretasFromJson(String str) => DisposicionExcretas.fromJson(json.decode(str));

String disposicionExcretasToJson(DisposicionExcretas data) => json.encode(data.toJson());

class DisposicionExcretas {
    int id;
    String tipo;

    DisposicionExcretas({
        required this.id,
        required this.tipo,
    });

    factory DisposicionExcretas.fromJson(Map<String, dynamic> json) => DisposicionExcretas(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
