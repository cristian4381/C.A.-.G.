// To parse this JSON data, do
//
//     final establecimientosPublicos = establecimientosPublicosFromJson(jsonString);

import 'dart:convert';

EstablecimientosPublicos establecimientosPublicosFromJson(String str) => EstablecimientosPublicos.fromJson(json.decode(str));

String establecimientosPublicosToJson(EstablecimientosPublicos data) => json.encode(data.toJson());

class EstablecimientosPublicos {
    int tipo;
    String nombre;

    EstablecimientosPublicos({
      required this.tipo,
      required this.nombre,
    });

    factory EstablecimientosPublicos.fromJson(Map<String, dynamic> json) => EstablecimientosPublicos(
        tipo: json["tipo"] ?? 0,
        nombre: json['nombre'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "nombre": nombre,
    };
}
