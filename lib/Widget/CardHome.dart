import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Helper/MyColors.dart';

class CardHome extends StatelessWidget {
  var _hight, _width;
  Color backgroundColor = MyColors.color_white;
  String _lableText = '';
  String _svgPicture = 'assets/images/logo.svg';

  CardHome(this._hight, this._width, this._lableText, this.backgroundColor,
      this._svgPicture);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 3, bottom: 3),
      width: _width,
      height: _hight,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        color: backgroundColor,
        borderOnForeground: true,
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: _hight * 0.9,
                width: _width,
                child: SvgPicture.asset(_svgPicture)),
            Text(
              _lableText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MyColors.color_white,
              ), //_width * .1 font size
            ),
          ],
        ),
      ),
    );
  }
}