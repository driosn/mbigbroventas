class PaisModel {
  final int id;
  final String nombrePais;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaisModel({
    required this.id,
    required this.nombrePais,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        id: json["id"],
        nombrePais: json["nombre_pais"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_pais": nombrePais,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
