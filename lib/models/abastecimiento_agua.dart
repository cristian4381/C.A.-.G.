// To parse this JSON data, do
//
//     final abastecimientoAgua = abastecimientoAguaFromJson(jsonString);

import 'dart:convert';

AbastecimientoAgua abastecimientoAguaFromJson(String str) => AbastecimientoAgua.fromJson(json.decode(str));

String abastecimientoAguaToJson(AbastecimientoAgua data) => json.encode(data.toJson());

class AbastecimientoAgua {
    int id;
    String tipo;

    AbastecimientoAgua({
        required this.id,
        required this.tipo,
    });

    factory AbastecimientoAgua.fromJson(Map<String, dynamic> json) => AbastecimientoAgua(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}
