import 'package:calorify/features/food_page/presentation/widgets/scanner_overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanningPage extends StatefulWidget {
  const BarcodeScanningPage({super.key});

  @override
  State<BarcodeScanningPage> createState() => _BarcodeScanningPageState();
}

class _BarcodeScanningPageState extends State<BarcodeScanningPage> {
  String _barcode = '';
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                setState(() {
                  _barcode = barcode.rawValue ?? 'Failed to scan Barcode';
                });
                Navigator.pop(context, _barcode);
              }
            },
          ),
          Center(child: ScannerOverlay())
        ],
      ),
    );
  }
}


