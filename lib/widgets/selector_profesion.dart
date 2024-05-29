import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/models/extra/profesion_model.dart';

class SelectorProfesion extends StatefulWidget {
  const SelectorProfesion({
    super.key,
    required this.profesiones,
    required this.onChanged,
    required this.ocupacionInicial,
    this.enabled = true,
  });

  final int? ocupacionInicial;
  final List<ProfesionModel>? profesiones;
  final Function(ProfesionModel) onChanged;
  final bool enabled;

  @override
  _SelectorProfesionState createState() => _SelectorProfesionState();
}

class _SelectorProfesionState extends State<SelectorProfesion> {
  ProfesionModel? profesionSeleccioneda;

  @override
  void initState() {
    if (widget.ocupacionInicial != 0) {
      if (widget.profesiones!
          .where((p) => p.idAlianza == widget.ocupacionInicial)
          .isNotEmpty) {
        profesionSeleccioneda = widget.profesiones!
            .firstWhere((p) => p.idAlianza == widget.ocupacionInicial);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.enabled
          ? null
          : () {
              ValueNotifier<String> buscadorProfesionNotifier =
                  ValueNotifier('');

              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              buscadorProfesionNotifier.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Buscar profesión',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: ValueListenableBuilder<String>(
                          valueListenable: buscadorProfesionNotifier,
                          builder: (context, value, child) {
                            return ListView.builder(
                              itemCount: widget.profesiones!.length,
                              itemBuilder: (context, index) {
                                final profesion = widget.profesiones![index];

                                if (!profesion.nombreProfesion
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  return Container();
                                }

                                return ListTile(
                                  title: Text(
                                      profesion.nombreProfesion.toUpperCase()),
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      profesionSeleccioneda = profesion;
                                    });
                                    widget.onChanged(profesion);
                                  },
                                );
                              },
                            );
                          },
                        ))
                      ],
                    ),
                  );
                },
              );
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        child: Row(
          children: [
            Expanded(
              child: Text(
                profesionSeleccioneda != null
                    ? profesionSeleccioneda!.nombreProfesion.toUpperCase()
                    : 'Selecciona una profesión',
                style: TextStyle(
                  color: !widget.enabled ? Colors.grey : null,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
