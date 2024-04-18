import 'package:flutter/material.dart';

class SelectorNumero extends StatefulWidget {
  const SelectorNumero({
    super.key,
    required this.valorInicial,
    required this.valorMinimo,
    required this.valorMaximo,
    required this.onChanged,
  });

  final int valorInicial;
  final int valorMinimo;
  final int valorMaximo;
  final Function(int?) onChanged;

  @override
  _SelectorNumeroState createState() => _SelectorNumeroState();
}

class _SelectorNumeroState extends State<SelectorNumero> {
  int? valor;

  @override
  void initState() {
    super.initState();

    valor = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (valor! > widget.valorMinimo) {
                  setState(() {
                    valor = (valor ?? 3) - 1;
                  });
                  widget.onChanged(valor);
                }
              },
              child: Container(
                color: const Color(0xff1D2766),
                child: const Center(
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.5,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final numeroAsientosController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: TextField(
                          controller: numeroAsientosController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Ingrese número asientos',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            child: const Text('Aceptar'),
                            onPressed: () {
                              final valorNumeroAsientosController =
                                  numeroAsientosController.text;

                              if (int.tryParse(valorNumeroAsientosController) ==
                                  null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            'El número ingresado debe ser un valor numérico'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Aceptar'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                return;
                              }

                              if (int.parse(valorNumeroAsientosController) >
                                      30 ||
                                  int.parse(valorNumeroAsientosController) <
                                      2) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            'El número ingresado debe ser un valor numérico entre 2 y 30'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Aceptar'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                return;
                              }

                              setState(
                                () {
                                  valor =
                                      int.parse(valorNumeroAsientosController);
                                },
                              );
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  '$valor',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff1D2766)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (valor! < widget.valorMaximo) {
                  setState(() {
                    valor = (valor ?? 2) + 1;
                  });
                  widget.onChanged(valor);
                }
              },
              child: Container(
                color: const Color(0xff1D2766),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
