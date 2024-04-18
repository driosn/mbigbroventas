import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/modelo_auto.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_info_dialog.dart';
import 'package:mibigbro_ventas_mobile/screens/plans/plans_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_marca.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_modelo.dart';

// Create a Form widget.
class CarDataScreen extends StatefulWidget {
  const CarDataScreen({super.key});

  @override
  CarDataScreenState createState() {
    return CarDataScreenState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class CarDataScreenState extends State<CarDataScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKeyDatosMotorizado = GlobalKey<FormState>();
  final TextEditingController _valor = TextEditingController();
  final int _selectedMarca = 0;
  final ValueNotifier<ModeloAuto?> _selectedModeloNotifier =
      ValueNotifier<ModeloAuto?>(null);
  final TextEditingController _otroModelo = TextEditingController();
  int? _selectedAno = 0;
  int? _selectedPlaza = 0;
  int? _selectedUso = 0;
  bool otroModeloVisible = false;

  final titleStyle = const TextStyle(fontSize: 15, color: Color(0xff1A2461));

  final dropdownItemTextStyle =
      const TextStyle(fontSize: 15, color: Colors.black);

  var modeloList = <ModeloAuto>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Valor a asegurar'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'El monto por el que se debe asegurar es el valor comercial de mercado, el cual es el valor que tiene el vehículo al momento de contratar el seguro, este valor es el que te indemnizara la compañía de seguros ante una pérdida total por accidente o pérdida total por robo.',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return BigBroScaffold(
      title: 'Datos del Motorizado',
      subtitle: 'Ingrese los datos de tu motorizado',
      body: Form(
        key: _formKeyDatosMotorizado,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 4),
                    FutureBuilder(
                      future: Future.delayed(Duration.zero),
                      builder: (context, snapshotMarcas) {
                        if (snapshotMarcas.hasData) {
                          final marcas = snapshotMarcas.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Marca',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SelectorMarca(
                                ocupacionInicial: _selectedMarca,
                                marcas: const [],
                                onChanged: (marca) async {},
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ValueListenableBuilder<ModeloAuto?>(
                      valueListenable: _selectedModeloNotifier,
                      builder: (BuildContext context, ModeloAuto? modeloAuto,
                          Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Modelo',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            SelectorModelo(
                              modeloSeleccionado: modeloAuto,
                              modelos: modeloList,
                              onChanged: (marca) async {
                                setState(() {
                                  _selectedModeloNotifier.value = marca;
                                  if (marca.nombre == "Otro") {
                                    otroModeloVisible = true;
                                  } else {
                                    otroModeloVisible = false;
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    Visibility(
                      visible: otroModeloVisible,
                      child: TextFormField(
                          controller: _otroModelo,
                          decoration: const InputDecoration(
                              labelText: 'Otro modelo',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff1D2766),
                                ),
                              )),
                          validator: (String? value) {
                            if (value!.isEmpty & otroModeloVisible) {
                              return 'Ingrese el modelo';
                            }
                            return null;
                          }),
                    ),
                    FutureBuilder<List<Anio>>(
                        future: Future.value([]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                'Año del automóvil',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: const Text('Año del automóvil'),
                                borderRadius: BorderRadius.circular(16),
                                items: [].map((year) {
                                  return DropdownMenuItem(
                                    value: year.id,
                                    child: Center(
                                      child: Text(
                                        year.anio,
                                        style: year.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((year) {
                                    return DropdownMenuItem(
                                      value: year.id,
                                      child: Text(
                                        year.anio,
                                      ),
                                    );
                                  }).toList();
                                },
                                value: _selectedAno,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija un año' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedAno = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    FutureBuilder<List<TipoUso>>(
                        future: Future.value([]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                'Tipo de uso',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(16),
                                hint: const Text('Uso del automovil'),
                                items: [].map((tipoUso) {
                                  return DropdownMenuItem(
                                    value: tipoUso.id,
                                    child: Center(
                                      child: Text(
                                        tipoUso.nombreUso,
                                        style: tipoUso.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((tipoUso) {
                                    return DropdownMenuItem(
                                      value: tipoUso.id,
                                      child: Text(
                                        tipoUso.nombreUso,
                                      ),
                                    );
                                  }).toList();
                                },
                                value: _selectedUso,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija un uso' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedUso = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    FutureBuilder<List<Ciudad>>(
                        future: Future.value([]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                'Ciudad',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(16),
                                hint: const Text('Plaza de circulación'),
                                items: snapshot.data!.map((ciudad) {
                                  return DropdownMenuItem(
                                    value: ciudad.id,
                                    child: Center(
                                      child: Text(
                                        ciudad.nombreCiudad,
                                        style: ciudad.id == 0
                                            ? titleStyle
                                            : dropdownItemTextStyle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return snapshot.data!.map((ciudad) {
                                    return DropdownMenuItem(
                                      value: ciudad.id,
                                      child: Text(
                                        ciudad.nombreCiudad,
                                      ),
                                    );
                                  }).toList();
                                },
                                value: _selectedPlaza,
                                validator: (dynamic value) =>
                                    value == 0 ? 'Elija una ciudad' : null,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _selectedPlaza = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Valor asegurado (Dólares)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    TextFormField(
                      controller: _valor,
                      maxLength: 9,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          labelText: 'Valor asegurado (Dólares)',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1D2766),
                            ),
                          )),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el valor asegurado (Dólares)';
                        } else if (double.parse(value) < 5000) {
                          return 'El valor debe ser mayor a 5.000 USD';
                        } else if (double.parse(value) > 30000) {
                          return 'El valor debe ser menor a 30.000 USD';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text(
                                "Incluye el valor por el que asegurarás tu auto, el cual no puede ser menor a 5.000 USD ni mayor a 30.000 USD",
                                style: TextStyle(
                                    color: Color(0xff1D2766), fontSize: 10))),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                width: 30,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    CustomInfoDialog(
                                      context: context,
                                      iconColor: const Color(0xffEC1C24),
                                      title: 'Valor a asegurar',
                                      subtitle:
                                          'El monto por el que se debe asegurar es el valor comercial de mercado, el cual es el valor que tiene el vehículo al momento de contratar el seguro, este valor es el que te indemniza la compañia de seguros ante perdida total por accidente o perdida total por robo',
                                    );
                                  },
                                  elevation: 10.0,
                                  fillColor: Colors.red,
                                  padding: const EdgeInsets.all(2.0),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.info_outline,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                )))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PlansScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 24,
                            ),
                            child: Text(
                              "Siguiente",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Anio {
  const Anio({
    required this.anio,
    required this.id,
  });

  final String anio;
  final int id;
}

class TipoUso {
  const TipoUso({
    required this.nombreUso,
    required this.id,
  });

  final String nombreUso;
  final int id;
}

class Ciudad {
  const Ciudad({
    required this.nombreCiudad,
    required this.id,
  });

  final String nombreCiudad;
  final int id;
}
