// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class IconOf extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  IconOf(this.icon, this.size, [this.color = Colors.black]);
  IconData icon;
  double size;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
