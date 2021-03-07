import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('はたらくじかん', style: TextStyle(fontSize: 32.0)),
                    Text('for スマートフォン', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                SizedBox(height: 32.0),
                Center(
                  child: SpinKitFadingCube(
                    color: Colors.blueAccent,
                    size: 32.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
