import 'package:flutter/material.dart';

import '../Helper/MyColors.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final void Function()? _function_handler;
  final double width;
  final Color buttonColor;
  MyButton(this.lable,this.buttonColor, this.width, this._function_handler);

  //static StreamBuilder

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              color: MyColors.color_white,
              fontWeight: FontWeight.w800,
              fontSize: 16),
          primary: buttonColor, // background
          onPrimary: Colors.black, // foreground
        ),
        onPressed: _function_handler,
        child: Text(
          lable,
          style: const TextStyle(
              color: MyColors.color_white,
              fontWeight: FontWeight.w800,
              fontSize: 16),
        ),
      ),
    );
  }
}
