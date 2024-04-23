class ProfesionModel {
  final int id;
  final String nombreProfesion;
  final int idAlianza;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfesionModel({
    required this.id,
    required this.nombreProfesion,
    required this.idAlianza,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfesionModel.fromJson(Map<String, dynamic> json) => ProfesionModel(
        id: json["id"],
        nombreProfesion: json["nombre_profesion"],
        idAlianza: json["id_alianza"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_profesion": nombreProfesion,
        "id_alianza": idAlianza,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
