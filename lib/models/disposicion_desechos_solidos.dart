// To parse this JSON data, do
//
//     final disposicionDesechosSolidos = disposicionDesechosSolidosFromJson(jsonString);

import 'dart:convert';

DisposicionDesechosSolidos disposicionDesechosSolidosFromJson(String str) => DisposicionDesechosSolidos.fromJson(json.decode(str));

String disposicionDesechosSolidosToJson(DisposicionDesechosSolidos data) => json.encode(data.toJson());

class DisposicionDesechosSolidos {
    int id;
    String tipo;

    DisposicionDesechosSolidos({
        required this.id,
        required this.tipo,
    });

    factory DisposicionDesechosSolidos.fromJson(Map<String, dynamic> json) => DisposicionDesechosSolidos(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
