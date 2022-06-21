import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Widget/CardHome.dart';

import 'Widget/statusCard.dart';

class StatusScreen extends StatefulWidget {
  static const routeName = "/StatusScreen";

  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String _myCases = '0';
  String _myBorns = '0';
  String _myReg = '0';
  String _myCustomVac = '0';

  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: MyColors.splash,
        title: const Text(
          "RISI Status ",
          style: TextStyle(
              fontSize: 20,
              color: MyColors.color_white,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: _width,
          height: _hight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* Row(
                children: const [
                  Text(
                    '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),*/
              Container(
                width: _width,
                height: _hight * .70,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StatusCard(_hight * .25, _width * .42,
                              'Case Reporting', MyColors.splash, _myCases),
                          StatusCard(_hight * .25, _width * .42, 'New Reg.',
                              MyColors.Newly_Born, _myReg),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StatusCard(_hight * .25, _width * .42, 'Custom Vacc.',
                              MyColors.Defaulters, _myCustomVac),
                          StatusCard(_hight * .25, _width * .42, 'Newly Born',
                              MyColors.New_Register, _myBorns),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  width: _width,
                  height: _hight * .15,
                  child: Column(
                    children: [
                      Container(
                        width: _width * .8,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: MyColors.color_white,
                              ),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _loadData() async {
    print('cghjkl,mnbvfgukl,mn');
    await LocalDatabase.getMyReportingCases().then((value) => {
          if (value != null)
            {
              setState(() {
                _myCases = value;
                print('cgplplpl,mn');
                print(_myCases);
              }),
            }
          else
            {
              setState(() {
                _myCases = '0';
              }),
            }
        });
    await LocalDatabase.getMyNewBorns().then((value) => {
          if (value != null)
            {
              setState(() {
                _myBorns = value;
                print('new borns');
                print(_myBorns);
              }),
            }
          else
            {
              setState(() {
                _myBorns = '0';
              }),
            }
        });

    await LocalDatabase.getMyReg().then((value) => {
          if (value != null)
            {
              setState(() {
                _myReg = value;
                print('new _my Reg');
                print(_myReg);
              }),
            }
          else
            {
              setState(() {
                _myReg = '0';
              }),
            }
        });
    await LocalDatabase.getMyCustomReg().then((value) => {
          if (value != null)
            {
              setState(() {
                _myCustomVac = value;
                print('new _my Custom Vac Reg');
                print(_myCustomVac);
              }),
            }
          else
            {
              setState(() {
                _myCustomVac = '0';
              }),
            }
        });
  }
}
