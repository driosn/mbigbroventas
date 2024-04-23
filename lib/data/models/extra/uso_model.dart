class UsoModel {
  final int id;
  final String nombreUso;
  final bool activo;
  final int idAlianzaUso;
  final DateTime createdAt;
  final DateTime updatedAt;

  UsoModel({
    required this.id,
    required this.nombreUso,
    required this.activo,
    required this.idAlianzaUso,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UsoModel.fromJson(Map<String, dynamic> json) => UsoModel(
        id: json["id"],
        nombreUso: json["nombre_uso"],
        activo: json["activo"],
        idAlianzaUso: json["id_alianza_uso"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_uso": nombreUso,
        "activo": activo,
        "id_alianza_uso": idAlianzaUso,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
