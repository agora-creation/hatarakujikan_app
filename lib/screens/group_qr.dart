import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/group_qr_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GroupQRScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;

  GroupQRScreen({
    required this.groupProvider,
    required this.userProvider,
  });

  @override
  _GroupQRScreenState createState() => _GroupQRScreenState();
}

class _GroupQRScreenState extends State<GroupQRScreen> {
  QRViewController? _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;
  GroupModel? _group;

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
        _nextScreen(groupId: scanData.code ?? '');
      }
    });
  }

  Future<void> _nextScreen({String? groupId}) async {
    _group = await widget.groupProvider.select(id: groupId);
    if (_group != null) {
      if (!_isQRScanned) {
        _qrController?.pauseCamera();
        _isQRScanned = true;
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupQRViewScreen(
              groupProvider: widget.groupProvider,
              userProvider: widget.userProvider,
              group: _group!,
            ),
          ),
        ).then((value) {
          _qrController?.dispose();
          _isQRScanned = false;
          _group = null;
          Navigator.of(context, rootNavigator: true).pop();
        });
      }
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
            icon: Icon(Icons.close, color: Colors.blue),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
