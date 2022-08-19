import 'package:crazy_nfts/ui/components/mirrow_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleCrypto extends StatelessWidget {
  final IconData iconData;
  Color? iconColor;
  Color? backdropColor;

  CircleCrypto({
    super.key,
    required this.iconData,
    this.iconColor,
    this.backdropColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000000),
      child: MirrorStyle(
        sigmaX: 2,
        sigmaY: 2,
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backdropColor ?? Colors.black.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            iconData,
            color: iconColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
