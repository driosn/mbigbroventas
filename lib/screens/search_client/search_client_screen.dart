import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/data/models/create_client/search_client_response.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/screens/personal_data/personal_data_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class SearchClientScreen extends StatelessWidget {
  SearchClientScreen({super.key});

  final _bigBroService = BigBroService();

  final ValueNotifier<(bool, Client?)> searchClientNotifier =
      ValueNotifier((false, null));

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
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: const CircularProgressIndicator(),
                    );
                  }

                  final searchedClient = value.$2;
                  if (searchedClient != null) {
                    return const Column(
                      children: [
                        Text('Nombre: '),
                        Text('Apellido Paterno: '),
                        Text('Apellido Paterno: '),
                        Text('CI: '),
                        Text('Extension: '),
                        Text('Género: '),
                        Text('Nro Celular: ')
                      ],
                    );
                  }
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
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
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
              searchClientNotifier.value = (true, null);

              final searchClientResponse = await _bigBroService.searchClient(
                // dni: '6765763',
                dni: '1',
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
            child: const Text(
              "Fin de cobertura:",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(
            'asd',
            style: TextStyle(
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
