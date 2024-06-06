class Poliza {
  int idPoliza;
  dynamic nroPoliza;
  String estado;
  String aseguradora;
  int idAutomovil;
  int idModelo;
  String modelo;
  int idMarca;
  String marca;
  String placa;
  int idYear;
  int year;
  int idUso;
  String uso;
  int idCiudad;
  String ciudad;
  double valorAsegurado;
  DateTime vigenciaInicio;
  DateTime vigenciaFinal;
  double prima;
  dynamic urlPago;
  dynamic urlCertificado;
  String coberturas;
  int idInspeccion;
  String fotoFrontal;
  String fotoTrasero;
  String fotoLateralIzq;
  String fotoLateralDer;
  String fotoTablero;
  String fotoRuat;
  DateTime finVigencia;
  int nroRenovacion;
  dynamic fechaPago;
  String motivoRechazo;

  Poliza({
    required this.idPoliza,
    required this.nroPoliza,
    required this.estado,
    required this.aseguradora,
    required this.idAutomovil,
    required this.idModelo,
    required this.modelo,
    required this.idMarca,
    required this.marca,
    required this.placa,
    required this.idYear,
    required this.year,
    required this.idUso,
    required this.uso,
    required this.idCiudad,
    required this.ciudad,
    required this.valorAsegurado,
    required this.vigenciaInicio,
    required this.vigenciaFinal,
    required this.prima,
    required this.urlPago,
    required this.urlCertificado,
    required this.coberturas,
    required this.idInspeccion,
    required this.fotoFrontal,
    required this.fotoTrasero,
    required this.fotoLateralIzq,
    required this.fotoLateralDer,
    required this.fotoTablero,
    required this.fotoRuat,
    required this.finVigencia,
    required this.nroRenovacion,
    required this.fechaPago,
    required this.motivoRechazo,
  });

  factory Poliza.fromJson(Map<String, dynamic> json) => Poliza(
        idPoliza: json["id_poliza"],
        nroPoliza: json["nro_poliza"],
        estado: json["estado"],
        aseguradora: json["aseguradora"],
        idAutomovil: json["id_automovil"],
        idModelo: json["id_modelo"],
        modelo: json["modelo"],
        idMarca: json["id_marca"],
        marca: json["marca"],
        placa: json["placa"],
        idYear: json["id_year"],
        year: json["year"],
        idUso: json["id_uso"],
        uso: json["uso"],
        idCiudad: json["id_ciudad"],
        ciudad: json["ciudad"],
        valorAsegurado: json["valor_asegurado"],
        vigenciaInicio: DateTime.parse(json["vigencia_inicio"]),
        vigenciaFinal: DateTime.parse(json["vigencia_final"]),
        prima: json["prima"],
        urlPago: json["url_pago"],
        urlCertificado: json["url_certificado"],
        coberturas: json["coberturas"],
        idInspeccion: json["id_inspeccion"],
        fotoFrontal: json["foto_frontal"],
        fotoTrasero: json["foto_trasero"],
        fotoLateralIzq: json["foto_lateral_izq"],
        fotoLateralDer: json["foto_lateral_der"],
        fotoTablero: json["foto_tablero"],
        fotoRuat: json["foto_ruat"],
        finVigencia: DateTime.parse(json["fin_vigencia"]),
        nroRenovacion: json["nro_renovacion"],
        fechaPago: json["fecha_pago"],
        motivoRechazo: json["motivo_rechazo"],
      );

  Map<String, dynamic> toJson() => {
        "id_poliza": idPoliza,
        "nro_poliza": nroPoliza,
        "estado": estado,
        "aseguradora": aseguradora,
        "id_automovil": idAutomovil,
        "id_modelo": idModelo,
        "modelo": modelo,
        "id_marca": idMarca,
        "marca": marca,
        "placa": placa,
        "id_year": idYear,
        "year": year,
        "id_uso": idUso,
        "uso": uso,
        "id_ciudad": idCiudad,
        "ciudad": ciudad,
        "valor_asegurado": valorAsegurado,
        "vigencia_inicio":
            "${vigenciaInicio.year.toString().padLeft(4, '0')}-${vigenciaInicio.month.toString().padLeft(2, '0')}-${vigenciaInicio.day.toString().padLeft(2, '0')}",
        "vigencia_final":
            "${vigenciaFinal.year.toString().padLeft(4, '0')}-${vigenciaFinal.month.toString().padLeft(2, '0')}-${vigenciaFinal.day.toString().padLeft(2, '0')}",
        "prima": prima,
        "url_pago": urlPago,
        "url_certificado": urlCertificado,
        "coberturas": coberturas,
        "id_inspeccion": idInspeccion,
        "foto_frontal": fotoFrontal,
        "foto_trasero": fotoTrasero,
        "foto_lateral_izq": fotoLateralIzq,
        "foto_lateral_der": fotoLateralDer,
        "foto_tablero": fotoTablero,
        "foto_ruat": fotoRuat,
        "fin_vigencia":
            "${finVigencia.year.toString().padLeft(4, '0')}-${finVigencia.month.toString().padLeft(2, '0')}-${finVigencia.day.toString().padLeft(2, '0')}",
        "nro_renovacion": nroRenovacion,
        "fecha_pago": fechaPago,
        "motivo_rechazo": motivoRechazo,
      };
}
