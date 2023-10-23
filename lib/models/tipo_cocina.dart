// To parse this JSON data, do
//
//     final tipoCocina = tipoCocinaFromJson(jsonString);

import 'dart:convert';

TipoCocina tipoCocinaFromJson(String str) => TipoCocina.fromJson(json.decode(str));

String tipoCocinaToJson(TipoCocina data) => json.encode(data.toJson());

class TipoCocina {
    int id;
    String tipo;

    TipoCocina({
        required this.id,
        required this.tipo,
    });

    factory TipoCocina.fromJson(Map<String, dynamic> json) => TipoCocina(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
