import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // Rebuild jika kamera berubah (untuk Android hot reload fix)
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child:
                  (result != null)
                      ? Text('Hasil: ${result!.code}')
                      : const Text('Arahkan kamera ke QR Code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera(); // Pause setelah berhasil scan
      _showScanResult(context, scanData.code ?? "Tidak ada data");
    });
  }

  void _showScanResult(BuildContext context, String data) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Hasil Scan"),
            content: Text(data),
            actions: [
              TextButton(
                onPressed: () {
                  controller?.resumeCamera(); // Resume jika ingin scan lagi
                  Navigator.of(context).pop();
                },
                child: const Text("Scan Lagi"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Keluar dari halaman scan
                },
                child: const Text("Selesai"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
