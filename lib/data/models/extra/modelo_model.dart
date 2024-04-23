class ModeloModel {
  final int id;
  final String nombreModelo;
  final String idAlianzaModelo;
  final int idAlianzaTipo;
  final String idAlianzaNombreTipo;
  final bool activo;
  final int marca;
  final String nombreMarca;

  ModeloModel({
    required this.id,
    required this.nombreModelo,
    required this.idAlianzaModelo,
    required this.idAlianzaTipo,
    required this.idAlianzaNombreTipo,
    required this.activo,
    required this.marca,
    required this.nombreMarca,
  });

  factory ModeloModel.fromJson(Map<String, dynamic> json) => ModeloModel(
        id: json["id"],
        nombreModelo: json["nombre_modelo"],
        idAlianzaModelo: json["id_alianza_modelo"],
        idAlianzaTipo: json["id_alianza_tipo"],
        idAlianzaNombreTipo: json["id_alianza_nombre_tipo"],
        activo: json["activo"],
        marca: json["marca"],
        nombreMarca: json["nombre_marca"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_modelo": nombreModelo,
        "id_alianza_modelo": idAlianzaModelo,
        "id_alianza_tipo": idAlianzaTipo,
        "id_alianza_nombre_tipo": idAlianzaNombreTipo,
        "activo": activo,
        "marca": marca,
        "nombre_marca": nombreMarca,
      };
}
