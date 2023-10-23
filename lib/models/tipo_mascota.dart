// To parse this JSON data, do
//
//     final tipoMascota = tipoMascotaFromJson(jsonString);

import 'dart:convert';

TipoMascota tipoMascotaFromJson(String str) => TipoMascota.fromJson(json.decode(str));

String tipoMascotaToJson(TipoMascota data) => json.encode(data.toJson());

class TipoMascota {
    int id;
    String tipo;

    TipoMascota({
        required this.id,
        required this.tipo,
    });

    factory TipoMascota.fromJson(Map<String, dynamic> json) => TipoMascota(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
