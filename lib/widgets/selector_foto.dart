import 'dart:io';

import 'package:flutter/material.dart';

class SelectorFoto extends StatelessWidget {
  const SelectorFoto({
    super.key,
    required this.onTapImagen,
    required this.imagen,
    required this.onTapInfo,
    required this.placeHolderAsset,
    required this.description,
    this.reversePlaceholder = false,
  });

  final VoidCallback onTapImagen;
  final File? imagen;
  final VoidCallback onTapInfo;
  final String placeHolderAsset;
  final String description;
  final bool reversePlaceholder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTapImagen();
            },
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffEC1C24),
                    ),
                  ),
                  child: imagen == null
                      ? reversePlaceholder
                          ? Image.asset(placeHolderAsset)
                          : Image.asset(placeHolderAsset)
                      : Image.file(imagen!),
                ),
                Positioned(
                  bottom: 20,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      onTapInfo();
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: ElevatedButton(
                    child: const Text('Repetir'),
                    onPressed: () {
                      onTapImagen();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
