class YearModel {
  final int id;
  final int year;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  YearModel({
    required this.id,
    required this.year,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
        id: json["id"],
        year: json["year"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
