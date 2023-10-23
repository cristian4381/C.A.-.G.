// To parse this JSON data, do
//
//     final jefeFamilia = jefeFamiliaFromJson(jsonString);

import 'dart:convert';

JefeFamilia jefeFamiliaFromJson(String str) => JefeFamilia.fromJson(json.decode(str));

String jefeFamiliaToJson(JefeFamilia data) => json.encode(data.toJson());

class JefeFamilia {
  int estadoCivil;
  int religion;
  int procedencia;

  JefeFamilia({
    required this.estadoCivil,
    required this.religion,
    required this.procedencia,
  });

  factory JefeFamilia.fromJson(Map<String, dynamic> json) => JefeFamilia(
    estadoCivil: json["estado_civil"],
    religion: json["religion"],
    procedencia: json["procedencia"],
  );

  Map<String, dynamic> toJson() => {
    "estado_civil": estadoCivil,
    "religion": religion,
    "procedencia": procedencia,
  };

  @override
  String toString() {
    
    return 'Jefe_Familia {\n'
      '  Estado_civil: $estadoCivil\n'
      '  Religion: $religion'
      '  Procedencia: $procedencia\n'
    '}';
  }
}
