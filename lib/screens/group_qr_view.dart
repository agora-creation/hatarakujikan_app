import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class GroupQRViewScreen extends StatelessWidget {
  final String type;
  final String data;

  GroupQRViewScreen({
    @required this.type,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('QRコード読取結果', style: TextStyle(color: Colors.blue)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.blue),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Type: $type Data: $data'),
            RoundBorderButton(
              labelText: 'もう一度読み取る',
              labelColor: Colors.blue,
              borderColor: Colors.blue,
              labelFontSize: 16.0,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
