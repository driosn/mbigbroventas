import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/screens/personal_data/personal_data_screen.dart';
import 'package:mibigbro_ventas_mobile/widgets/bigbro_scaffold.dart';

class SearchClientScreen extends StatelessWidget {
  SearchClientScreen({super.key});

  final _bigBroService = BigBroService();

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
              Row(
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
                        await _bigBroService.searchClient(
                          // dni: '6765763',
                          dni: '1',
                        );
                      } catch (error) {
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PersonalDataFormScreen(),
                          ),
                        );

                        Fluttertoast.showToast(
                          msg:
                              'Cliente no encontrado, registre los datos del cliente',
                        );
                        return;
                      }
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
