import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/ConstentStrings.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Widget/ListItemView.dart';

import 'Models/NewRegisteration.dart';

class RefusalScreen extends StatefulWidget {
  static const routeName = "/RefusalScreen";

  const RefusalScreen({Key? key}) : super(key: key);

  @override
  State<RefusalScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<RefusalScreen> {
  List<NewRegisterationModel> list_refusal = [];
  Color screeThemeColor = MyColors.color_purpel_light;
  DateTime dateTime_now = DateTime.now();

  @override
  void initState() {
    //TODO: implement initState
    _loadUpcomingKids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _width,
          height: _hight,
          child: Column(
            children: [
              Container(
                width: _width,
                height: _hight * .05,
                child: Center(
                  child: Text(
                    'Refusals',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: screeThemeColor),
                  ),
                ),
              ),
              Container(
                width: _width,
                height: _hight * .85,
                child: list_refusal.isNotEmpty
                    ? ListView.builder(
                        itemCount: list_refusal.length,
                        itemBuilder: (ctx, index) {
                          return ListItemView(_width, list_refusal[index],
                              'Vaccination date ', screeThemeColor, () {});
                        },
                      )
                    : const Center(
                        child: Text(
                        'No ${ConstentStrings.defaulter} found',
                        style: TextStyle(
                            fontSize: 30, color: MyColors.color_black),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadUpcomingKids() async {
    Map map = await LocalDatabase.getAllKids();
    list_refusal.clear();
    map.forEach((key, value) {
      final a = NewRegisterationModel.fromSnapshot(value);
      print(a);
       if (a.refusal == true) {
        list_refusal.add(a);
      }
    });
    setState(() {
      list_refusal;
    });
  }
}
