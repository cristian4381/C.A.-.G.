// To parse this JSON data, do
//
//     final persona = personaFromJson(jsonString);

import 'dart:convert';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  String nombre;
  String sexo;
  DateTime fechaNacimiento;
  String ocupacion;
  String sabeLeer;
  int escolaridad;
  Map<String, dynamic>? embarazada;

  Persona({
    required this.nombre,
    required this.sexo,
    required this.fechaNacimiento,
    required this.ocupacion,
    required this.sabeLeer,
    required this.escolaridad,
    this.embarazada
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
    nombre: json["nombre"],
    sexo: json["sexo"],
    fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
    ocupacion: json["ocupacion"] ?? 'No aplica',
    sabeLeer: json["sabe_leer"] ?? 'No aplica',
    escolaridad: json["escolaridad"] ?? 1,
    embarazada: json["embarazada"] ?? const {},
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "sexo": sexo,
    "fecha_nacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    "ocupacion": ocupacion,
    "sabe_leer": sabeLeer,
    "escolaridad": escolaridad,
    "embarazada" : embarazada ?? const {}
  };

  @override
  String toString() {
    return 'Persona {\n'
      '  nombre: $nombre,\n'
      '  sexo: $sexo,\n'
      '  fechaNacimiento: $fechaNacimiento,\n'
      '  ocupacion: $ocupacion,\n'
      '  sabeLeer: $sabeLeer,\n'
      '  escolaridad: $escolaridad,\n'
      '  embarazada: $embarazada\n'
    '}';
  }
  
}
