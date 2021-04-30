import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/group_add.dart';
import 'package:hatarakujikan_app/screens/group_button.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  ScanResult scanResult;

  Future<void> _scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'カメラへのアクセスが許可されていません';
        });
      } else {
        result.rawContent = 'エラー: $e';
      }
      setState(() => scanResult = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('会社/組織に所属しておりません'),
          ),
        ),
        GroupButton(
          createOnPressed: () => overlayScreen(context, GroupAddScreen()),
          inOnPressed: _scan,
        ),
      ],
    );
  }
}

class GroupInDialog extends StatelessWidget {
  final ScanResult scanResult;

  GroupInDialog({@required this.scanResult});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Result Type'),
            subtitle: Text(scanResult.type?.toString() ?? ''),
          ),
          ListTile(
            title: Text('RawContent'),
            subtitle: Text(scanResult.rawContent?.toString() ?? ''),
          ),
          ListTile(
            title: Text('Format'),
            subtitle: Text(scanResult.format?.toString() ?? ''),
          ),
          ListTile(
            title: Text('Format note'),
            subtitle: Text(scanResult.formatNote?.toString() ?? ''),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('キャンセル', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
