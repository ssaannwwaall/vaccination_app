import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController _controller;
  final String hint;
  final double _width;
  final TextInputType keyboardType;

  MyTextFiled(this._width, this.hint, this.keyboardType, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: _controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.6),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff8d62d6), width: 3.0),
          ),
          contentPadding: const EdgeInsets.all(7),
          labelText: hint,
        ),
      ),
    );
  }
}
