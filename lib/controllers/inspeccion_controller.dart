import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_inspection/create_inspection_response.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';

class InspeccionController extends ChangeNotifier {
  final BigBroService bigBroService = BigBroService();

  int inspectionId = 0;

  Future<CreateInspectionResponse?> createInspection({
    required File frontalPhoto,
    required File backPhoto,
    required int carId,
  }) async {
    try {
      final inspectionResponse = await bigBroService.createInspection(
        backPhoto: backPhoto,
        frontalPhoto: frontalPhoto,
        carId: carId.toString(),
      );

      inspectionId = inspectionResponse.id;

      return inspectionResponse;
    } catch (e) {
      return null;
    }
  }

  Future<CreateInspectionResponse?> update1({
    required File lateralIzq,
    required File lateralDer,
    required int carId,
  }) async {
    try {
      final inspectionResponse = await bigBroService.updateInspection1(
        inspectionId: inspectionId.toString(),
        leftPhoto: lateralIzq,
        rightPhoto: lateralDer,
        carId: carId.toString(),
      );

      return inspectionResponse;
    } catch (e) {
      return null;
    }
  }

  Future<CreateInspectionResponse?> update2({
    required File tablero,
    required File? damage,
    required int carId,
  }) async {
    try {
      final inspectionResponse = await bigBroService.updateInspection2(
        inspectionId: inspectionId.toString(),
        damage: damage,
        tablero: tablero,
        carId: carId.toString(),
      );

      return inspectionResponse;
    } catch (e) {
      return null;
    }
  }
}
