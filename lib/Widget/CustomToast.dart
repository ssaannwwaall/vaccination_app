import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  String _textMessage;
  Color _color, _text_color;

  //const CustomToast({Key? key}) : super(key: key);
  CustomToast(this._text_color, this._textMessage, this._color);

  @override
  Widget build(BuildContext context) {
    return //Interactive toast, set [isIgnoring] false.
        Container(

      // padding: const EdgeInsets.symmetric(horizontal: 18.0),
      // margin: const EdgeInsets.symmetric(horizontal: 50.0),
      // decoration: ShapeDecoration(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(5.0),
      //   ),
      //   color: _color,
      // ),
      // child: Row(
      //   children: [
      //     Text(
      //       _textMessage,
      //       style: TextStyle(
      //         color: _text_color,
      //       ),
      //     ),
      //     // IconButton(
      //     //   onPressed: () {
      //     //     ToastManager().dismissAll(showAnim: true);
      //     //     Navigator.push(context,
      //     //         MaterialPageRoute(builder: (context) {
      //     //           return SecondPage();
      //     //         }));
      //     //   },
      //     //   icon: Icon(
      //     //     Icons.add_circle_outline_outlined,
      //     //     color: Colors.white,
      //     //   ),
      //     // ),
      //   ],
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ),
    );
  }
}
