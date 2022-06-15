import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Models/NewRegisteration.dart';
import 'package:intl/intl.dart';

class ListItemView extends StatelessWidget {
  double? _width;
  Color? color;
  NewRegisterationModel? newRegisteraionModel;
  String next_vaccination_date = 'Next vaccination date';
  final void Function()? _function_handle;

  ListItemView(this._width, this.newRegisteraionModel,
      this.next_vaccination_date, this.color, this._function_handle);

  DateTime? dateTime_dob;
  DateTime? dateTime_next_vacc;

  @override
  Widget build(BuildContext context) {
    //_getVaccinaitonName(newRegisteraionModel!.vaccinationKey);
    dateTime_dob = DateFormat("yyyy-MM-dd").parse(newRegisteraionModel!.dob);
    dateTime_next_vacc = DateFormat("yyyy-MM-dd")
        .parse(newRegisteraionModel!.nextVaccinationDate);
    print('date');
    print(dateTime_dob.toString());

    return Container(
      color: color,
      width: _width,
      margin: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: _function_handle,
        child: Card(
          elevation: 0,
          child: Container(
            color: color,
            child: Row(
              children: [
                Container(
                  width: _width! * 0.3,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(newRegisteraionModel!.pic),
                        //Image.network(newRegisteraionModel!.pic),
                      ),
                      Text(
                        newRegisteraionModel!.list_of_vaccincs![0].vaccination_name!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColors.color_white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _width! * .6,
                  height: 100,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          //new DateFormat("yyyy-MM-dd").parse(newRegisteraionModel!.nextVaccinationDate),
                          //newRegisteraionModel!.nextVaccinationDate,
                          //dateTime_next_vacc.toString(),
                          '$next_vaccination_date ${dateTime_next_vacc!.day}-${dateTime_next_vacc!.month}-${dateTime_next_vacc!.year}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_white),
                        ),
                        Text(
                          newRegisteraionModel!.name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_white),
                        ),
                        Text(
                          //"DOB ${dateTime_dob.toString()}",
                          "DOB ${dateTime_dob!.day}-${dateTime_dob!.month}-${dateTime_dob!.year}",
                          //newRegisteraionModel!.nextVaccinationDate
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// void _getVaccinaitonName(String vaccination_key) async {
//   Map result_map = await LocalDatabase.getDoseAndVaccines() as Map;
//   if (result_map != null) {
//     result_map.forEach((key, value) {
//       print('kkkkk');
//       print(key);
//     });
//   }
// }
}
