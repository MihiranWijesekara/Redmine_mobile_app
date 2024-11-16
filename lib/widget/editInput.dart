import 'package:flutter/material.dart';

class Editinput extends StatelessWidget {
  final String text;
  final String? initialValue; 
   final ValueChanged<String> onChanged;
  const Editinput({
    Key? key,
    required this.text,
    this.initialValue, 
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue, 
      decoration: InputDecoration(
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
