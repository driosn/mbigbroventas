import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/search_client_response.dart';
import 'package:mibigbro_ventas_mobile/screens/car_data/car_data_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/extensions.dart';
import 'package:mibigbro_ventas_mobile/utils/formatters/formatters.dart';
import 'package:mibigbro_ventas_mobile/widgets/custom_date_picker.dart';
import 'package:mibigbro_ventas_mobile/widgets/selector_profesion.dart';

// Create a Form widget.
class PersonalDataFoundClientScreen extends StatefulWidget {
  const PersonalDataFoundClientScreen({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  State<PersonalDataFoundClientScreen> createState() {
    return _PersonalDataFoundClientScreen();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class _PersonalDataFoundClientScreen
    extends State<PersonalDataFoundClientScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  //
  // Own Controller
  //
  final personalDataController = PersonalDataController();
  late Client client;

  @override
  void initState() {
    super.initState();

    client = widget.client;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final response = await personalDataController.getExtraData();

        if (response) {
          _fillInitialClientData();
        }
      },
    );
  }

  void _fillInitialClientData() {
    _nombre.text = client.nombre;
    _apellidoPaterno.text = client.apellidoPaterno;
    _apellidoMaterno.text = client.apellidoMaterno;
    _celular.text = client.nroCelular;
    _nacimientoController.text = client.fechaNacimiento.slashedDate;
    _fechaNacimiento = client.fechaNacimiento;
    _genero = client.genero;
    _estadoCivil = client.estadoCivil;
    _tipoDocumento = client.tipoDocumento;
    _nroDocumento.text = client.numeroDocumento;
    _extDocumento = client.extension;
    _email.text = client.usuario.email;
    _pais = client.paisResidenciaId;
    _nacionalidad.text = client.nacionalidad;
    _ciudad = client.ciudadId;
    _direccion.text = client.direccionDomicilio;
    _ocupacion = client.profesionId;
    _actividad.text = client.actividad;
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  // DateFormat? dateFormat;
  // final String _BASEURL = llavero.Key.BASEURL;
  final _formKey = GlobalKey<FormState>();
  File? _imageUser;
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellidoPaterno = TextEditingController();
  final TextEditingController _apellidoMaterno = TextEditingController();
  final TextEditingController _nacionalidad = TextEditingController();
  DateTime? _fechaNacimiento;
  final TextEditingController _celular = TextEditingController();
  final TextEditingController _actividad = TextEditingController();
  final TextEditingController _nacimientoController = TextEditingController();

  String? _tipoDocumento = "CI";
  int _ciudad = 0;
  int _pais = 0;
  String? _genero = "NN";
  String _estadoCivil = "NN";
  String? fotoUsuario;
  String _extDocumento = "NN";
  int _ocupacion = 0;

  final TextEditingController _nroDocumento = TextEditingController();
  //final TextEditingController _extDocumento = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _direccion = TextEditingController();
  //Id para actualizar datos personales
  int? idDatosPersonales = 0;
  //
  bool nuevoDatosPersonales = true;

  final titleStyle = const TextStyle(fontSize: 15, color: Color(0xff1A2461));

  final dropdownItemTextStyle =
      const TextStyle(fontSize: 15, color: Colors.black);

  List<DropdownMenuItem<String>> get generoItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "NN",
        child: Center(
          child: Text(
            "Género",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
            ),
          ),
        ),
      ),
      DropdownMenuItem(
        value: "M",
        child: Center(
            child: Text(
          "MASCULINO",
          style: dropdownItemTextStyle,
        )),
      ),
      DropdownMenuItem(
        value: "F",
        child: Center(
            child: Text(
          "FEMENINO",
          style: dropdownItemTextStyle,
        )),
      )
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get generoItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "NN",
        child: Text(
          "Género",
        ),
      ),
      const DropdownMenuItem(
        value: "M",
        child: Text(
          "MASCULINO",
        ),
      ),
      const DropdownMenuItem(
        value: "F",
        child: Text(
          "FEMENINO",
        ),
      )
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get estadocivilItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "NN",
          child: Center(
              child: Text(
            "Elija un estado civil",
            style: titleStyle,
          ))),
      DropdownMenuItem(
          value: "1",
          child: Center(
              child: Text(
            "SOLTERO",
            style: dropdownItemTextStyle,
          ))),
      DropdownMenuItem(
          value: "2",
          child: Center(
              child: Text(
            "CASADO",
            style: dropdownItemTextStyle,
          ))),
      DropdownMenuItem(
          value: "3",
          child: Center(
              child: Text(
            "VIUDO",
            style: dropdownItemTextStyle,
          ))),
      DropdownMenuItem(
          value: "4",
          child: Center(
              child: Text(
            "DIVORCIADO",
            style: dropdownItemTextStyle,
          ))),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get estadocivilItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "NN", child: Text("Estado civil")),
      const DropdownMenuItem(value: "1", child: Text("SOLTERO")),
      const DropdownMenuItem(value: "2", child: Text("CASADO")),
      const DropdownMenuItem(value: "3", child: Text("VIUDO")),
      const DropdownMenuItem(value: "4", child: Text("DIVORCIADO")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            top: kToolbarHeight,
                            left: 16,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Text(
                                  'Datos Personales',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34,
                  ),
                  child: ListenableBuilder(
                      listenable: personalDataController,
                      builder: (context, child) {
                        if (personalDataController.getExtraDataStatus ==
                            BigBroStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (personalDataController.getExtraDataStatus ==
                            BigBroStatus.failure) {
                          return const Center(
                            child: Text(
                              'Hubo un problema al cargar los datos de formulario',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              enabled: false,
                              controller: _nombre,
                              decoration: const InputDecoration(
                                  labelText: 'Nombre',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  _scrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.linear);
                                  return 'Ingrese sus nombres';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            TextFormField(
                              enabled: false,
                              controller: _apellidoPaterno,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido paterno',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  _scrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.linear);
                                  return 'Ingrese su apellido paterno';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            TextFormField(
                              enabled: false,
                              controller: _apellidoMaterno,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido materno',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  _scrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.linear);
                                  return 'Ingrese su apellido materno';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(''),
                              ],
                              readOnly: true,
                              enabled: false,
                              controller: _nacimientoController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                ),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Fecha de nacimiento',
                              ),
                              onTap: () async {
                                final fechaNacimiento =
                                    await CustomDatePicker.show(
                                  context: context,
                                  firstDate: DateTime(1940, 0, 0),
                                  initialDate: _fechaNacimiento ??
                                      DateTime(
                                          DateTime.now().year - 18,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                  lastDate: DateTime(DateTime.now().year - 18,
                                      DateTime.now().month, DateTime.now().day),
                                );

                                if (fechaNacimiento != null) {
                                  _fechaNacimiento = fechaNacimiento;
                                  _nacimientoController.text =
                                      '${_fechaNacimiento?.day}/${_fechaNacimiento?.month}/${_fechaNacimiento?.year}';
                                }
                              },
                              validator: (String? value) {
                                final date = _fechaNacimiento;
                                int yearDiff = 0;
                                if (date != null) {
                                  DateTime today = DateTime.now();
                                  yearDiff = today.year - date.year;
                                }

                                if (date == null) {
                                  return 'Ingrese la fecha de nacimiento';
                                }

                                if (yearDiff < 18) {
                                  return 'Debe tener más de 18 años';
                                }

                                if (yearDiff > 75) {
                                  return 'Debe tener un maximo de 75 años';
                                }

                                return null;
                              },
                            ),
                            TextFormField(
                              enabled: false,
                              controller: _email,
                              decoration: const InputDecoration(
                                  labelText: 'Correo electrónico',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese su correo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'Género',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            DropdownButtonFormField(
                              hint: const Text('Género'),
                              items: generoItems,
                              value: _genero,
                              borderRadius: BorderRadius.circular(16),
                              icon: Transform.rotate(
                                angle: pi * 1.5,
                                child: const Icon(Icons.chevron_left),
                              ),
                              validator: (dynamic value) =>
                                  value == "NN" ? "NN" : null,
                              onChanged: null,
                              selectedItemBuilder: (BuildContext context) {
                                return generoItems2;
                              },
                              isExpanded: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Tipo de documento',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            DropdownButtonFormField(
                              hint: const Text('Tipo de documento'),
                              items: ["CI", "PASAPORTE", "LICENCIA", "OTRO"]
                                  .map((label) => DropdownMenuItem(
                                        value: label,
                                        child: Center(
                                          child: Text(
                                            label == 'CI'
                                                ? 'CÉDULA DE IDENTIDAD'
                                                : label.toString(),
                                            style: dropdownItemTextStyle,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: _tipoDocumento,
                              validator: (dynamic value) =>
                                  value == null ? 'CI' : null,
                              onChanged: null,
                              selectedItemBuilder: (context) =>
                                  ["CI", "PASAPORTE", "LICENCIA", "OTRO"]
                                      .map((label) => DropdownMenuItem(
                                            value: label,
                                            child: Text(
                                              label == 'CI'
                                                  ? 'CÉDULA DE IDENTIDAD'
                                                  : label.toString(),
                                            ),
                                          ))
                                      .toList(),
                              isExpanded: true,
                            ),
                            TextFormField(
                              enabled: false,
                              controller: _nroDocumento,
                              decoration: const InputDecoration(
                                  labelText: 'Número de documento:',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese el número de documento';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                labelText: 'Extensión',
                              ),
                              hint: const Text('Extensión'),
                              items: personalDataController.tipoDocumentos
                                  .map((tp) {
                                return DropdownMenuItem(
                                  value: tp.abreviacion,
                                  child: Text(
                                    tp.abreviacion == 'PO'
                                        ? 'POTOSÍ'
                                        : tp.descripcion,
                                    style: tp.id == 0
                                        ? titleStyle
                                        : dropdownItemTextStyle,
                                  ),
                                );
                              }).toList(),
                              borderRadius: BorderRadius.circular(16),
                              selectedItemBuilder: (context) =>
                                  personalDataController.tipoDocumentos
                                      .map((tp) {
                                return DropdownMenuItem(
                                  value: tp.id,
                                  child: Text(
                                    tp.abreviacion == 'PO'
                                        ? 'POTOSÍ'
                                        : tp.descripcion,
                                  ),
                                );
                              }).toList(),
                              value: _extDocumento,
                              validator: (dynamic value) =>
                                  value == 'NN' ? 'Elija una extensión' : null,
                              onChanged: null,
                              isExpanded: true,
                            ),
                            DropdownButtonFormField<int>(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                labelText: 'Pais de residencia',
                              ),
                              hint: const Text('Pais de residencia'),
                              items: personalDataController.paises
                                  .map((pais) => DropdownMenuItem(
                                        value: pais.id,
                                        child: Text(pais.nombrePais),
                                      ))
                                  .toList(),
                              value: _pais,
                              validator: (dynamic value) =>
                                  value == 0 ? 'Elija un país' : null,
                              onChanged: null,
                              isExpanded: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              enabled: false,
                              controller: _nacionalidad,
                              decoration: const InputDecoration(
                                  labelText: 'Nacionalidad',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese su nacionalidad';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                labelText: 'Ciudad de residencia',
                              ),
                              hint: const Text('Ciudad de residencia'),
                              items:
                                  personalDataController.ciudades.map((ciudad) {
                                return DropdownMenuItem(
                                  value: ciudad.id,
                                  child: Text(
                                    ciudad.nombreCiudad.toUpperCase(),
                                    style: ciudad.id == 0
                                        ? titleStyle
                                        : dropdownItemTextStyle,
                                  ),
                                );
                              }).toList(),
                              borderRadius: BorderRadius.circular(16),
                              selectedItemBuilder: (context) =>
                                  personalDataController.ciudades.map((ciudad) {
                                return DropdownMenuItem(
                                  value: ciudad.id,
                                  child: Text(
                                    ciudad.nombreCiudad,
                                  ),
                                );
                              }).toList(),
                              value: _ciudad,
                              validator: (dynamic value) =>
                                  value == 0 ? 'Elija una ciudad' : null,
                              onChanged: null,
                              isExpanded: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Estado civil',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            DropdownButtonFormField(
                              hint: const Text('Estado civil'),
                              items: estadocivilItems,
                              value: _estadoCivil,
                              borderRadius: BorderRadius.circular(16),
                              validator: (dynamic value) =>
                                  value == "NN" ? 'NN' : null,
                              onChanged: null,
                              selectedItemBuilder: (context) =>
                                  estadocivilItems2,
                              isExpanded: true,
                            ),
                            TextFormField(
                              controller: _celular,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                  labelText: 'Número de celular',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  _scrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.linear);
                                  return 'Ingrese número de celular';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _direccion,
                              decoration: const InputDecoration(
                                labelText: 'Dirección',
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese su dirección';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Profesión',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            SelectorProfesion(
                              ocupacionInicial: _ocupacion,
                              profesiones: personalDataController.profesiones,
                              onChanged: (profesion) {
                                _ocupacion = profesion.idAlianza;
                              },
                            ),
                            TextFormField(
                              controller: _actividad,
                              decoration: const InputDecoration(
                                  labelText: 'Actividad comercial:',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2766),
                                    ),
                                  )),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese su actividad';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final clientResponse =
                                          await personalDataController
                                              .createClient(
                                        name: _nombre.text,
                                        lastName: _apellidoPaterno.text,
                                        motherLastName: _apellidoMaterno.text,
                                        cellPhone: _celular.text,
                                        birthdate:
                                            (_fechaNacimiento ?? DateTime.now())
                                                .dashedDate,
                                        gender: _genero!,
                                        civilStatus: _estadoCivil,
                                        documentType: _tipoDocumento!,
                                        dni: _nroDocumento.text,
                                        extension: _extDocumento,
                                        email: _email.text,
                                        country: _pais.toString(),
                                        nationality: _nacionalidad.text,
                                        city: _ciudad.toString(),
                                        address: _direccion.text,
                                        profession: _ocupacion.toString(),
                                        comercialActivity: _actividad.text,
                                      );

                                      if (clientResponse != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => CarDataScreen(
                                              personalDataController:
                                                  personalDataController,
                                            ),
                                          ),
                                        );
                                      } else {
                                        // TODO: Manejar errores
                                      }
                                    }

                                    // personalDataController
                                    // .setClientData(client);
                                    // Navigator.push(
                                    // context,
                                    // MaterialPageRoute(
                                    // builder: (_) => CarDataScreen(
                                    // personalDataController:
                                    // personalDataController,
                                    // ),
                                    // ),
                                    // );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
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
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ciudad {
  const Ciudad({
    required this.nombreCiudad,
    required this.id,
  });

  final String nombreCiudad;
  final int id;
}
