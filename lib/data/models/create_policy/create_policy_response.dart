class CreatePolicyResponse {
  final int id;
  final DateTime vigenciaInicio;
  final DateTime vigenciaFinal;
  final String estadoRevision;
  final int nroDias;
  final String coberturas;
  final int nroRenovacion;
  final String tipoPoliza;
  final String producto;
  final dynamic fechaEmision;
  final dynamic fechaPago;
  final dynamic respuestaAlianza;
  final dynamic nroPoliza;
  final dynamic nroProceso;
  final String primaNeta;
  final String montoPago;
  final String montoComision;
  final dynamic oficinaAlianzaEmitida;
  final dynamic contractAlianza;
  final dynamic receiptAlianza;
  final int codigoProceso;
  final dynamic urlCertificado;
  final dynamic urlCertificadoDescargado;
  final String urlSlip;
  final dynamic urlPago;
  final dynamic urlFactura;
  final bool envioInspeccion;
  final bool envioDocumentos;
  final dynamic respuestaDocumentosAlianza;
  final dynamic respuestaPagoAlianza;
  final dynamic polizaMovimientoSudsys;
  final dynamic liquidacionSudsys;
  final dynamic estadoSudsys;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int usuario;
  final int datosPersonales;
  final int automovil;
  final int inspeccion;
  final int compania;

  CreatePolicyResponse({
    required this.id,
    required this.vigenciaInicio,
    required this.vigenciaFinal,
    required this.estadoRevision,
    required this.nroDias,
    required this.coberturas,
    required this.nroRenovacion,
    required this.tipoPoliza,
    required this.producto,
    required this.fechaEmision,
    required this.fechaPago,
    required this.respuestaAlianza,
    required this.nroPoliza,
    required this.nroProceso,
    required this.primaNeta,
    required this.montoPago,
    required this.montoComision,
    required this.oficinaAlianzaEmitida,
    required this.contractAlianza,
    required this.receiptAlianza,
    required this.codigoProceso,
    required this.urlCertificado,
    required this.urlCertificadoDescargado,
    required this.urlSlip,
    required this.urlPago,
    required this.urlFactura,
    required this.envioInspeccion,
    required this.envioDocumentos,
    required this.respuestaDocumentosAlianza,
    required this.respuestaPagoAlianza,
    required this.polizaMovimientoSudsys,
    required this.liquidacionSudsys,
    required this.estadoSudsys,
    required this.createdAt,
    required this.updatedAt,
    required this.usuario,
    required this.datosPersonales,
    required this.automovil,
    required this.inspeccion,
    required this.compania,
  });

  factory CreatePolicyResponse.fromJson(Map<String, dynamic> json) =>
      CreatePolicyResponse(
        id: json["id"],
        vigenciaInicio: DateTime.parse(json["vigencia_inicio"]),
        vigenciaFinal: DateTime.parse(json["vigencia_final"]),
        estadoRevision: json["estado_revision"],
        nroDias: json["nro_dias"],
        coberturas: json["coberturas"],
        nroRenovacion: json["nro_renovacion"],
        tipoPoliza: json["tipo_poliza"],
        producto: json["producto"],
        fechaEmision: json["fecha_emision"],
        fechaPago: json["fecha_pago"],
        respuestaAlianza: json["respuesta_alianza"],
        nroPoliza: json["nro_poliza"],
        nroProceso: json["nro_proceso"],
        primaNeta: json["prima_neta"],
        montoPago: json["monto_pago"],
        montoComision: json["monto_comision"],
        oficinaAlianzaEmitida: json["oficina_alianza_emitida"],
        contractAlianza: json["contract_alianza"],
        receiptAlianza: json["receipt_alianza"],
        codigoProceso: json["codigo_proceso"],
        urlCertificado: json["url_certificado"],
        urlCertificadoDescargado: json["url_certificado_descargado"],
        urlSlip: json["url_slip"],
        urlPago: json["url_pago"],
        urlFactura: json["url_factura"],
        envioInspeccion: json["envio_inspeccion"],
        envioDocumentos: json["envio_documentos"],
        respuestaDocumentosAlianza: json["respuesta_documentos_alianza"],
        respuestaPagoAlianza: json["respuesta_pago_alianza"],
        polizaMovimientoSudsys: json["poliza_movimiento_sudsys"],
        liquidacionSudsys: json["liquidacion_sudsys"],
        estadoSudsys: json["estado_sudsys"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usuario: json["usuario"],
        datosPersonales: json["datos_personales"],
        automovil: json["automovil"],
        inspeccion: json["inspeccion"],
        compania: json["compania"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vigencia_inicio":
            "${vigenciaInicio.year.toString().padLeft(4, '0')}-${vigenciaInicio.month.toString().padLeft(2, '0')}-${vigenciaInicio.day.toString().padLeft(2, '0')}",
        "vigencia_final":
            "${vigenciaFinal.year.toString().padLeft(4, '0')}-${vigenciaFinal.month.toString().padLeft(2, '0')}-${vigenciaFinal.day.toString().padLeft(2, '0')}",
        "estado_revision": estadoRevision,
        "nro_dias": nroDias,
        "coberturas": coberturas,
        "nro_renovacion": nroRenovacion,
        "tipo_poliza": tipoPoliza,
        "producto": producto,
        "fecha_emision": fechaEmision,
        "fecha_pago": fechaPago,
        "respuesta_alianza": respuestaAlianza,
        "nro_poliza": nroPoliza,
        "nro_proceso": nroProceso,
        "prima_neta": primaNeta,
        "monto_pago": montoPago,
        "monto_comision": montoComision,
        "oficina_alianza_emitida": oficinaAlianzaEmitida,
        "contract_alianza": contractAlianza,
        "receipt_alianza": receiptAlianza,
        "codigo_proceso": codigoProceso,
        "url_certificado": urlCertificado,
        "url_certificado_descargado": urlCertificadoDescargado,
        "url_slip": urlSlip,
        "url_pago": urlPago,
        "url_factura": urlFactura,
        "envio_inspeccion": envioInspeccion,
        "envio_documentos": envioDocumentos,
        "respuesta_documentos_alianza": respuestaDocumentosAlianza,
        "respuesta_pago_alianza": respuestaPagoAlianza,
        "poliza_movimiento_sudsys": polizaMovimientoSudsys,
        "liquidacion_sudsys": liquidacionSudsys,
        "estado_sudsys": estadoSudsys,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "usuario": usuario,
        "datos_personales": datosPersonales,
        "automovil": automovil,
        "inspeccion": inspeccion,
        "compania": compania,
      };
}
