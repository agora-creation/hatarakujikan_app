import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/define.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class WorkStartQRScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  WorkStartQRScreen({
    required this.userProvider,
    required this.workProvider,
    required this.locations,
  });

  @override
  _WorkStartQRScreenState createState() => _WorkStartQRScreenState();
}

class _WorkStartQRScreenState extends State<WorkStartQRScreen> {
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
        builder: (_) => WorkStartDialog(
          userProvider: widget.userProvider,
          workProvider: widget.workProvider,
          locations: widget.locations,
          state: workStates[0],
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
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('出勤する', style: TextStyle(color: Color(0xFFFEFFFA))),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Color(0xFFFEFFFA)),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 16.0,
          borderLength: 24.0,
          borderWidth: 8.0,
        ),
      ),
    );
  }
}
