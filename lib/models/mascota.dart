// To parse this JSON data, do
//
//     final Mascota = MascotaFromJson(jsonString);

import 'dart:convert';

Mascota mascotaFromJson(String str) => Mascota.fromJson(json.decode(str));

String mascotaToJson(Mascota data) => json.encode(data.toJson());

class Mascota {
    int tipoMascota;
    String nombreTipoMascota;
    String ubicacion;
    int cantidad;

    Mascota({
        required this.tipoMascota,
        required this.ubicacion,
        required this.cantidad,
        required this.nombreTipoMascota,
    });

    factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
        tipoMascota: json["tipo_mascota"] ?? 0,
        ubicacion: json["ubicacion"] ?? '',
        cantidad: json["cantidad"] ?? 0,
        nombreTipoMascota: json["nombre_tipo_mascota"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "tipo_mascota": tipoMascota,
        "ubicacion": ubicacion,
        "cantidad": cantidad,
        "nombre_tipo_mascota": nombreTipoMascota
    };
}
