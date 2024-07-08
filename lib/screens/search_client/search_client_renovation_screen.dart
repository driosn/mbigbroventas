import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/controllers/car_controller.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/search_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/models/poliza.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:mibigbro_ventas_mobile/screens/plans/plans_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/utils/extensions.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class SearchClientRenovationScreen extends StatefulWidget {
  const SearchClientRenovationScreen({super.key});

  @override
  State<SearchClientRenovationScreen> createState() =>
      _SearchClientRenovationScreenState();
}

class _SearchClientRenovationScreenState
    extends State<SearchClientRenovationScreen> {
  final _bigBroService = BigBroService();

  late ValueNotifier<bool> _isLoadingNotifier;

  late ValueNotifier<List<Poliza>?> polizasNotifier;
  late ValueNotifier<Client?> clientNotifier;

  final _ciController = TextEditingController();

  final CarController carController = CarController();
  final PersonalDataController personalDataController =
      PersonalDataController();

  @override
  void initState() {
    _isLoadingNotifier = ValueNotifier<bool>(false);
    polizasNotifier = ValueNotifier<List<Poliza>?>(null);
    clientNotifier = ValueNotifier<Client?>(null);
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  _actualizarValor(
    Poliza poliza,
    int idAuto,
    int idUser,
    valorAsegurado,
    marcaAuto,
    modeloAuto,
    anoAuto,
    usoAuto,
    ciudadAuto,
    idInspeccion,
    int? nroRenovacion,
    estado,
    vigenciaFinal,
  ) async {
    TextEditingController valorAsegurado0 = TextEditingController();
    var valorAseguradoString = valorAsegurado.toString().split('.');
    valorAsegurado0.text = valorAseguradoString[0];

    String titulo = "";

    if (estado == "vencida_1_dia") {
      titulo =
          "La última póliza que adquiriste para este auto venció y esta  dentro las 24 horas, así que te ahorras varios pasos y obtendras un descuento";
    } else if (estado == "vencida_30_dias") {
      titulo =
          "La última póliza que adquiriste venció hace menos de 30 días. Pero puedes renovarla y obtener un descuento.";
    } else {
      titulo =
          "La última póliza que adquiriste para este auto venció hace mas de 30 días. ";
    }

    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          context: context,
          iconColor: Theme.of(context).primaryColor,
          icon: const Text(
            'i',
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
          content: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Valor a asegurar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: valorAsegurado0,
                textAlign: TextAlign.center,
                readOnly: (vigenciaFinal.year - DateTime.now().year) < 1,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text(
                                'Solamente es posible modificar el valor asegurado, si ya pasó un año de la fecha de fin de vigencia'),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.info, color: Color(0xff1D2766)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff1D2766), width: 3.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  hintText: '0 USD',
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Debe actualizar el valor del vehículo en USD',
                style: TextStyle(
                  color: Color(0xff1D2766),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          extraActions: [
            const Spacer(),
            GestureDetector(
              onTap: () async {
                try {
                  final response = await carController.updateValorAsegurado(
                    carId: idAuto,
                    issueValue: int.parse(valorAsegurado0.text),
                    city: ciudadAuto,
                    classId: 1,
                    model: modeloAuto,
                    userId: clientNotifier.value!.usuarioId,
                    use: usoAuto,
                    year: anoAuto,
                  );

                  if (response != null) {
                    personalDataController.setClientData(clientNotifier.value!);
                    carController.setCarDataByPoliza(
                        poliza, clientNotifier.value!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlansScreen(
                          carController: carController,
                          personalDataController: personalDataController,
                        ),
                      ),
                    );
                    return;
                  }

                  Fluttertoast.showToast(
                    msg: 'Hubo un problema al actualizar el valor asegurado',
                  );
                } catch (exception) {
                  Fluttertoast.showToast(
                    msg: 'Hubo un problema al actualizar el valor asegurado',
                  );
                }
              },
              child: const Text(
                'Actualizar\nvalor asegurado',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            )
          ],
          hideActions: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Buscar cliente (Renovación)',
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            _searchHeader(context),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _isLoadingNotifier,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }

                  return ValueListenableBuilder<List<Poliza>?>(
                    valueListenable: polizasNotifier,
                    builder: (context, polizas, child) {
                      if (polizas == null) {
                        return const SizedBox();
                      }

                      if (polizas.isEmpty) {
                        return const Center(
                          child: Text(
                            'El usuario buscado no tiene polizas vencidas',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Column(
                          children: polizas.map((poliza) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.secondary,
                            ),
                          ),
                          child: Column(
                            children: [
                              _infoTile(
                                title: 'ID Poliza:',
                                value: poliza.idPoliza.toString(),
                              ),
                              _infoTile(
                                title: 'Aseguradora:',
                                value: poliza.aseguradora,
                              ),
                              _infoTile(
                                title: 'Modelo:',
                                value: poliza.modelo,
                              ),
                              _infoTile(
                                title: 'Marca:',
                                value: poliza.placa,
                              ),
                              _infoTile(
                                title: 'Placa:',
                                value: poliza.placa,
                              ),
                              _infoTile(
                                title: 'Uso:',
                                value: poliza.uso,
                              ),
                              _infoTile(
                                title: 'Vigencia Inicio:',
                                value: poliza.vigenciaInicio.slashedDate,
                              ),
                              _infoTile(
                                title: 'Vigencia Fin:',
                                value: poliza.vigenciaFinal.slashedDate,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _actualizarValor(
                                    poliza,
                                    poliza.idAutomovil,
                                    clientNotifier.value!.usuarioId,
                                    poliza.valorAsegurado,
                                    poliza.idMarca,
                                    poliza.idModelo,
                                    poliza.idYear,
                                    poliza.idUso,
                                    poliza.idCiudad,
                                    poliza.idInspeccion,
                                    poliza.nroRenovacion,
                                    poliza.estado,
                                    poliza.vigenciaFinal,
                                  );
                                  // Navigator.push(
                                  // context,
                                  // MaterialPageRoute(
                                  // builder: (context) {
                                  // return PersonalDataFoundClientScreen(
                                  // client: searchedClient,
                                  // );
                                  // },
                                  // ),
                                  // );
                                },
                                child: const Text('Continuar'),
                              )
                            ],
                          ),
                        );
                      }).toList());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ciController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              hintText:
                  'Buscar pólizas vencidas por número de documento de identidad',
              hintMaxLines: 2,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              if (_ciController.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: 'Debe ingresar un número de documento de identidad');
                return;
              }

              _isLoadingNotifier.value = true;

              final clientResponse = await _bigBroService.searchClient(
                dni: _ciController.text,
              );
              clientNotifier.value = clientResponse.data;

              final polizasResponse = await _bigBroService.getPolizaByStatus(
                status: 'VENCIDO',
                dni: _ciController.text,
              );
              polizasNotifier.value = polizasResponse;

              _isLoadingNotifier.value = false;
            } catch (error) {
              _isLoadingNotifier.value = false;
              clientNotifier.value = null;
              polizasNotifier.value = null;

              Fluttertoast.showToast(
                  msg: 'Cliente no encontrado', toastLength: Toast.LENGTH_LONG);
              return;
            }
          },
          child: const Icon(
            Icons.search,
          ),
        )
      ],
    );
  }

  Widget _infoTile({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xff1D2766),
              fontSize: 14.0,
              height: 1,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
