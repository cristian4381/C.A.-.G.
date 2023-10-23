// To parse this JSON data, do
//
//     final embarazada = embarazadaFromJson(jsonString);

import 'dart:convert';

Embarazada embarazadaFromJson(String str) => Embarazada.fromJson(json.decode(str));

String embarazadaToJson(Embarazada data) => json.encode(data.toJson());

class Embarazada {
    String mesesGestacion;
    String llevaControl;
    String lugarControl;
    String telefono;

    Embarazada({
        required this.mesesGestacion,
        required this.llevaControl,
        required this.lugarControl,
        required this.telefono,
    });

    factory Embarazada.fromJson(Map<String, dynamic> json) => Embarazada(
        mesesGestacion: json["meses_gestacion"],
        llevaControl: json["lleva_control"],
        lugarControl: json["lugar_control"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "meses_gestacion": mesesGestacion,
        "lleva_control": llevaControl,
        "lugar_control": lugarControl,
        "telefono": telefono,
    };
}
