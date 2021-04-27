import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0.0,
        centerTitle: true,
        title: Text('開発/運営会社', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _controller.loadUrl('https://agora-c.com');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'https://agora-c.com',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
