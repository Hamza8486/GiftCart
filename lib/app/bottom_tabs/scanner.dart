import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  var qrData = TextEditingController();
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          controller!.pauseCamera();
          qrData.text = result!.code.toString();
          showDialog(
            context: context,
            builder: (context) {
              return ScanResultDialog(
                qrData: qrData.text,
                onClose: () {
                  controller!.resumeCamera();
                },
              );
            },
          );
        }
      });
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          controller?.resumeCamera();
        },
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.orange,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 250,
          ),
        ),
      ),
    );
  }
}
class ScanResultDialog extends StatefulWidget {
  final String qrData;
  final Function onClose;

  ScanResultDialog({required this.qrData, required this.onClose});

  @override
  _ScanResultDialogState createState() => _ScanResultDialogState();
}

class _ScanResultDialogState extends State<ScanResultDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("QR Value"),
      content: TextFormField(
        initialValue: widget.qrData,
        readOnly: true,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onClose();
            Navigator.of(context).pop();
          },
          child: Text("Done"),
        ),
      ],
    );
  }
}
