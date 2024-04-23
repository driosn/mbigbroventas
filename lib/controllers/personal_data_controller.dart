import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/create_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/ciudad_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/pais_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/profesion_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/tipo_documento_model.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_extra_service.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';

class PersonalDataController extends ChangeNotifier {
  PersonalDataController()
      : getExtraDataStatus = BigBroStatus.initial,
        tipoDocumentos = <TipoDocumentoModel>[],
        paises = <PaisModel>[],
        profesiones = <ProfesionModel>[],
        ciudades = <CiudadModel>[];

  final BigBroService bigBroService = BigBroService();
  final BigBroExtraService bigBroExtraService = BigBroExtraService();
  //
  // Attributes
  //
  // Extra Data
  //
  BigBroStatus getExtraDataStatus;
  List<TipoDocumentoModel> tipoDocumentos;
  List<PaisModel> paises;
  List<ProfesionModel> profesiones;
  List<CiudadModel> ciudades;
  //
  // Create User
  //
  String name = '';
  String lastName = '';
  String motherLastName = '';
  String cellPhone = '';
  String birthdate = '';
  String gender = '';
  String civilStatus = '';
  String documentType = '';
  String dni = '';
  String extension = '';
  String email = '';
  String country = '';
  String nationality = '';
  String city = '';
  String address = '';
  String profession = '';
  String comercialActivity = '';
  int userId = 0;

  Future<CreateClientResponse?> createClient({
    required String name,
    required String lastName,
    required String motherLastName,
    required String cellPhone,
    required String birthdate,
    required String gender,
    required String civilStatus,
    required String documentType,
    required String dni,
    required String extension,
    required String email,
    required String country,
    required String nationality,
    required String city,
    required String address,
    required String profession,
    required String comercialActivity,
  }) async {
    try {
      final clientResponse = await bigBroService.createClient(
        name: name,
        lastName: lastName,
        motherLastName: motherLastName,
        cellPhone: cellPhone,
        birthdate: birthdate,
        gender: gender,
        civilStatus: civilStatus,
        documentType: documentType,
        dni: dni,
        extension: extension,
        email: email,
        country: country,
        nationality: nationality,
        city: city,
        address: address,
        profession: profession,
        comercialActivity: comercialActivity,
      );

      this.name = name;
      this.lastName = lastName;
      this.motherLastName = motherLastName;
      this.cellPhone = cellPhone;
      this.birthdate = birthdate;
      this.gender = gender;
      this.civilStatus = civilStatus;
      this.documentType = documentType;
      this.dni = dni;
      this.extension = extension;
      this.email = email;
      this.country = country;
      this.nationality = nationality;
      this.city = city;
      this.address = address;
      this.profession = profession;
      this.comercialActivity = comercialActivity;

      userId = clientResponse.result;

      return clientResponse;
    } catch (e) {
      return null;
    }
  }

  //
  // UpdateClient
  //
  Future<bool?> updateClientCI({
    required File ciFrontal,
    required File ciTrasero,
  }) async {
    try {
      final clientUpdateResponse = await bigBroService.updateClientCI(
        userId: userId.toString(),
        name: name,
        lastName: lastName,
        motherLastName: motherLastName,
        city: city,
        profession: profession,
        ciFrontal: ciFrontal,
        ciTrasero: ciTrasero,
      );

      return clientUpdateResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> updateClientSignature({
    required File signature,
  }) async {
    try {
      final clientUpdateResponse = await bigBroService.updateClientSignature(
        userId: userId.toString(),
        name: name,
        lastName: lastName,
        motherLastName: motherLastName,
        city: city,
        profession: profession,
        signature: signature,
      );

      return clientUpdateResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getExtraData() async {
    try {
      getExtraDataStatus = BigBroStatus.loading;
      notifyListeners();
      tipoDocumentos = await bigBroExtraService.getTipoDocumento();
      tipoDocumentos.add(
        TipoDocumentoModel(
          id: 0,
          descripcion: 'Seleccione una extensión',
          abreviacion: 'NN',
          activo: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      paises = await bigBroExtraService.getPais();
      paises.add(
        PaisModel(
          id: 0,
          nombrePais: 'Selecciona un país',
          activo: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      ciudades = await bigBroExtraService.getCiudad();
      ciudades.add(CiudadModel(
        id: 0,
        nombreCiudad: 'Selecciona una ciudad',
        activo: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      profesiones = await bigBroExtraService.getProfesion();
      profesiones.add(
        ProfesionModel(
          id: 0,
          nombreProfesion: 'Selecciona una profesión',
          idAlianza: 0,
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
}
