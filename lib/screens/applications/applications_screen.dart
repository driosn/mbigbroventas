import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/controllers/polizas_controller.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/models/poliza.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/dialogs/show_qr_dialog.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/utils/extensions.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

enum TipoEstado {
  caducadas,
  pagadas,
  emitidas,
}

class EstadoSolicitud {
  const EstadoSolicitud({
    required this.estado,
    required this.value,
    required this.color,
  });

  final String estado;
  final String value;
  final Color color;
}

class PolizaConEstado {
  const PolizaConEstado({
    required this.poliza,
    required this.estado,
  });

  final Poliza poliza;
  final TipoEstado estado;
}

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  static const TextStyle labelText = TextStyle(
      color: Colors.red, fontFamily: 'Manrope', fontWeight: FontWeight.w500);
  static const TextStyle infoText = TextStyle(
      color: Color(0xff1D2766),
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400);
  static const TextStyle infoStyle = TextStyle(
      color: Color(0xff1D2766),
      fontSize: 14.0,
      height: 1,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w300);

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  final estados = [
    const EstadoSolicitud(
      estado: 'Todos',
      value: '0',
      color: Color(0xff9ED1FF),
    ),
    const EstadoSolicitud(
      estado: 'Pendientes de pago',
      value: '1',
      color: Color(0xff1CF509),
    ),
    const EstadoSolicitud(
      estado: 'Vencidas',
      value: '2',
      color: Colors.grey,
    ),
    const EstadoSolicitud(
      estado: 'Pagadas',
      value: '3',
      color: AppColors.primary,
    ),
  ];

  final ValueNotifier<EstadoSolicitud?> estadoSeleccionadoNotifier =
      ValueNotifier<EstadoSolicitud?>(null);
  final ValueNotifier<List<PolizaConEstado>> polizasAMostrarNotifier =
      ValueNotifier<List<PolizaConEstado>>([]);

  final polizasController = PolizasController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final response = await polizasController.getPolizas();
      if (response) {
        polizasAMostrarNotifier.value = polizasController.todasLasPolizas;
      }
    });

    polizasAMostrarNotifier.addListener(() {
      final polizas = polizasAMostrarNotifier.value;
      polizas.sort(
          (a, b) => b.poliza.vigenciaInicio.compareTo(a.poliza.vigenciaInicio));

      polizasAMostrarNotifier.value = polizas;
    });
    super.initState();
  }

  @override
  void dispose() {
    polizasAMostrarNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Solicitudes',
      subtitle: 'Seguimientos de mis solicitudes',
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        child: ListenableBuilder(
          listenable: polizasController,
          builder: (context, child) {
            if (polizasController.getPolizasStatus == BigBroStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (polizasController.getPolizasStatus == BigBroStatus.initial) {
              return const SizedBox();
            }

            if (polizasController.getPolizasStatus == BigBroStatus.failure) {
              return const Center(
                child: Text(
                  'Hubo un problema al obtener las pólizas, inténtelo nuevamente o contacte a su administrador',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 3,
                        offset: const Offset(3, 3),
                      )
                    ],
                  ),
                  child: ValueListenableBuilder<EstadoSolicitud?>(
                    valueListenable: estadoSeleccionadoNotifier,
                    builder: (BuildContext context,
                        EstadoSolicitud? estadoSeleccionado, Widget? child) {
                      return DropdownButton<EstadoSolicitud>(
                        borderRadius: BorderRadius.circular(16),
                        isExpanded: true,
                        underline: Container(),
                        icon: Transform.rotate(
                          angle: pi * 1.5,
                          child: const Icon(Icons.chevron_left),
                        ),
                        onChanged: (value) {
                          estadoSeleccionadoNotifier.value = value;

                          if (value!.value == '0') {
                            polizasAMostrarNotifier.value =
                                polizasController.todasLasPolizas;
                            return;
                          }

                          if (value.value == '1') {
                            polizasAMostrarNotifier.value = polizasController
                                .todasLasPolizas
                                .where(((pol) =>
                                    pol.estado == TipoEstado.emitidas))
                                .toList();

                            return;
                          }

                          if (value.value == '2') {
                            polizasAMostrarNotifier.value = polizasController
                                .todasLasPolizas
                                .where(((pol) =>
                                    pol.estado == TipoEstado.caducadas))
                                .toList();
                            return;
                          }

                          if (value.value == '3') {
                            polizasAMostrarNotifier.value = polizasController
                                .todasLasPolizas
                                .where(
                                    ((pol) => pol.estado == TipoEstado.pagadas))
                                .toList();
                            return;
                          }
                        },
                        value: estadoSeleccionado ?? estados.first,
                        items: estados
                            .map<DropdownMenuItem<EstadoSolicitud>>((item) {
                          return DropdownMenuItem<EstadoSolicitud>(
                            value: item,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: item.color,
                                  radius: 8,
                                ),
                                const SizedBox(
                                  width: 44,
                                ),
                                Text(
                                  item.estado,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Expanded(
                  child: ValueListenableBuilder<List<PolizaConEstado>>(
                    valueListenable: polizasAMostrarNotifier,
                    builder: (context, polizas, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          final poliza = polizas[index];

                          return _SolicitudCard(
                            tipoEstado: poliza.estado,
                            poliza: poliza.poliza,
                            showTopLine: index == 0 ? false : true,
                            showBottomLine:
                                index == polizas.length - 1 ? false : true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 24,
                                          right: 24,
                                          top: 24,
                                        ),
                                        padding: const EdgeInsets.all(36),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(3, 3),
                                              blurRadius: 2,
                                              spreadRadius: 3,
                                            )
                                          ],
                                          border: Border.all(
                                            color: const Color(0xffEC1C24),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 115,
                                                  width: 115,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        16,
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          poliza.poliza
                                                              .fotoFrontal,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Marca:",
                                                          style:
                                                              ApplicationsScreen
                                                                  .labelText,
                                                        ),
                                                        Text(
                                                          poliza.poliza.marca,
                                                          style:
                                                              ApplicationsScreen
                                                                  .infoText,
                                                        ),
                                                        const Text(
                                                          "Placa:",
                                                          style:
                                                              ApplicationsScreen
                                                                  .labelText,
                                                        ),
                                                        Text(
                                                          poliza.poliza.placa,
                                                          style:
                                                              ApplicationsScreen
                                                                  .infoText,
                                                        ),
                                                        const Text(
                                                          "Circulación:",
                                                          style:
                                                              ApplicationsScreen
                                                                  .labelText,
                                                        ),
                                                        Text(
                                                          poliza.poliza.ciudad,
                                                          style:
                                                              ApplicationsScreen
                                                                  .infoText,
                                                        ),
                                                        const SizedBox(
                                                            height: 12),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Divider(
                                              color: Color(0xffEC1C24),
                                              height: 0.0,
                                              thickness: 1.5,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Asegurador:",
                                                    textAlign: TextAlign.right,
                                                    style: ApplicationsScreen
                                                        .labelText,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    poliza.poliza.aseguradora,
                                                    style: ApplicationsScreen
                                                        .infoText,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Inicio:",
                                                    textAlign: TextAlign.right,
                                                    style: ApplicationsScreen
                                                        .labelText,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    poliza.poliza.vigenciaInicio
                                                        .slashedDate,
                                                    style: ApplicationsScreen
                                                        .infoText,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Fin:",
                                                    textAlign: TextAlign.right,
                                                    style: ApplicationsScreen
                                                        .labelText,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    poliza.poliza.vigenciaFinal
                                                        .slashedDate,
                                                    style: ApplicationsScreen
                                                        .infoText,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    "Prima:",
                                                    textAlign: TextAlign.right,
                                                    style: ApplicationsScreen
                                                        .labelText,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    "${poliza.poliza.prima} USD",
                                                    style: ApplicationsScreen
                                                        .infoText,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        itemCount: polizas.length,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SolicitudCard extends StatefulWidget {
  _SolicitudCard({
    required this.showTopLine,
    required this.showBottomLine,
    required this.poliza,
    required this.tipoEstado,
    required this.onTap,
  }) {
    if (tipoEstado == TipoEstado.emitidas) {
      alturaCard = 210;
    } else if (tipoEstado == TipoEstado.pagadas) {
      alturaCard = 210;
    } else if (tipoEstado == TipoEstado.caducadas) {
      alturaCard = 120;
    }
  }

  final bool showTopLine;
  final bool showBottomLine;
  final Poliza poliza;
  final TipoEstado tipoEstado;
  final VoidCallback onTap;

  late double alturaCard;

  @override
  State<_SolicitudCard> createState() => _SolicitudCardState();
}

class _SolicitudCardState extends State<_SolicitudCard> {
  final meses = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  late String dia;
  late int mes;

  @override
  void initState() {
    super.initState();
    final fecha = widget.poliza.vigenciaInicio;

    dia = fecha.day < 10 ? '0${fecha.day}' : fecha.day.toString();
    mes = fecha.month - 1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.alturaCard,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: 1,
                  color: widget.showTopLine
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 13.5,
                  ),
                  child: Column(
                    children: [
                      Text(
                        dia,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xff464646),
                        ),
                      ),
                      Text(
                        meses[mes],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: Container(
                  width: 1,
                  color: widget.showBottomLine
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 28,
          ),
          Expanded(
            child: Container(
              height: widget.alturaCard - 30,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tipoEstado == TipoEstado.emitidas
                        ? 'Pendiente de pago'
                        : widget.tipoEstado == TipoEstado.caducadas
                            ? 'Vencido'
                            : 'Pagado',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Placa: ${widget.poliza.placa}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: CircleAvatar(
                          backgroundColor:
                              widget.tipoEstado == TipoEstado.emitidas
                                  ? const Color(0xff1CF509)
                                  : widget.tipoEstado == TipoEstado.caducadas
                                      ? Colors.grey
                                      : AppColors.primary,
                          radius: 8,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.tipoEstado == TipoEstado.emitidas
                              ? const Text(
                                  'La solicitud ha sido aprobada',
                                )
                              : const SizedBox(),
                          GestureDetector(
                            onTap: () {
                              widget.onTap();
                            },
                            child: const Text(
                              'Ver Estado',
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          if (widget.tipoEstado == TipoEstado.emitidas)
                            GestureDetector(
                              onTap: () {
                                showQRDialog(
                                  context,
                                  insuranceId: widget.poliza.idPoliza,
                                  amount: widget.poliza.valorAsegurado.toInt(),
                                  onFinish: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Text(
                                'Pagar',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        final bigBroService = BigBroService();

                        final urlCertificado = await bigBroService
                            .descargarCertificado(widget.poliza.idPoliza);

                        _launchCertURL(urlCertificado);
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: 'Hubo un problema descargando el certificado',
                        );
                      }
                    },
                    child: const Text(
                      'Ver Certificado',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    try {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } catch (error) {
      throw 'Could not launch $url';
    }
  }

  _launchCertURL(String urlCertificado) async {
    try {
      await _launchInBrowser(urlCertificado);
    } catch (error) {
      throw 'Could not launch $urlCertificado';
    }
  }
}
