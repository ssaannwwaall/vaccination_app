import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/ConstentStrings.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Widget/ListItemView.dart';

import 'Helper/Constants.dart';
import 'Models/NewRegisteration.dart';
import 'VaccineToRegisKids.dart';

class DefaulterScreen extends StatefulWidget {
  static const routeName = "/DefaulterScreen";

  const DefaulterScreen({Key? key}) : super(key: key);

  @override
  State<DefaulterScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<DefaulterScreen> {
  List<NewRegisterationModel> list_defaulter = [];
  Color screeThemeColor = MyColors.Defaulters;
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
      appBar: AppBar(
        backgroundColor: MyColors.Defaulters,
        actions: [],
        title: const Text('Defaulters',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: MyColors.color_white)),
      ),
      body: SafeArea(
        child: Container(
          width: _width,
          height: _hight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: _width,
                  height: _hight * .75,
                  child: list_defaulter.isNotEmpty
                      ? ListView.builder(
                          itemCount: list_defaulter.length,
                          itemBuilder: (ctx, index) {
                            return ListItemView(_width, list_defaulter[index],
                                '', screeThemeColor, () async {
                              Constants.regular_kid = list_defaulter[index];
                              Constants.isFollow_up = false;
                              //await Helper.determineCurrentPosition();
                              Navigator.of(context)
                                  .pushNamed(VaccineToRegisKids.routeName);
                            });
                          },
                        )
                      : const Center(
                          child: Text(
                            'No ${ConstentStrings.defaulter} found',
                            style: TextStyle(
                                fontSize: 30, color: MyColors.color_black),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadUpcomingKids() async {
    Map map = await LocalDatabase.getAllKids();
    list_defaulter.clear();
    map.forEach((key, value) {
      final a = NewRegisterationModel.fromSnapshot(value);
      print(a);
      DateTime dateTime_vac = DateTime.parse(a.nextVaccinationDate);
      final dif = dateTime_vac.difference(dateTime_now).inDays;
      print('date diff is '); //more than -1 to 28 are in follow-up
      print(dif.toString());
      print(a.name);
      if (dif < 0) {
        list_defaulter.add(a);
      }
      // print('date od birth is');
      // print(list_kids[0].dob);
    });
    setState(() {
      list_defaulter;
    });
  }
}
