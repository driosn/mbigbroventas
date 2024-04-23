import 'package:dio/dio.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/ciudad_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/marca_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/modelo_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/pais_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/profesion_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/tipo_documento_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/uso_model.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/year_model.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';

class BigBroExtraService {
  final dio = Dio();

  Future<List<TipoDocumentoModel>> getTipoDocumento() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/tipo_documento/list/',
      );

      if (response.isSuccess) {
        return List<TipoDocumentoModel>.from(
          (response.data as List<dynamic>).map(
            (json) => TipoDocumentoModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<PaisModel>> getPais() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/pais/list/',
      );

      if (response.isSuccess) {
        return List<PaisModel>.from(
          (response.data as List<dynamic>).map(
            (json) => PaisModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CiudadModel>> getCiudad() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/ciudad/list/',
      );

      if (response.isSuccess) {
        return List<CiudadModel>.from(
          (response.data as List<dynamic>).map(
            (json) => CiudadModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProfesionModel>> getProfesion() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/profesion/list/',
      );

      if (response.isSuccess) {
        return List<ProfesionModel>.from(
          (response.data as List<dynamic>).map(
            (json) => ProfesionModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<YearModel>> getYears() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/year_auto/list/',
      );

      if (response.isSuccess) {
        return List<YearModel>.from(
          (response.data as List<dynamic>).map(
            (json) => YearModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UsoModel>> getUsos() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/uso_auto/list/',
      );

      if (response.isSuccess) {
        return List<UsoModel>.from(
          (response.data as List<dynamic>).map(
            (json) => UsoModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  //
  // Auto
  //
  Future<List<MarcaModel>> getMarca() async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/marca/list/',
      );

      if (response.isSuccess) {
        return List<MarcaModel>.from(
          (response.data as List<dynamic>).map(
            (json) => MarcaModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ModeloModel>> getModelo(int marcaId) async {
    try {
      final response = await dio.get(
        'http://181.188.186.158:8000/api/marks/$marcaId/models',
      );

      if (response.isSuccess) {
        return List<ModeloModel>.from(
          (response.data as List<dynamic>).map(
            (json) => ModeloModel.fromJson(json),
          ),
        );
      }
      throw Exception('Error inesperado');
    } catch (e) {
      rethrow;
    }
  }
}
