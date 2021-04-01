import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitWidget extends StatelessWidget {
  final double size;

  SpinKitWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCube(
        color: Colors.blue,
        size: size,
      ),
    );
  }
}
