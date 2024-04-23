class MarcaModel {
  final int id;
  final String nombreMarca;
  final String idAlianzaMarca;
  final bool activo;

  MarcaModel({
    required this.id,
    required this.nombreMarca,
    required this.idAlianzaMarca,
    required this.activo,
  });

  factory MarcaModel.fromJson(Map<String, dynamic> json) => MarcaModel(
        id: json["id"],
        nombreMarca: json["nombre_marca"],
        idAlianzaMarca: json["id_alianza_marca"],
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_marca": nombreMarca,
        "id_alianza_marca": idAlianzaMarca,
        "activo": activo,
      };
}
