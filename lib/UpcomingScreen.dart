import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Models/VaccinationRecord.dart';
import 'package:vaccination_app/Widget/ListItemView.dart';

import 'Helper/Constants.dart';
import 'Helper/Helper.dart';
import 'Models/NewRegisteration.dart';
import 'VaccineToRegisKids.dart';

class UpcomingScreen extends StatefulWidget {
  static const routeName = "/UpcomingScreen";

  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  List<NewRegisterationModel> list_kids = [];
  Color screeThemeColor = MyColors.Fllow_up;
  DateTime dateTime_now = DateTime.now();

  @override
  void initState() {
    _loadUpcomingKids();
    setState(() {
      list_kids;
    });
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
        backgroundColor: MyColors.Fllow_up,
        title: const Text(
          "Follow-up kids",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: MyColors.color_white),
        ),
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
                  height: _hight *.84,
                  child: list_kids.isNotEmpty
                      ? ListView.builder(
                          itemCount: list_kids.length,
                          itemBuilder: (ctx, index) {
                            return ListItemView(
                                _width,
                                list_kids[index],
                                'Next Vaccination Date',
                                screeThemeColor, () async {
                              Constants.regular_kid = list_kids[index];
                              await Helper.determineCurrentPosition();
                              Navigator.of(context)
                                  .pushNamed(VaccineToRegisKids.routeName);
                            });
                          },
                        )
                      : Container(
                          child: const Center(
                              child: Text(
                            'Follow-up childrens not found',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
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
    list_kids.clear();
    map.forEach((key, value) {
      //print('kids value');
      final a = NewRegisterationModel.fromSnapshot(value);
      // print(a);
      DateTime dateTime_vac = DateTime.parse(a.nextVaccinationDate);
      final dif = dateTime_vac.difference(dateTime_now).inDays;
      print('date diff is '); //more than -1 to 28 are in follow-up
      print(dif.toString());
      print(a.name);
      if (dif > -1 && dif < 28) {
        list_kids.add(a);
      }
      // print('date od birth is');
      // print(list_kids[0].dob);
    });
    setState(() {
      list_kids;
    });
  }
}
