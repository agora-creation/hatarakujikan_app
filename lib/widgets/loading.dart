import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;

  Loading({this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: Colors.cyan.shade700,
        size: size,
      ),
    );
  }
}
