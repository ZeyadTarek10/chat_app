import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); 
    path.quadraticBezierTo(size.width / 2, 80, size.width, 0);
    path.lineTo(size.width, size.height); 
    path.lineTo(0, size.height); 
    path.close(); 
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}