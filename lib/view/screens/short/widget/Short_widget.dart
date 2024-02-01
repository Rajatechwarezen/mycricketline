import 'package:flutter/material.dart';

Widget getIcons(IconData icon, String count, double size, colors) {
  return Column(
    children: [
      Icon(
        icon,
        color: colors,
        size: size,
      ),
      Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}
