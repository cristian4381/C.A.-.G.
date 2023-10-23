// To parse this JSON data, do
//
//     final informacionResponse = informacionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ca_and_g/models/models.dart';

InformacionResponse informacionResponseFromJson(String str) => InformacionResponse.fromJson(json.decode(str));

String informacionResponseToJson(InformacionResponse data) => json.encode(data.toJson());

class InformacionResponse {
  final bool ok;
  final List<AbastecimientoAgua> abastecimientoAgua;
  final List<Ambiente> ambiente;
  final List<Comunidad> comunidad;
  final List<DisposicionAguasReciduales> disposicionAguasReciduales;
  final List<DisposicionDesechosSolidos> disposicionDesechosSolidos;
  final List<DisposicionExcretas> disposicionExcretas;
  final List<Escolaridad> escolaridad;
  final List<Pared> pared;
  final List<Piso> piso;
  final List<Techo> techo;
  final List<Tenencia> tenencia;
  final List<TipoCocina> tipoCocina;
  final List<TipoEstablecimiento> tipoEstablecimiento;
  final List<TipoMascota> tipoMascota;
  final List<UbicacionCocina> ubicacionCocina;

  final List<EstadoCivil> estadoCivil;
  final List<Religion> religion;
  final List<Procedencia> procedencia;

  InformacionResponse({
      required this.ok,
      required this.abastecimientoAgua,
      required this.ambiente,
      required this.comunidad,
      required this.disposicionAguasReciduales,
      required this.disposicionDesechosSolidos,
      required this.disposicionExcretas,
      required this.escolaridad,
      required this.pared,
      required this.piso,
      required this.techo,
      required this.tenencia,
      required this.tipoCocina,
      required this.tipoEstablecimiento,
      required this.tipoMascota,
      required this.ubicacionCocina,
      required this.estadoCivil, 
      required this.religion, 
      required this.procedencia, 
  });

  factory InformacionResponse.fromJson(Map<String, dynamic> json) => InformacionResponse(
    ok: json['ok'],
    abastecimientoAgua: List<AbastecimientoAgua>.from(json['abastecimiento_agua'].map((x) => AbastecimientoAgua.fromJson(x))),
    ambiente: List<Ambiente>.from(json['ambiente'].map((x) => Ambiente.fromJson(x))),
    comunidad: List<Comunidad>.from(json['comunidad'].map((x) => Comunidad.fromJson(x))),
    disposicionAguasReciduales: List<DisposicionAguasReciduales>.from(json['disposicion_aguas_reciduale'].map((x) => DisposicionAguasReciduales.fromJson(x))),
    disposicionDesechosSolidos: List<DisposicionDesechosSolidos>.from(json['disposicion_desechos_solidos'].map((x) => DisposicionDesechosSolidos.fromJson(x))),
    disposicionExcretas: List<DisposicionExcretas>.from(json['disposicion_excretas'].map((x) => DisposicionExcretas.fromJson(x))),
    escolaridad: List<Escolaridad>.from(json['escolaridad'].map((x) => Escolaridad.fromJson(x))),
    pared: List<Pared>.from(json['pared'].map((x) => Pared.fromJson(x))),
    piso: List<Piso>.from(json['piso'].map((x) => Piso.fromJson(x))),
    techo: List<Techo>.from(json['techo'].map((x) => Techo.fromJson(x))),
    tenencia: List<Tenencia>.from(json['tenencia'].map((x) => Tenencia.fromJson(x))),
    tipoCocina: List<TipoCocina>.from(json['tipo_cocina'].map((x) => TipoCocina.fromJson(x))),
    tipoEstablecimiento: List<TipoEstablecimiento>.from(json['tipo_establecimiento'].map((x) => TipoEstablecimiento.fromJson(x))),
    tipoMascota: List<TipoMascota>.from(json['tipo_mascota'].map((x) => TipoMascota.fromJson(x))),
    ubicacionCocina: List<UbicacionCocina>.from(json['ubicacion_cocina'].map((x) => UbicacionCocina.fromJson(x))),
    estadoCivil: List<EstadoCivil>.from(json['estado_civil'].map((x) => EstadoCivil.fromJson(x))),
    religion: List<Religion>.from(json['religion'].map((x) => Religion.fromJson(x))),
    procedencia: List<Procedencia>.from(json['procedencia'].map((x) => Procedencia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "ok": ok,
      "abastecimiento_agua": List<dynamic>.from(abastecimientoAgua.map((x) => x.toJson())),
      "ambiente": List<dynamic>.from(ambiente.map((x) => x.toJson())),
      "comunidad": List<dynamic>.from(comunidad.map((x) => x.toJson())),
      "disposicion_aguas_reciduale": List<dynamic>.from(disposicionAguasReciduales.map((x) => x.toJson())),
      "disposicion_desechos_solidos": List<dynamic>.from(disposicionDesechosSolidos.map((x) => x.toJson())),
      "disposicion_excretas": List<dynamic>.from(disposicionExcretas.map((x) => x.toJson())),
      "escolaridad": List<dynamic>.from(escolaridad.map((x) => x.toJson())),
      "pared": List<dynamic>.from(pared.map((x) => x.toJson())),
      "piso": List<dynamic>.from(piso.map((x) => x.toJson())),
      "techo": List<dynamic>.from(techo.map((x) => x.toJson())),
      "tenencia": List<dynamic>.from(tenencia.map((x) => x.toJson())),
      "tipo_cocina": List<dynamic>.from(tipoCocina.map((x) => x.toJson())),
      "tipo_establecimiento": List<dynamic>.from(tipoEstablecimiento.map((x) => x.toJson())),
      "tipo_mascota": List<dynamic>.from(tipoMascota.map((x) => x.toJson())),
      "ubicacion_cocina": List<dynamic>.from(ubicacionCocina.map((x) => x.toJson())),
      "estado_civil": List<dynamic>.from(estadoCivil.map((x) => x.toJson())),
      "religion": List<dynamic>.from(religion.map((x) => x.toJson())),
      "procedencia": List<dynamic>.from(procedencia.map((x) => x.toJson())),
  };
}