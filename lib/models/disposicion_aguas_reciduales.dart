// To parse this JSON data, do
//
//     final disposicionAguasReciduales = disposicionAguasRecidualesFromJson(jsonString);

import 'dart:convert';

DisposicionAguasReciduales disposicionAguasRecidualesFromJson(String str) => DisposicionAguasReciduales.fromJson(json.decode(str));

String disposicionAguasRecidualesToJson(DisposicionAguasReciduales data) => json.encode(data.toJson());

class DisposicionAguasReciduales {
    int id;
    String tipo;

    DisposicionAguasReciduales({
        required this.id,
        required this.tipo,
    });

    factory DisposicionAguasReciduales.fromJson(Map<String, dynamic> json) => DisposicionAguasReciduales(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
