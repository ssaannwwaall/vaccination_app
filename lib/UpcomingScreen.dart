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
                  height: _hight * .84,
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
                              Constants.isFollow_up = true;
                              //await Helper.determineCurrentPosition();
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
    NewRegisterationModel tmp;
    NewRegisterationModel init_obj;
    int diff_pre = -1;
    var dif_cur;
    map.forEach((key, value) {
      //print('kids value');
      var a = NewRegisterationModel.fromSnapshot(value);
      // print(a);
      DateTime dateTime_vac = DateTime.parse(a.nextVaccinationDate);
      dif_cur = dateTime_vac.difference(dateTime_now).inDays;

      if (dif_cur > -1 && dif_cur < 28) {
        init_obj = NewRegisterationModel.fromSnapshot(value);
        list_kids.add(init_obj);
        ///////////////
        for (int j = 0; j < list_kids.length; j++) {
          tmp = list_kids[j];
          //if (list_kids[i] > list_kids[j]) {
          if (dif_cur > diff_pre) {
            tmp = init_obj;
            init_obj = list_kids[j];
            list_kids[j] = tmp;
            print('shuffling...');
            print('name of kid');
            print(list_kids[j].name);
            print('currnet dif     $dif_cur    pre difff         $diff_pre');
          }
          diff_pre = dif_cur;
        }
      }
    });
    setState(() {
      list_kids;
    });
  }

/*List<NewRegisterationModel>  selectionSort(List<NewRegisterationModel> list ) {
  for (int i = 0; i < array.length; i++) {
  int min = array[i];
  int minId = i;
  for (int j = i+1; j < array.length; j++) {
  if (array[j] < min) {
  min = array[j];
  minId = j;
  }
  }
  // swapping
  int temp = array[i];
  array[i] = min;
  array[minId] = temp;
  }
  return list;
  }*/
}
