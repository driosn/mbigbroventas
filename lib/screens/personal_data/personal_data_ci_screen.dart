import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mibigbro_ventas_mobile/controllers/personal_data_controller.dart';
import 'package:mibigbro_ventas_mobile/screens/car_data/car_data_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';

class PersonalDataCIScreen extends StatefulWidget {
  const PersonalDataCIScreen({
    super.key,
    required this.personalDataController,
  });

  final PersonalDataController personalDataController;

  @override
  State<PersonalDataCIScreen> createState() {
    return _PersonalDataCIScreen();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class _PersonalDataCIScreen extends State<PersonalDataCIScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  File? _imageCiFrontal;
  File? _imageCiTrasera;
  String? ciFrontaCargado;
  String? ciTraseraCargado;
  int? idDatosPersonales = 0;
  String textoCiFrontal = "Foto frontal de su carnet de identidad";
  String textoCiTrasera = "Foto posterior de su carnet de identidad";

  final _pageController = PageController();
  double currentPage = 0.0;

  late ValueNotifier<bool> _loadingNotifier;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
    _loadingNotifier = ValueNotifier<bool>(false);
  }

  Future getImage(String tipoFoto) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (tipoFoto == "ciFrontal") {
      setState(() {
        if (pickedFile != null) {
          _imageCiFrontal = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      setState(() {
        if (pickedFile != null) {
          _imageCiTrasera = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ValueListenableBuilder(
      valueListenable: _loadingNotifier,
      builder: (context, loading, child) {
        return Stack(
          children: [
            Scaffold(
              body: Column(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Datos Personales',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Actualizar el perfil',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 440,
                                  child: PageView(
                                    controller: _pageController,
                                    children: [
                                      _FotoFrontal(
                                        imageCiFrontal: _imageCiFrontal,
                                        ciFrontalCargado: ciFrontaCargado,
                                        onTap: () {
                                          getImage('ciFrontal');
                                        },
                                      ),
                                      _FotoTrasera(
                                        imageCiTrasera: _imageCiTrasera,
                                        ciTraseraCargado: ciTraseraCargado,
                                        onTap: () {
                                          getImage('ciTrasera');
                                        },
                                      ),
                                      _PreviewFotos(
                                        imageCiFrontal: _imageCiFrontal,
                                        ciFrontalCargado: ciFrontaCargado,
                                        ciTraseraCargado: ciTraseraCargado,
                                        imageCiTrasera: _imageCiTrasera,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                DotsIndicator(
                                  dotsCount: 3,
                                  position: currentPage.toInt(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          elevation:
                                              WidgetStateProperty.all(0.0),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            Theme.of(context).primaryColor,
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                width: 1.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: const Text(
                                            'Continuar',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_pageController.page == 2.0) {
                                            if (_imageCiFrontal != null &&
                                                _imageCiTrasera != null) {
                                              _loadingNotifier.value = true;
                                              final clientResponse =
                                                  await widget
                                                      .personalDataController
                                                      .updateClientCI(
                                                ciFrontal: _imageCiFrontal!,
                                                ciTrasero: _imageCiTrasera!,
                                              );

                                              if (clientResponse != null) {
                                                _loadingNotifier.value = false;
                                                print('Client Response');
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        CarDataScreen(
                                                      personalDataController: widget
                                                          .personalDataController,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                // TODO: Actualizar excepciones
                                                _loadingNotifier.value = false;

                                                Fluttertoast.showToast(
                                                  msg:
                                                      'Hubo un problema cargando las imágenes, inténtelo de nuevo o contacte a su administrador',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                );
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'Imagen Frontal y Trasera son requeridas',
                                              );
                                            }
                                          } else {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              curve: Curves.linear,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (loading)
              Container(
                color: AppColors.primary.withOpacity(0.20),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
    );
  }
}

class _FotoFrontal extends StatelessWidget {
  final File? imageCiFrontal;
  final VoidCallback onTap;
  final String? ciFrontalCargado;

  const _FotoFrontal({
    super.key,
    required this.imageCiFrontal,
    required this.onTap,
    required this.ciFrontalCargado,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Stack(
              children: [
                Container(
                  height: 370,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffEC1C24),
                    ),
                  ),
                  child: imageCiFrontal == null
                      ? ciFrontalCargado != null
                          ? Image.network(ciFrontalCargado!)
                          : Image.asset('assets/img/ci_placeholder.png')
                      : Image.file(imageCiFrontal!),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: ElevatedButton(
                    child: const Text(
                      'Repetir',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      onTap();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            'Toma una fotografía de la parte frontal de la cédula de identidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _FotoTrasera extends StatelessWidget {
  final File? imageCiTrasera;
  final VoidCallback onTap;
  final String? ciTraseraCargado;

  const _FotoTrasera({
    super.key,
    required this.imageCiTrasera,
    required this.onTap,
    required this.ciTraseraCargado,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Stack(
              children: [
                Container(
                  height: 370,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffEC1C24),
                    ),
                  ),
                  child: imageCiTrasera == null
                      ? ciTraseraCargado != null
                          ? Image.network(ciTraseraCargado!)
                          : Image.asset('assets/img/ci_placeholder.png')
                      : Image.file(imageCiTrasera!),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: ElevatedButton(
                    child: const Text(
                      'Repetir',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      onTap();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            'Toma una fotografía de la parte posterior de la cédula de identidad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewFotos extends StatelessWidget {
  final File? imageCiFrontal;
  final File? imageCiTrasera;
  final String? ciFrontalCargado;
  final String? ciTraseraCargado;

  const _PreviewFotos({
    super.key,
    required this.imageCiFrontal,
    required this.imageCiTrasera,
    required this.ciFrontalCargado,
    required this.ciTraseraCargado,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 370,
              width: 280,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffEC1C24),
                        ),
                      ),
                      child: imageCiFrontal == null
                          ? ciFrontalCargado != null
                              ? Image.network(ciFrontalCargado!)
                              : Container()
                          : Image.file(imageCiFrontal!),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffEC1C24),
                        ),
                      ),
                      child: imageCiTrasera == null
                          ? ciTraseraCargado != null
                              ? Image.network(ciTraseraCargado!)
                              : Container()
                          : Image.file(imageCiTrasera!),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 14,
          ),
          const Text(
            'Valida que las fotografías se encuentren nítidas antes de  continuar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
