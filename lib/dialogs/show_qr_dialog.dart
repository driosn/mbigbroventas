import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';
import 'package:mibigbro_ventas_mobile/dialogs/custom_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

showQRDialog(
  BuildContext context, {
  required int amount,
  required VoidCallback onFinish,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(
        context: context,
        iconColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.black.withOpacity(0.16),
        hideActions: true,
        extraActions: [
          TextButton(
            onPressed: () {
              onFinish();
            },
            child: const Text('Finalizar'),
          )
        ],
        icon: const Icon(
          Icons.qr_code_2_outlined,
          color: Colors.white,
          size: 50,
        ),
        content: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    spreadRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: FutureBuilder(
                future: BigBroService().generateQR(
                  "80",
                  amount.toString(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Hubo un problema al cargar el QR',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.memory(base64Decode(snapshot.data!)),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Realiza el pago  de este Qr con la\naplicación de tu banco',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    final temporaryDir = (await getTemporaryDirectory()).path;
                    File file = File(
                        '/storage/emulated/0/Download/${DateTime.now().millisecondsSinceEpoch}.pdf');
                    File temporaryFile = File(
                        '$temporaryDir/${DateTime.now().millisecondsSinceEpoch}.pdf');
                    // TODO: IMprove qr generation
                    final qrString = await BigBroService().generateQR(
                      "80",
                      amount.toString(),
                    );
                    final imageBytes = base64Decode(qrString);
                    await file.writeAsBytes(imageBytes);
                    await temporaryFile.writeAsBytes(imageBytes);

                    Fluttertoast.showToast(msg: 'Imagen guardada en descargas');

                    final result =
                        await Share.shareXFiles([XFile(temporaryFile.path)]);

                    print(result);

                    print('Descargar');
                  },
                  child: Icon(
                    Icons.download,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () async {
                    final temporaryDir = (await getTemporaryDirectory()).path;
                    File file = File(
                        '/storage/emulated/0/Download/${DateTime.now().millisecondsSinceEpoch}.pdf');
                    File temporaryFile = File(
                        '$temporaryDir/${DateTime.now().millisecondsSinceEpoch}.pdf');
                    // TODO: IMprove qr generation
                    final qrString = await BigBroService().generateQR(
                      "80",
                      amount.toString(),
                    );
                    final imageBytes = base64Decode(qrString);
                    await file.writeAsBytes(imageBytes);
                    await temporaryFile.writeAsBytes(imageBytes);

                    Fluttertoast.showToast(msg: 'Imagen guardada en descargas');

                    final result =
                        await Share.shareXFiles([XFile(temporaryFile.path)]);

                    print(result);

                    print('Descargar');
                  },
                  child: Text(
                    'Descargar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    onFinish();
                  },
                  child: Text(
                    'Finalizar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
