// To parse this JSON data, do
//
//     final vivienda = viviendaFromJson(jsonString);

import 'dart:convert';

Vivienda viviendaFromJson(String str) => Vivienda.fromJson(json.decode(str));

String viviendaToJson(Vivienda data) => json.encode(data.toJson());

class Vivienda {
  int noVivienda;
  String cielo;
  String ventilacion;
  String iluminacion;
  int piso;
  int pared;
  int techo;
  int ambiente;
  int ubicacionCocina;
  int tipoCocina;
  int tenencia;

  Vivienda({
    required this.noVivienda,
    required this.cielo,
    required this.ventilacion,
    required this.iluminacion,
    required this.piso,
    required this.pared,
    required this.techo,
    required this.ambiente,
    required this.ubicacionCocina,
    required this.tipoCocina,
    required this.tenencia,
  });

  factory Vivienda.fromJson(Map<String, dynamic> json) => Vivienda(
    noVivienda: json["no_vivienda"],
    cielo: json["cielo"],
    ventilacion: json["ventilacion"],
    iluminacion: json["iluminacion"],
    piso: json["piso"],
    pared: json["pared"],
    techo: json["techo"],
    ambiente: json["ambiente"],
    ubicacionCocina: json["ubicacion_cocina"],
    tipoCocina: json["tipo_cocina"],
    tenencia: json["tenencia"],
  );

  Map<String, dynamic> toJson() => {
    "no_vivienda": noVivienda,
    "cielo": cielo,
    "ventilacion": ventilacion,
    "iluminacion": iluminacion,
    "piso": piso,
    "pared": pared,
    "techo": techo,
    "ambiente": ambiente,
    "ubicacion_cocina": ubicacionCocina,
    "tipo_cocina": tipoCocina,
    "tenencia": tenencia,
  };

  Vivienda copyWith({
    int? noVivienda,
    String? cielo,
    String? ventilacion,
    String? iluminacion,
    int? piso,
    int? pared,
    int? techo,
    int? ambiente,
    int? ubicacionCocina,
    int? tipoCocina,
    int? tenencia,
  }) => Vivienda(
    noVivienda: noVivienda ?? this.noVivienda, 
    cielo: cielo ?? this.cielo, 
    ventilacion: ventilacion ?? this.ventilacion, 
    iluminacion: iluminacion ?? this.iluminacion, 
    piso: piso ?? this.piso, 
    pared: pared ?? this.pared, 
    techo: techo ?? this.techo, 
    ambiente: ambiente ?? this.ambiente, 
    ubicacionCocina: ubicacionCocina ?? this.ubicacionCocina, 
    tipoCocina: tipoCocina ?? this.tipoCocina, 
    tenencia: tenencia ?? this.tenencia
  );

  @override
  String toString() {
    return 'Vivienda {\n'
      '  no_vivienda: $noVivienda,\n'
      '  cielo: $cielo,\n'
      '  ventilacion: $ventilacion,\n'
      '  iluminacion: $iluminacion,\n'
      '  piso: $piso,\n'
      '  pared: $pared,\n'
      '  techo: $techo,\n'
      '  ambiente: $ambiente,\n'
      '  ubicacion_cocina: $ubicacionCocina,\n'
      '  tipo_cocina: $tipoCocina,\n'
      '  tenencia: $tenencia,\n'
    '}';
  }
}