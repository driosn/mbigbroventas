class CreateInspectionResponse {
  int id;
  dynamic fotoFrontal;
  dynamic codigoFotoFrontalAlianza;
  dynamic fotoTrasero;
  dynamic codigoFotoTraseroAlianza;
  dynamic lateralIzq;
  dynamic codigoLateralIzqAlianza;
  dynamic lateralDer;
  dynamic codigoLateralDerAlianza;
  dynamic velocimetro;
  dynamic codigoVelocimetroAlianza;
  dynamic llanta;
  dynamic tablero;
  dynamic codigoTableroAlianza;
  dynamic damage;
  dynamic codigoDamageAlianza;
  String revisionEstado;
  dynamic revisionRespuesta;
  dynamic revisionFecha;
  int revisionUsuario;
  dynamic codigoInspeccionAlianza;
  DateTime createdAt;
  DateTime updatedAt;
  int automovil;

  CreateInspectionResponse({
    required this.id,
    required this.fotoFrontal,
    required this.codigoFotoFrontalAlianza,
    required this.fotoTrasero,
    required this.codigoFotoTraseroAlianza,
    required this.lateralIzq,
    required this.codigoLateralIzqAlianza,
    required this.lateralDer,
    required this.codigoLateralDerAlianza,
    required this.velocimetro,
    required this.codigoVelocimetroAlianza,
    required this.llanta,
    required this.tablero,
    required this.codigoTableroAlianza,
    required this.damage,
    required this.codigoDamageAlianza,
    required this.revisionEstado,
    required this.revisionRespuesta,
    required this.revisionFecha,
    required this.revisionUsuario,
    required this.codigoInspeccionAlianza,
    required this.createdAt,
    required this.updatedAt,
    required this.automovil,
  });

  factory CreateInspectionResponse.fromJson(Map<String, dynamic> json) =>
      CreateInspectionResponse(
        id: json["id"],
        fotoFrontal: json["foto_frontal"],
        codigoFotoFrontalAlianza: json["codigo_foto_frontal_alianza"],
        fotoTrasero: json["foto_trasero"],
        codigoFotoTraseroAlianza: json["codigo_foto_trasero_alianza"],
        lateralIzq: json["lateral_izq"],
        codigoLateralIzqAlianza: json["codigo_lateral_izq_alianza"],
        lateralDer: json["lateral_der"],
        codigoLateralDerAlianza: json["codigo_lateral_der_alianza"],
        velocimetro: json["velocimetro"],
        codigoVelocimetroAlianza: json["codigo_velocimetro_alianza"],
        llanta: json["llanta"],
        tablero: json["tablero"],
        codigoTableroAlianza: json["codigo_tablero_alianza"],
        damage: json["damage"],
        codigoDamageAlianza: json["codigo_damage_alianza"],
        revisionEstado: json["revision_estado"],
        revisionRespuesta: json["revision_respuesta"],
        revisionFecha: json["revision_fecha"],
        revisionUsuario: json["revision_usuario"],
        codigoInspeccionAlianza: json["codigo_inspeccion_alianza"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        automovil: json["automovil"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foto_frontal": fotoFrontal,
        "codigo_foto_frontal_alianza": codigoFotoFrontalAlianza,
        "foto_trasero": fotoTrasero,
        "codigo_foto_trasero_alianza": codigoFotoTraseroAlianza,
        "lateral_izq": lateralIzq,
        "codigo_lateral_izq_alianza": codigoLateralIzqAlianza,
        "lateral_der": lateralDer,
        "codigo_lateral_der_alianza": codigoLateralDerAlianza,
        "velocimetro": velocimetro,
        "codigo_velocimetro_alianza": codigoVelocimetroAlianza,
        "llanta": llanta,
        "tablero": tablero,
        "codigo_tablero_alianza": codigoTableroAlianza,
        "damage": damage,
        "codigo_damage_alianza": codigoDamageAlianza,
        "revision_estado": revisionEstado,
        "revision_respuesta": revisionRespuesta,
        "revision_fecha": revisionFecha,
        "revision_usuario": revisionUsuario,
        "codigo_inspeccion_alianza": codigoInspeccionAlianza,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "automovil": automovil,
      };
}
