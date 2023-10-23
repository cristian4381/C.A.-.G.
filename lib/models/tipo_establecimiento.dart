// To parse this JSON data, do
//
//     final tipoEstablecimiento = tipoEstablecimientoFromJson(jsonString);

import 'dart:convert';

TipoEstablecimiento tipoEstablecimientoFromJson(String str) => TipoEstablecimiento.fromJson(json.decode(str));

String tipoEstablecimientoToJson(TipoEstablecimiento data) => json.encode(data.toJson());

class TipoEstablecimiento {
    int id;
    String tipo;

    TipoEstablecimiento({
        required this.id,
        required this.tipo,
    });

    factory TipoEstablecimiento.fromJson(Map<String, dynamic> json) => TipoEstablecimiento(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
