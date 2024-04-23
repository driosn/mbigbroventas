class CreateClientResponse {
  final int status;
  final int result;
  final String mensaje;

  CreateClientResponse({
    required this.status,
    required this.result,
    required this.mensaje,
  });

  factory CreateClientResponse.fromJson(Map<String, dynamic> json) =>
      CreateClientResponse(
        status: json["status"],
        result: json["result"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": result,
        "mensaje": mensaje,
      };
}
