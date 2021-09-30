import 'package:flutter/material.dart';

InputDecoration Inputdecorationwidget(
    TextEditingController t, String label, hint) {
  return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14, right: 2),
        child: Transform.scale(
          scale: 0.8,
          child: IconButton(
            icon: Image.asset(
              'Assets/Frame.png',
            ),
            onPressed: () {},
          ),
        ),
      ),
      suffixIcon: Transform.scale(
        scale: 0.8,
        child: IconButton(
          icon: Image.asset('Assets/cross.png'),
          onPressed: () {
            t.clear();
          },
        ),
      ),
      filled: true,
      fillColor: const Color(0xFF210F37),
      hintText: label,
      hintStyle: const TextStyle(color: Color(0xFF9287A1), fontSize: 16),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF210F37)),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF210F37),
        ),
        borderRadius: BorderRadius.circular(25.7),
      ));
}
