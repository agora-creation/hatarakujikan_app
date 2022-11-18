import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

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

class PushPermissionsScreen extends StatefulWidget {
  final UserNoticeProvider userNoticeProvider;

  PushPermissionsScreen({required this.userNoticeProvider});

  @override
  _PushPermissionsScreenState createState() => _PushPermissionsScreenState();
}

class _PushPermissionsScreenState extends State<PushPermissionsScreen> {
  bool _requested = false;
  bool _fetching = false;
  NotificationSettings? _settings;

  void _init() async {
    setState(() => _fetching = true);
    await widget.userNoticeProvider.requestPermissions().then((value) {
      setState(() {
        _requested = true;
        _fetching = false;
        _settings = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('PUSH通知の許可'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: _fetching
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                Container(
                  decoration: kBottomBorderDecoration,
                  child: ListTile(
                    title: Text('Authorization Status'),
                    trailing: _requested
                        ? Text(statusMap[_settings?.authorizationStatus] ?? '')
                        : null,
                  ),
                ),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Alert'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.alert] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Announcement'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.announcement] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Badge'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.badge] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Car Play'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.carPlay] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Lock Screen'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.lockScreen] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Notification Center'),
                          trailing: _requested
                              ? Text(
                                  settingsMap[_settings?.notificationCenter] ??
                                      '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Show Previews'),
                          trailing: _requested
                              ? Text(previewMap[_settings?.showPreviews] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                defaultTargetPlatform == TargetPlatform.iOS
                    ? Container(
                        decoration: kBottomBorderDecoration,
                        child: ListTile(
                          title: Text('Sound'),
                          trailing: _requested
                              ? Text(settingsMap[_settings?.sound] ?? '')
                              : null,
                        ),
                      )
                    : Container(),
                SizedBox(height: 16.0),
                !_requested
                    ? RoundBackgroundButton(
                        onPressed: _init,
                        label: '許可する',
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                      )
                    : Container(),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
