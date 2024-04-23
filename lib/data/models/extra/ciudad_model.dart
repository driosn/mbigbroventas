class CiudadModel {
  final int id;
  final String nombreCiudad;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CiudadModel({
    required this.id,
    required this.nombreCiudad,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CiudadModel.fromJson(Map<String, dynamic> json) => CiudadModel(
        id: json["id"],
        nombreCiudad: json["nombre_ciudad"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_ciudad": nombreCiudad,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
