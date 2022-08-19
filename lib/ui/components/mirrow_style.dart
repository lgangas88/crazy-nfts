import 'dart:ui';

import 'package:flutter/material.dart';

class MirrorStyle extends StatelessWidget {
  const MirrorStyle({
    super.key,
    required this.child,
    this.sigmaX = 4.0,
    this.sigmaY = 4.0,
  });
  final Widget child;
  final double? sigmaX;
  final double? sigmaY;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX!, sigmaY: sigmaY!),
        child: child,
      ),
    );
  }
}
