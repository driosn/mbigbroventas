class TipoDocumentoModel {
  final int id;
  final String descripcion;
  final String abreviacion;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  TipoDocumentoModel({
    required this.id,
    required this.descripcion,
    required this.abreviacion,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        id: json["id"],
        descripcion: json["descripcion"],
        abreviacion: json["abreviacion"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "abreviacion": abreviacion,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
