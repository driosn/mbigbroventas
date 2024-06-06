import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/search_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/screens/personal_data/personal_data_found_client_screen.dart';
import 'package:mibigbro_ventas_mobile/screens/personal_data/personal_data_screen.dart';
import 'package:mibigbro_ventas_mobile/utils/app_colors.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class SearchClientScreen extends StatefulWidget {
  const SearchClientScreen({super.key});

  @override
  State<SearchClientScreen> createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {
  final _bigBroService = BigBroService();

  final ValueNotifier<(bool, Client?)> searchClientNotifier =
      ValueNotifier((false, null));

  final _ciController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BigBroScaffold(
      title: 'Buscar cliente',
      body: SingleChildScrollView(
        child: Padding(
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
              ValueListenableBuilder<(bool, Client?)>(
                valueListenable: searchClientNotifier,
                builder: (context, (bool, Client?) value, child) {
                  if (value.$1) {
                    return Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: const CircularProgressIndicator(),
                    );
                  }

                  final searchedClient = value.$2;
                  if (searchedClient != null) {
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
                            title: 'Nombre:',
                            value: searchedClient.nombre,
                          ),
                          _infoTile(
                            title: 'Apellido Paterno:',
                            value: searchedClient.apellidoPaterno,
                          ),
                          _infoTile(
                            title: 'Apellido Materno:',
                            value: searchedClient.apellidoMaterno,
                          ),
                          _infoTile(
                            title: 'CI:',
                            value: searchedClient.numeroDocumento,
                          ),
                          _infoTile(
                            title: 'Extension:',
                            value: searchedClient.extension,
                          ),
                          _infoTile(
                            title: 'Género:',
                            value: searchedClient.genero,
                          ),
                          _infoTile(
                            title: 'Nro Celular:',
                            value: searchedClient.nroCelular,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PersonalDataFoundClientScreen(
                                      client: searchedClient,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('Continuar'),
                          )
                        ],
                      ),
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.only(
                      top: 32,
                    ),
                    child: const Text(
                      'Busque cliente por CI',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
              hintText: 'Buscar cliente por CI',
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
                Fluttertoast.showToast(msg: 'Debe ingresar un número de CI');
                return;
              }

              searchClientNotifier.value = (true, null);

              final searchClientResponse = await _bigBroService.searchClient(
                // dni: '6765763',
                dni: _ciController.text,
              );

              searchClientNotifier.value = (
                false,
                searchClientResponse.data,
              );
            } catch (error) {
              searchClientNotifier.value = (
                false,
                null,
              );
              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (_) => const PersonalDataFormScreen(),
                ),
              );

              Fluttertoast.showToast(
                msg: 'Cliente no encontrado, registre los datos del cliente',
              );
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
