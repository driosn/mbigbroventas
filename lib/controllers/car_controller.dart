import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_car/create_car_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/search_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/ciudad_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/marca_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/modelo_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/uso_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/year_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/poliza.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_extra_service.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';

class CarController extends ChangeNotifier {
  CarController()
      : getExtraDataStatus = BigBroStatus.initial,
        modelosStatus = BigBroStatus.initial,
        marcas = <MarcaModel>[],
        years = <YearModel>[],
        usos = <UsoModel>[],
        plazas = <CiudadModel>[],
        modelos = <ModeloModel>[];

  final BigBroService bigBroService = BigBroService();
  final BigBroExtraService bigBroExtraService = BigBroExtraService();
  //
  // Attributes
  //
  // Extra Data
  //
  BigBroStatus getExtraDataStatus;
  List<MarcaModel> marcas;
  List<YearModel> years;
  List<UsoModel> usos;
  List<CiudadModel> plazas;
  //
  //Modelos
  //
  BigBroStatus modelosStatus;
  List<ModeloModel> modelos;

  //
  // Create Car
  //

  int issueValue = 0;
  int userId = 0;
  int uso = 0;
  int clase = 0;
  int ciudad = 0;
  int modelo = 0;
  int marca = 0;
  int year = 0;
  int carId = 0;
  String placa = '';
  String color = '';
  int asientosNro = 0;
  String cilindrada = '';

  String nombreMarca = '';
  String nombreModelo = '';
  String nombreUso = '';
  String nombreCiudad = '';

  void setCarDataByPoliza(Poliza poliza, Client client) {
    issueValue = poliza.valorAsegurado.toInt();
    userId = client.usuarioId;
    uso = poliza.idUso;
    ciudad = poliza.idCiudad;
    modelo = poliza.idModelo;
    marca = poliza.idMarca;
    year = poliza.idYear;
    carId = poliza.idAutomovil;
    placa = poliza.placa;
    nombreMarca = poliza.marca;
    nombreModelo = poliza.modelo;
    nombreUso = poliza.uso;
    nombreCiudad = poliza.ciudad;

    userId = client.usuarioId;
  }

  void updateNames({
    required String nombreMarca,
    required String nombreModelo,
    required String nombreUso,
    required String nombreCiudad,
  }) {
    this.nombreMarca = nombreMarca;
    this.nombreModelo = nombreModelo;
    this.nombreUso = nombreUso;
    this.nombreCiudad = nombreCiudad;
  }

  Future<CreateCarResponse?> createCar({
    required int issueValue,
    required int userId,
    required int uso,
    required int clase,
    required int ciudad,
    required int modelo,
    required int year,
  }) async {
    try {
      final carResponse = await bigBroService.createCar(
        issueValue: issueValue,
        userId: userId,
        use: uso,
        classId: clase,
        city: ciudad,
        model: modelo,
        year: year,
      );

      this.issueValue = issueValue;
      this.userId = userId;
      this.uso = uso;
      this.clase = clase;
      this.ciudad = ciudad;
      this.modelo = modelo;
      this.year = year;

      carId = carResponse.id;

      return carResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CreateCarResponse?> updateValorAsegurado({
    required int carId,
    required int issueValue,
    required int userId,
    required int use,
    required int classId,
    required int city,
    required int model,
    required int year,
  }) async {
    try {
      final carResponse = await bigBroService.updateValorAsegurado(
        carId: carId,
        issueValue: issueValue,
        userId: userId,
        use: use,
        classId: classId,
        city: city,
        model: model,
        year: year,
      );

      return carResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CreateCarResponse?> updateCarWithRuat({
    required File ruatPhoto,
    required int userId,
    required String placa,
    required String color,
    required int asientosNro,
    required String cilindrada,
  }) async {
    try {
      final carResponse = await bigBroService.updateCarWithRuat(
        issueValue: issueValue,
        userId: userId,
        use: uso,
        classId: clase,
        city: ciudad,
        model: modelo,
        year: year,
        asientosNro: asientosNro,
        carId: carId,
        cilindrada: cilindrada,
        color: color,
        placa: placa,
        ruatPhoto: ruatPhoto,
      );

      return carResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getExtraData() async {
    try {
      getExtraDataStatus = BigBroStatus.loading;
      notifyListeners();
      marcas = await bigBroExtraService.getMarca();
      //extra
      years = await bigBroExtraService.getYears();
      years.add(
        YearModel(
          id: 0,
          year: 0,
          activo: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      usos = await bigBroExtraService.getUsos();
      usos.add(
        UsoModel(
          id: 0,
          nombreUso: 'Seleccione tipo de uso',
          activo: true,
          idAlianzaUso: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      plazas = await bigBroExtraService.getCiudad();
      plazas.add(
        CiudadModel(
          id: 0,
          nombreCiudad: 'Seleccione plaza',
          activo: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      getExtraDataStatus = BigBroStatus.success;
      notifyListeners();

      return true;
    } catch (e) {
      getExtraDataStatus = BigBroStatus.failure;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getModelos(int marcaId) async {
    try {
      modelosStatus = BigBroStatus.loading;
      notifyListeners();

      final modelosResp = await bigBroExtraService.getModelo(marcaId);
      modelos = modelosResp;

      marca = marcaId;

      modelosStatus = BigBroStatus.success;
      notifyListeners();

      return true;
    } catch (e) {
      modelosStatus = BigBroStatus.failure;
      notifyListeners();
      return false;
    }
  }
}
