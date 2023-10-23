// To parse this JSON data, do
//
//     final ubicacionCocina = ubicacionCocinaFromJson(jsonString);

import 'dart:convert';

UbicacionCocina ubicacionCocinaFromJson(String str) => UbicacionCocina.fromJson(json.decode(str));

String ubicacionCocinaToJson(UbicacionCocina data) => json.encode(data.toJson());

class UbicacionCocina {
    int id;
    String ubicacion;

    UbicacionCocina({
        required this.id,
        required this.ubicacion,
    });

    factory UbicacionCocina.fromJson(Map<String, dynamic> json) => UbicacionCocina(
        id: json["id"],
        ubicacion: json["ubicacion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ubicacion": ubicacion,
    };
}
