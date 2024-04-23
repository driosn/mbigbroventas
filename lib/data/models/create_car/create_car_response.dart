class CreateCarResponse {
  final int id;
  final String valorAsegurado;
  final bool activo;
  final dynamic ruat;
  final dynamic placa;
  final dynamic otroModelo;
  final dynamic chasis;
  final dynamic color;
  final dynamic motor;
  final dynamic asientosNro;
  final dynamic cilindrada;
  final dynamic toneladas;
  final int nroRenovacion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int usuario;
  final int uso;
  final int clase;
  final int ciudad;
  final int modelo;
  final int year;
  final dynamic usuarioVenta;

  CreateCarResponse({
    required this.id,
    required this.valorAsegurado,
    required this.activo,
    required this.ruat,
    required this.placa,
    required this.otroModelo,
    required this.chasis,
    required this.color,
    required this.motor,
    required this.asientosNro,
    required this.cilindrada,
    required this.toneladas,
    required this.nroRenovacion,
    required this.createdAt,
    required this.updatedAt,
    required this.usuario,
    required this.uso,
    required this.clase,
    required this.ciudad,
    required this.modelo,
    required this.year,
    required this.usuarioVenta,
  });

  factory CreateCarResponse.fromJson(Map<String, dynamic> json) =>
      CreateCarResponse(
        id: json["id"],
        valorAsegurado: json["valor_asegurado"],
        activo: json["activo"],
        ruat: json["ruat"],
        placa: json["placa"],
        otroModelo: json["otro_modelo"],
        chasis: json["chasis"],
        color: json["color"],
        motor: json["motor"],
        asientosNro: json["asientos_nro"],
        cilindrada: json["cilindrada"],
        toneladas: json["toneladas"],
        nroRenovacion: json["nro_renovacion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usuario: json["usuario"],
        uso: json["uso"],
        clase: json["clase"],
        ciudad: json["ciudad"],
        modelo: json["modelo"],
        year: json["year"],
        usuarioVenta: json["usuario_venta"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor_asegurado": valorAsegurado,
        "activo": activo,
        "ruat": ruat,
        "placa": placa,
        "otro_modelo": otroModelo,
        "chasis": chasis,
        "color": color,
        "motor": motor,
        "asientos_nro": asientosNro,
        "cilindrada": cilindrada,
        "toneladas": toneladas,
        "nro_renovacion": nroRenovacion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "usuario": usuario,
        "uso": uso,
        "clase": clase,
        "ciudad": ciudad,
        "modelo": modelo,
        "year": year,
        "usuario_venta": usuarioVenta,
      };
}
