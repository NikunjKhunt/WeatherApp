import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors.dart';

header(
  text, {
  double fontSize = 22,
  isBold = true,
  Color color = Colors.black,
}) =>
    Text(
      "$text",
      style: TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
    );

subHeader(
  text, {
  double fontSize = 17,
  isBold = false,
}) =>
    header(
      text,
      color: Colors.grey,
      fontSize: fontSize,
      isBold: isBold,
    );

button(
  text, {
  required Function()? onTap,
  double fontSize = 22,
  Color color = Colors.white,
  double height = 60,
}) =>
    Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.5),
            blurRadius: 15,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
            onTap: onTap,
            child: Center(
              child: Text(
                '$text',
                style: TextStyle(color: color, fontSize: fontSize),
              ),
            )),
      ),
    );
