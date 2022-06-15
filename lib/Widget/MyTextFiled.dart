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
      margin: EdgeInsets.all(2),
      child: TextFormField(
        controller: _controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(7),
          labelText: hint,
        ),
      ),
    );
  }
}
