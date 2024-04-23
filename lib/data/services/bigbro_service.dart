import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_car/create_car_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/create_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_inspection/create_inspection_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_policy/create_policy_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/get_slip/get_slip_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/login/login_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/paquetes/paquete_stock.dart';

extension ResponseX on Response {
  bool get isSuccess => (statusCode ?? 0) == 200 || (statusCode ?? 0) == 201;
}

class BigBroService {
  final dio = Dio();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'http://181.188.186.158:8000/api/user/token/',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.isSuccess) {
        return LoginResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateClientResponse> createClient({
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
      final response = await dio.post(
        'http://181.188.186.158:8000/api/user/create/client/',
        data: {
          'name': name,
          'last_name': lastName,
          'mother_last_name': motherLastName,
          'cell_phone': cellPhone,
          'birthdate': birthdate,
          'gender': gender,
          'civil_status': civilStatus,
          'document_type': documentType,
          'dni': dni,
          'extension': extension,
          'email': email,
          'country': country,
          'nationality': nationality,
          'city': city,
          'address': address,
          'profession': profession,
          'comercial_activity': comercialActivity,
        },
      );

      if (response.isSuccess) {
        return CreateClientResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  // Future<UpdateClientResponse> updateClientCI({
  Future<bool> updateClientCI({
    required String userId,
    required String name,
    required String lastName,
    required String motherLastName,
    required String profession,
    required String city,
    required File ciFrontal,
    required File ciTrasero,
  }) async {
    try {
      final formData = FormData.fromMap({
        'usuario': userId,
        'nombre': name,
        'apellido_paterno': lastName,
        'apellido_materno': motherLastName,
        'profesion': profession,
        'ciudad': city,
        'ci_frontal': await MultipartFile.fromFile(ciFrontal.path),
        'ci_trasero': await MultipartFile.fromFile(ciTrasero.path),
      });

      final response = await dio.put(
        'http://181.188.186.158:8000/api/datos_personales/update/$userId',
        data: formData,
      );

      if (response.isSuccess) {
        // return UpdateClientResponse.fromJson(response.data);
        return true;
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateClientSignature({
    required String userId,
    required String name,
    required String lastName,
    required String motherLastName,
    required String profession,
    required String city,
    required File signature,
  }) async {
    try {
      final formData = FormData.fromMap({
        'usuario': userId,
        'nombre': name,
        'apellido_paterno': lastName,
        'apellido_materno': motherLastName,
        'profesion': profession,
        'ciudad': city,
        'firma': await MultipartFile.fromFile(signature.path),
      });

      final response = await dio.put(
        'http://181.188.186.158:8000/api/datos_personales/update/$userId',
        data: formData,
      );

      if (response.isSuccess) {
        // return UpdateClientResponse.fromJson(response.data);
        return true;
      }
      throw Exception('Error inesperado');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CreateCarResponse> createCar({
    required int issueValue,
    required int userId,
    required int use,
    required int classId,
    required int city,
    required int model,
    required int year,
  }) async {
    try {
      final response = await dio.post(
        'http://181.188.186.158:8000/api/automovil/create/',
        data: {
          "valor_asegurado": issueValue,
          "usuario": userId,
          "uso": use,
          "clase": classId,
          "ciudad": city,
          "modelo": model,
          "year": year,
        },
      );

      if (response.isSuccess) {
        return CreateCarResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateCarResponse> updateCar({
    required int carId,
    required File ruatPhoto,
    required int issueValue,
    required int userId,
    required int use,
    required int classId,
    required int city,
    required int model,
    required int year,
    required String placa,
    required String color,
    required int asientosNro,
    required String cilindrada,
  }) async {
    try {
      final formData = FormData.fromMap({
        "valor_asegurado": issueValue,
        "usuario": userId,
        "uso": use,
        "clase": classId,
        "ciudad": city,
        "modelo": model,
        "year": year,
        "ruat": await MultipartFile.fromFile(ruatPhoto.path),
        'placa': placa,
        'color': color,
        'asientos_nro': asientosNro,
        'cilindrada': cilindrada,
      });

      final response = await dio.put(
        'http://181.188.186.158:8000/api/automovil/update/$carId',
        data: formData,
      );

      if (response.isSuccess) {
        return CreateCarResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateInspectionResponse> createInspection({
    required String carId,
    required File frontalPhoto,
    required File backPhoto,
  }) async {
    try {
      final formData = FormData.fromMap({
        'foto_frontal': await MultipartFile.fromFile(frontalPhoto.path),
        'foto_trasero': await MultipartFile.fromFile(backPhoto.path),
        'automovil': carId,
      });

      final response = await dio.post(
          'http://181.188.186.158:8000/api/inspeccion/create/',
          data: formData);

      if (response.isSuccess) {
        return CreateInspectionResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateInspectionResponse> updateInspection1({
    required String inspectionId,
    required String carId,
    required File leftPhoto,
    required File rightPhoto,
  }) async {
    try {
      final formData = FormData.fromMap({
        'lateral_izq': await MultipartFile.fromFile(leftPhoto.path),
        'lateral_der': await MultipartFile.fromFile(rightPhoto.path),
        'automovil': carId,
      });

      final response = await dio.put(
        'http://181.188.186.158:8000/api/inspeccion/update/$inspectionId',
        data: formData,
      );

      if (response.isSuccess) {
        return CreateInspectionResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateInspectionResponse> updateInspection2({
    required String inspectionId,
    required String carId,
    required File tablero,
    required File damage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'tablero': await MultipartFile.fromFile(tablero.path),
        'damage': await MultipartFile.fromFile(damage.path),
        'automovil': carId,
      });

      final response = await dio.put(
        'http://181.188.186.158:8000/api/inspeccion/update/$inspectionId',
        data: formData,
      );

      if (response.isSuccess) {
        return CreateInspectionResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<GetSlipResponse> getSlip({
    required int userId,
    required int carId,
    required int stockId,
    required String startDate,
    required String endDate,
    required double prima,
  }) async {
    try {
      final response = await dio.post(
        'http://181.188.186.158:8000/api/poliza/slip/',
        data: {
          'id_datos_personales': userId,
          'id_auto': carId,
          'id_stock': stockId,
          'vigencia_inicio': startDate,
          'vigencia_fin': endDate,
          'prima': prima,
        },
      );

      if (response.isSuccess) {
        return GetSlipResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreatePolicyResponse> createPolicy({
    required String startDate,
    required String endDate,
    required int daysNumber,
    required String coberturas,
    required int userId,
    required int carId,
    required int inspectionId,
    required int companyId,
    required String urlSlip,
    required int renovationNumber,
  }) async {
    try {
      final response = await dio.post(
        'http://181.188.186.158:8000/api/poliza/create/',
        data: {
          "vigencia_inicio": startDate,
          "vigencia_final": endDate,
          "nro_dias": daysNumber,
          "coberturas": coberturas,
          "usuario": userId,
          "datos_personales": userId,
          "automovil": carId,
          "inspeccion": inspectionId,
          "compania": companyId,
          "url_slip": "",
          "nro_renovacion": renovationNumber,
        },
      );

      if (response.isSuccess) {
        return CreatePolicyResponse.fromJson(response.data);
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PaqueteStock>> getPaquetesStock({
    required int city,
    required int brandId,
    required int model,
    required int use,
    required int issueValue,
    required int renovation,
  }) async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/stocks/quotes?city=$city&branch=$brandId&model=$model&use=$use&insured_value=$issueValue&renovation=$renovation',
      );

      if (response.isSuccess) {
        return List<PaqueteStock>.from(
          (response.data as List<dynamic>).map(
            (json) => PaqueteStock.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  // TODO: UPDATE
  Future<String> generateQR(
    String insuranceId,
    String amount,
  ) async {
    try {
      final response = await dio.post(
        'http://br3.abrenet.com:9350/collections/generateQR',
        data: {
          "id": "3aadcc42-ea2e-11ee-9930-0242ac170005",
          "prefix": "vi",
          "amount": amount,
        },
      );

      if (response.isSuccess) {
        return response.data['message'];
      }

      throw Exception('Error inesperado');
    } catch (exception) {
      print(exception);
      rethrow;
    }
  }
}