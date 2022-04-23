import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BreakEndQRScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  BreakEndQRScreen({
    required this.userProvider,
    required this.workProvider,
    required this.locations,
  });

  @override
  _BreakEndQRScreenState createState() => _BreakEndQRScreenState();
}

class _BreakEndQRScreenState extends State<BreakEndQRScreen> {
  QRViewController? _qrController;
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
        customSnackBar(context, 'QRコードがありません');
      }
      if (RegExp(r'^[A-Za-z0-9]+$').hasMatch(scanData.code ?? '')) {
        if (widget.userProvider.group?.id == scanData.code) {
          _nextAction();
        }
      }
    });
  }

  Future<void> _nextAction() async {
    if (!_isQRScanned) {
      _qrController?.pauseCamera();
      _isQRScanned = true;
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => BreakEndDialog(
          userProvider: widget.userProvider,
          workProvider: widget.workProvider,
          locations: widget.locations,
        ),
      ).then((value) {
        _qrController?.dispose();
        _isQRScanned = false;
        Navigator.of(context, rootNavigator: true).pop();
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
        title: Text('退勤する', style: TextStyle(color: Colors.orange)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.orange),
          ),
        ],
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 16.0,
          borderLength: 24.0,
          borderWidth: 8.0,
        ),
      ),
    );
  }
}
