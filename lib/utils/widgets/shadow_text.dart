import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class ShadowText extends StatelessWidget {
  ShadowText(this.data, { required this.style }) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return  ClipRect(
      child:  Stack(
        children: [
           Positioned(
            top: 5.0,
            // left: 5.0,
            child:  Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.4)),
            ),
          ),
           BackdropFilter(
            filter:  ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child:  Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
