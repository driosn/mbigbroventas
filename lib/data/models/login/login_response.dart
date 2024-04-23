class LoginResponse {
  final int id;
  final String email;
  final bool verificada;
  final bool iniciado;
  final String type;
  final String token;
  final String menus;
  final String usarioNombre;

  LoginResponse({
    required this.id,
    required this.email,
    required this.verificada,
    required this.iniciado,
    required this.type,
    required this.token,
    required this.menus,
    required this.usarioNombre,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        email: json["email"],
        verificada: json["verificada"],
        iniciado: json["iniciado"],
        type: json["type"],
        token: json["token"],
        menus: json["menus"],
        usarioNombre: json["usario_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "verificada": verificada,
        "iniciado": iniciado,
        "type": type,
        "token": token,
        "menus": menus,
        "usario_nombre": usarioNombre,
      };
}
