// To parse this JSON data, do
//
//     final gestionAmbiental = gestionAmbientalFromJson(jsonString);

import 'dart:convert';

GestionAmbiental gestionAmbientalFromJson(String str) => GestionAmbiental.fromJson(json.decode(str));

String gestionAmbientalToJson(GestionAmbiental data) => json.encode(data.toJson());

class GestionAmbiental {
  int abastecimientoAgua;
  int disposicionExcretas;
  int disposicionAguasReciduales;
  int disposicionDesechosSolidos;

  GestionAmbiental({
    required this.abastecimientoAgua,
    required this.disposicionExcretas,
    required this.disposicionAguasReciduales,
    required this.disposicionDesechosSolidos,
  });

  factory GestionAmbiental.fromJson(Map<String, dynamic> json) => GestionAmbiental(
    abastecimientoAgua: json["abastecimiento_agua"],
    disposicionExcretas: json["disposicion_excretas"],
    disposicionAguasReciduales: json["disposicion_aguas_reciduales"],
    disposicionDesechosSolidos: json["disposicion_desechos_solidos"],
  );

  Map<String, dynamic> toJson() => {
    "abastecimiento_agua": abastecimientoAgua,
    "disposicion_excretas": disposicionExcretas,
    "disposicion_aguas_reciduales": disposicionAguasReciduales,
    "disposicion_desechos_solidos": disposicionDesechosSolidos,
  };

  @override
  String toString() {
    return 'Gestion ambiental {\n'
      '  abastecimiento_agua: $abastecimientoAgua,\n'
      '  disposicion_excretas: $disposicionExcretas,\n'
      '  disposicion_aguas_reciduales: $disposicionAguasReciduales,\n'
      '  disposicion_desechos_solidos: $disposicionDesechosSolidos,\n'
    '}';

  }
}
