import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Helper/MyColors.dart';

class StatusCard extends StatelessWidget {
  var _hight, _width;
  Color backgroundColor = MyColors.color_white;
  String _lableText = '';
  String _itemCount = '0';

  StatusCard(this._hight, this._width, this._lableText, this.backgroundColor,
      this._itemCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _hight,
      margin: const EdgeInsets.all(10),
      //color: MyColors.color_yellow_light,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        color: backgroundColor,
        elevation: 10,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: _hight * 0.6,
              width: _width * .9,
              child: Center(
                child: Text(
                  _itemCount,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: MyColors.color_white),
                ),
              ),
            ),
            Container(
              width: _width * .8,
              height: .5,
              color: MyColors.color_black,
            ),
            Container(
              height: _hight * 0.3,
              width: _width * .9,
              child: Center(
                child: Text(
                  _lableText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: MyColors.color_white,
                  ), //_width * .1 font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
