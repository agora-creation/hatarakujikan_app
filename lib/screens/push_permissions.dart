import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class PushPermissionsScreen extends StatefulWidget {
  @override
  _PushPermissionsScreenState createState() => _PushPermissionsScreenState();
}

class _PushPermissionsScreenState extends State<PushPermissionsScreen> {
  bool _isLoading = false;
  bool _requested = false;
  NotificationSettings _settings;
  String _token;
  Stream<String> _tokenStream;

  Future<void> requestPermissions() async {
    setState(() => _isLoading = true);
    final settings = await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
    setState(() {
      _isLoading = false;
      _requested = true;
      _settings = settings;
    });
  }

  void setToken(String token) {
    print('FCM Token: $token');
    setState(() => _token = token);
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    Widget _body;
    if (_isLoading) {
      _body = Loading(size: 32.0, color: Colors.cyan);
    }
    if (!_requested) {
      _body = Center(
        child: RoundBackgroundButton(
          labelText: '確認する',
          labelColor: Colors.white,
          backgroundColor: Colors.blue,
          labelFontSize: 16.0,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          onPressed: requestPermissions,
        ),
      );
    } else {
      _body = Column(
        children: [
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('Authorization Status'),
              trailing: Text(statusMap[_settings.authorizationStatus]),
            ),
          ),
          if (defaultTargetPlatform == TargetPlatform.iOS) ...[
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Alert'),
                trailing: Text(settingsMap[_settings.alert]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Announcement'),
                trailing: Text(settingsMap[_settings.announcement]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Badge'),
                trailing: Text(settingsMap[_settings.badge]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Car Play'),
                trailing: Text(settingsMap[_settings.carPlay]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Lock Screen'),
                trailing: Text(settingsMap[_settings.lockScreen]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Notification Center'),
                trailing: Text(settingsMap[_settings.notificationCenter]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Show Previews'),
                trailing: Text(previewMap[_settings.showPreviews]),
              ),
            ),
            Container(
              decoration: kBottomBorderDecoration,
              child: ListTile(
                title: Text('Sound'),
                trailing: Text(settingsMap[_settings.sound]),
              ),
            ),
          ],
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('PUSH通知の許可'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: _body,
    );
  }
}

const statusMap = {
  AuthorizationStatus.authorized: 'Authorized',
  AuthorizationStatus.denied: 'Denied',
  AuthorizationStatus.notDetermined: 'Not Determined',
  AuthorizationStatus.provisional: 'Provisional',
};

const settingsMap = {
  AppleNotificationSetting.disabled: 'Disabled',
  AppleNotificationSetting.enabled: 'Enabled',
  AppleNotificationSetting.notSupported: 'Not Supported',
};

const previewMap = {
  AppleShowPreviewSetting.always: 'Always',
  AppleShowPreviewSetting.never: 'Never',
  AppleShowPreviewSetting.notSupported: 'Not Supported',
  AppleShowPreviewSetting.whenAuthenticated: 'Only When Authenticated',
};
