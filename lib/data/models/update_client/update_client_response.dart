class UpdateClientResponse {
  final int usuario;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String tipoDocumento;
  final String numeroDocumento;
  final String extension;
  final DateTime fechaNacimiento;
  final String genero;
  final String estadoCivil;
  final dynamic nombreConyugue;
  final String nacionalidad;
  final String nroCelular;
  final dynamic nroTelefono;
  final String direccionDomicilio;
  final String direccionComercial;
  final dynamic emailComercial;
  final String actividad;
  final int nroNit;
  final int ingresoMensual;
  final dynamic codigoCliente;
  final String imagen;
  final String ciFrontal;
  final String ciTrasero;
  final String firma;
  final String uif;
  final dynamic cartaNombramiento;
  final String datosClienteAlianza;
  final String codigoClienteAlianza;
  final String codigoClienteAlianzaEncriptado;
  final String revisionEstado;
  final dynamic revisionRespuesta;
  final DateTime revisionFecha;
  final int revisionUsuario;
  final dynamic sudsysId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int paisResidencia;
  final int ciudad;
  final int profesion;
  final List<dynamic> roles;

  UpdateClientResponse({
    required this.usuario,
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
    required this.codigoCliente,
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
    required this.sudsysId,
    required this.createdAt,
    required this.updatedAt,
    required this.paisResidencia,
    required this.ciudad,
    required this.profesion,
    required this.roles,
  });

  factory UpdateClientResponse.fromJson(Map<String, dynamic> json) =>
      UpdateClientResponse(
        usuario: json["usuario"],
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
        codigoCliente: json["codigo_cliente"],
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
        revisionFecha: DateTime.parse(json["revision_fecha"]),
        revisionUsuario: json["revision_usuario"],
        sudsysId: json["sudsys_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paisResidencia: json["pais_residencia"],
        ciudad: json["ciudad"],
        profesion: json["profesion"],
        roles: List<dynamic>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
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
        "codigo_cliente": codigoCliente,
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
        "revision_fecha":
            "${revisionFecha.year.toString().padLeft(4, '0')}-${revisionFecha.month.toString().padLeft(2, '0')}-${revisionFecha.day.toString().padLeft(2, '0')}",
        "revision_usuario": revisionUsuario,
        "sudsys_id": sudsysId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pais_residencia": paisResidencia,
        "ciudad": ciudad,
        "profesion": profesion,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}
