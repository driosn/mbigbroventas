class SearchClientResponse {
  bool success;
  Client data;
  int result;

  SearchClientResponse({
    required this.success,
    required this.data,
    required this.result,
  });

  factory SearchClientResponse.fromJson(Map<String, dynamic> json) =>
      SearchClientResponse(
        success: json["success"],
        data: Client.fromJson(json["data"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "result": result,
      };
}

class Client {
  int usuarioId;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String tipoDocumento;
  String numeroDocumento;
  String extension;
  DateTime fechaNacimiento;
  String genero;
  String estadoCivil;
  String? nombreConyugue;
  String nacionalidad;
  String nroCelular;
  String? nroTelefono;
  String direccionDomicilio;
  String direccionComercial;
  String? emailComercial;
  String actividad;
  int nroNit;
  int ingresoMensual;
  String? imagen;
  String ciFrontal;
  String ciTrasero;
  String firma;
  dynamic uif;
  dynamic cartaNombramiento;
  dynamic datosClienteAlianza;
  dynamic codigoClienteAlianza;
  dynamic codigoClienteAlianzaEncriptado;
  String revisionEstado;
  dynamic revisionRespuesta;
  dynamic revisionFecha;
  int revisionUsuario;
  DateTime createdAt;
  DateTime updatedAt;
  int ciudadId;
  int paisResidenciaId;
  int profesionId;
  Usuario usuario;

  Client({
    required this.usuarioId,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.extension,
    required this.fechaNacimiento,
    required this.genero,
    required this.estadoCivil,
    required this.nombreConyugue,
    required this.nacionalidad,
    required this.nroCelular,
    required this.nroTelefono,
    required this.direccionDomicilio,
    required this.direccionComercial,
    required this.emailComercial,
    required this.actividad,
    required this.nroNit,
    required this.ingresoMensual,
    required this.imagen,
    required this.ciFrontal,
    required this.ciTrasero,
    required this.firma,
    required this.uif,
    required this.cartaNombramiento,
    required this.datosClienteAlianza,
    required this.codigoClienteAlianza,
    required this.codigoClienteAlianzaEncriptado,
    required this.revisionEstado,
    required this.revisionRespuesta,
    required this.revisionFecha,
    required this.revisionUsuario,
    required this.createdAt,
    required this.updatedAt,
    required this.ciudadId,
    required this.paisResidenciaId,
    required this.profesionId,
    required this.usuario,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        usuarioId: json["usuario_id"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        tipoDocumento: json["tipo_documento"],
        numeroDocumento: json["numero_documento"],
        extension: json["extension"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        genero: json["genero"],
        estadoCivil: json["estado_civil"],
        nombreConyugue: json["nombre_conyugue"],
        nacionalidad: json["nacionalidad"],
        nroCelular: json["nro_celular"],
        nroTelefono: json["nro_telefono"],
        direccionDomicilio: json["direccion_domicilio"],
        direccionComercial: json["direccion_comercial"],
        emailComercial: json["email_comercial"],
        actividad: json["actividad"],
        nroNit: json["nro_nit"],
        ingresoMensual: json["ingreso_mensual"],
        imagen: json["imagen"],
        ciFrontal: json["ci_frontal"],
        ciTrasero: json["ci_trasero"],
        firma: json["firma"],
        uif: json["uif"],
        cartaNombramiento: json["carta_nombramiento"],
        datosClienteAlianza: json["datos_cliente_alianza"],
        codigoClienteAlianza: json["codigo_cliente_alianza"],
        codigoClienteAlianzaEncriptado:
            json["codigo_cliente_alianza_encriptado"],
        revisionEstado: json["revision_estado"],
        revisionRespuesta: json["revision_respuesta"],
        revisionFecha: json["revision_fecha"],
        revisionUsuario: json["revision_usuario"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ciudadId: json["ciudad_id"],
        paisResidenciaId: json["pais_residencia_id"],
        profesionId: json["profesion_id"],
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "usuario_id": usuarioId,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "tipo_documento": tipoDocumento,
        "numero_documento": numeroDocumento,
        "extension": extension,
        "fecha_nacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "genero": genero,
        "estado_civil": estadoCivil,
        "nombre_conyugue": nombreConyugue,
        "nacionalidad": nacionalidad,
        "nro_celular": nroCelular,
        "nro_telefono": nroTelefono,
        "direccion_domicilio": direccionDomicilio,
        "direccion_comercial": direccionComercial,
        "email_comercial": emailComercial,
        "actividad": actividad,
        "nro_nit": nroNit,
        "ingreso_mensual": ingresoMensual,
        "imagen": imagen,
        "ci_frontal": ciFrontal,
        "ci_trasero": ciTrasero,
        "firma": firma,
        "uif": uif,
        "carta_nombramiento": cartaNombramiento,
        "datos_cliente_alianza": datosClienteAlianza,
        "codigo_cliente_alianza": codigoClienteAlianza,
        "codigo_cliente_alianza_encriptado": codigoClienteAlianzaEncriptado,
        "revision_estado": revisionEstado,
        "revision_respuesta": revisionRespuesta,
        "revision_fecha": revisionFecha,
        "revision_usuario": revisionUsuario,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ciudad_id": ciudadId,
        "pais_residencia_id": paisResidenciaId,
        "profesion_id": profesionId,
        "usuario": usuario.toJson(),
      };
}

class Usuario {
  String email;
  String name;

  Usuario({
    required this.email,
    required this.name,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
