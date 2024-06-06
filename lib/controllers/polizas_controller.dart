import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/screens/applications/applications_screen.dart';

class PolizasController extends ChangeNotifier {
  PolizasController()
      : getPolizasStatus = BigBroStatus.initial,
        todasLasPolizas = [];

  final bigbroService = BigBroService();

  BigBroStatus getPolizasStatus;
  List<PolizaConEstado> todasLasPolizas;

  Future<bool> getPolizas() async {
    try {
      getPolizasStatus = BigBroStatus.loading;
      notifyListeners();

      final polizasCaducadas =
          await bigbroService.getPolizaByStatusAndUserToken(
        status: 'CADUCADO',
      );
      final polizasPagadas = await bigbroService.getPolizaByStatusAndUserToken(
        status: 'PAGADO',
      );
      final polizasEmitidas = await bigbroService.getPolizaByStatusAndUserToken(
        status: 'PENDIENTE',
      );

      for (final poliza in polizasCaducadas) {
        todasLasPolizas.add(
          PolizaConEstado(
            poliza: poliza,
            estado: TipoEstado.caducadas,
          ),
        );
      }

      for (final poliza in polizasPagadas) {
        todasLasPolizas.add(
          PolizaConEstado(
            poliza: poliza,
            estado: TipoEstado.pagadas,
          ),
        );
      }

      for (final poliza in polizasEmitidas) {
        todasLasPolizas.add(
          PolizaConEstado(
            poliza: poliza,
            estado: TipoEstado.emitidas,
          ),
        );
      }

      getPolizasStatus = BigBroStatus.success;
      notifyListeners();
      return true;
    } catch (exception) {
      getPolizasStatus = BigBroStatus.failure;
      notifyListeners();
      return false;
    }
  }
}
