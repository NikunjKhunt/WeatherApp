import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors.dart';
import '../constants.dart';

logo(screenWidth) => Image.asset(
      "assets/images/logo.png",
      width: screenWidth / 2,
    );

header(
  text, {
  double fontSize = 22,
  isBold = true,
  isCenter = false,
  Color color = Colors.black,
}) =>
    Text(
      "$text",
      style: TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    );

subHeader(
  text, {
  double fontSize = 17,
  isBold = false,
  isCenter = false,
  Color color = Colors.grey,
}) =>
    header(
      text,
      color: color,
      fontSize: fontSize,
      isBold: isBold,
      isCenter: isCenter,
    );

gradientBackground() => const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color1,
          color2,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

whiteBackgroundWithBorder() => BoxDecoration(
    color: Colors.white.withAlpha(75), borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: whiteColor70, width: 2)
    /*boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.0,
                  spreadRadius: -2,
                  offset: new Offset(2.0, 0.0),
                ),
              ]*/
    );

gradientButton(
  text, {
  isLoading = false,
  required Function()? onTap,
  double fontSize = 22,
  Color color = Colors.white,
  double height = 60,
  disabled = false,
}) =>
    Container(
      height: height,
      decoration: disabled
          ? BoxDecoration(
              color: secondButtonColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            )
          : BoxDecoration(
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
            onTap: isLoading ? null : onTap,
            child: Center(
              child: (isLoading)
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      '$text',
                      style: TextStyle(color: color, fontSize: fontSize),
                    ),
            )),
      ),
    );

button(
  text, {
  Icon? icon,
  required Function()? onTap,
  double fontSize = 22,
  Color textColor = buttonTextColor,
  Color bgColor = Colors.white,
  double height = 50,
  double horizontalMargin = 0,
}) =>
    Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      decoration: BoxDecoration(
        color: bgColor,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$text',
                    style: TextStyle(color: textColor, fontSize: fontSize),
                  ),
                  if (icon != null) icon,
                ],
              ),
            )),
      ),
    );

// button(
//   text, {
//   required Function()? onTap,
//   double fontSize = 22,
//   Color color = Colors.white,
//   double height = 60,
// }) =>
//     Container(
//       height: height,
//       decoration: const ,
//       child: Material(
//         color: Colors.transparent,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: InkWell(
//             onTap: onTap,
//             child: Center(
//               child: Text(
//                 '$text',
//                 style: TextStyle(color: color, fontSize: fontSize),
//               ),
//             )),
//       ),
//     );

textFieldInputDecoration(hintText, {IconButton? suffixIcon}) => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: hintColor, fontWeight: FontWeight.w500),
      hintText: hintText,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
    );

space({double height = 0, double width = 0}) => SizedBox(
      height: height,
      width: width,
    );

vSpace({double height = Cons.space}) => space(height: height);

hSpace({double width = Cons.space}) => space(width: width);
