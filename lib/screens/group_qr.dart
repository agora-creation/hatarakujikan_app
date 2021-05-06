import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/screens/group_qr_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GroupQRScreen extends StatefulWidget {
  @override
  _GroupQRScreenState createState() => _GroupQRScreenState();
}

class _GroupQRScreenState extends State<GroupQRScreen> {
  QRViewController _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController?.pauseCamera();
    }
    _qrController?.resumeCamera();
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() => _qrController = qrController);
    qrController.scannedDataStream.listen((scanData) {
      if (scanData.code == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QRコードがありません')),
        );
      }
      _nextScreen(describeEnum(scanData.format), scanData.code);
    });
  }

  Future<void> _nextScreen(String type, String data) async {
    if (!_isQRScanned) {
      _qrController?.pauseCamera();
      _isQRScanned = true;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupQRViewScreen(type: type, data: data),
        ),
      ).then((value) {
        _qrController?.resumeCamera();
        _isQRScanned = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('会社/組織を入る', style: TextStyle(color: Colors.blue)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.blue),
          ),
        ],
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Color(0xFF0097A7),
          borderRadius: 16.0,
          borderLength: 24.0,
          borderWidth: 8.0,
        ),
      ),
    );
  }
}
