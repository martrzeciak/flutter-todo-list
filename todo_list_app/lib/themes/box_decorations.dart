import 'package:flutter/material.dart';
import 'package:todo_list_app/themes/colors.dart';

Decoration getContainerDecoration() {
  return BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(20));
                // gradient: const LinearGradient(
                //     begin: Alignment.bottomRight,
                //     end: Alignment.topLeft,
                //     colors: [primaryColor, secondaryColor]));
}
