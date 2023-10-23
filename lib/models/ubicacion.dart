// To parse this JSON data, do
//
//     final ubicacion = ubicacionFromJson(jsonString);

import 'dart:convert';

Ubicacion ubicacionFromJson(String str) => Ubicacion.fromJson(json.decode(str));

String ubicacionToJson(Ubicacion data) => json.encode(data.toJson());

class Ubicacion {
    double latitud;
    double longitud;

    Ubicacion({
        required this.latitud,
        required this.longitud,
    });

    factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
    };
}
