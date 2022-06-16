import 'package:flutter/material.dart';
import 'package:vaccination_app/Helper/Constants.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/Helper.dart';
import 'package:vaccination_app/Helper/SharefPrefsCurrentUser.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/Models/VaccinationRecord.dart';
import 'package:vaccination_app/Widget/MyButton.dart';
import 'package:vaccination_app/Widget/RegularVaccinationRow.dart';
import 'package:vaccination_app/main.dart';
import 'Helper/Constants.dart';
import 'Helper/Constants.dart';
import 'Helper/LocalDatabase.dart';
import 'Helper/MyColors.dart';
import 'Models/NewRegisteration.dart';
import 'Models/VaccinationDoseForRegular.dart';

class VaccineToRegisKids extends StatefulWidget {
  static const routeName = "/VaccineToRegisKids";

  const VaccineToRegisKids({Key? key}) : super(key: key);

  @override
  State<VaccineToRegisKids> createState() => _VaccineToRegisKidsState();
}

class _VaccineToRegisKidsState extends State<VaccineToRegisKids> {
  Color screenThemeColor = MyColors.color_purpel_light;
  String currentVaccinatorName = '';
  DateTime dateTime_now = DateTime.now();

  //////////////next vaccination info
  String? _selectedDose;

  //String? _selectedVaccine;
  DateTime nextVaccinationDate = DateTime.now();
  final List<String> _dose = ['Dose'];

  //final List<String> _vaccine = ['Vaccine'];
  List<VaccinationDoseForRegular> list_of_vaccinations = [];

  @override
  void initState() {
    super.initState();
    _loadDoses();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: _hight,
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Add vaccination record',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Vaccinator username ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${FirebaseCalls.user.email}', //
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Child name ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${Constants.regular_kid?.name}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     const Text(
              //       'Vaccination name ',
              //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       ' ${Constants.regular_kid?.list_of_vaccincs![0]}',
              //       style: const TextStyle(
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: Constants.regular_kid!.list_of_vaccincs!.length,
                  itemBuilder: (ctx, index) {
                    return Row(
                      children: [
                        Checkbox(
                            checkColor: screenThemeColor,
                            value: Constants
                                .regular_kid!.list_of_vaccincs![index].vaccined,
                            onChanged: (newValue) {
                              print('check box hit...$index');
                              setState(() {
                                Constants.regular_kid!.list_of_vaccincs![index]
                                    .vaccined = newValue as bool;
                              });
                            }),
                        Text(
                          Constants.regular_kid!.list_of_vaccincs![index]
                              .vaccination_name!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )
                      ],
                    );
                    // return RegularVaccinationRow(
                    //     screenThemeColor,
                    //     Constants
                    //         .regular_kid!.list_of_vaccincs![index].vaccined,
                    //     Constants.regular_kid!.list_of_vaccincs![index]
                    //         .vaccination_name, (checkbox_value) {
                    //   print('check box clicked');
                    //   Constants.regular_kid!.list_of_vaccincs![index].vaccined =
                    //       checkbox_value as bool;
                    // });
                  },
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Date ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${dateTime_now.day}-${dateTime_now.month}-${dateTime_now.year}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _width * .4,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: .5, color: screenThemeColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Text(
                            'Lat: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Helper.currentPositon.longitude.toString()}}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: _width * .4,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: .5, color: screenThemeColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Text(
                            'Long: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Helper.currentPositon.longitude.toString()}}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: .5, color: screenThemeColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Address: ',
                        maxLines: 5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '${Helper.currentAddress}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                'Next vaccination info',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _width * .9,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: .5, color: screenThemeColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: const Text('Dose'),
                        value: _selectedDose,
                        onChanged: (newValue) async {
                          setState(() {
                            _selectedDose = newValue.toString();
                          });
                          print('selected dose is $_selectedDose');
                          await _loadVaccines(_selectedDose!);
                        },
                        items: _dose.map((thislocation) {
                          return DropdownMenuItem(
                            child: Text(thislocation),
                            value: thislocation,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  /*Container(
                    width: _width * .47,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: .5, color: screenThemeColor),
                      borderRadius: BorderRadius.circular(5),
                    ),

                    child: Center(
                      child: DropdownButton(
                          underline: const SizedBox(),
                          hint: const Text(
                            'Vaccine',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          value: _selectedVaccine,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedVaccine = newValue.toString();
                            });
                          },
                          items: _vaccine != null || _vaccine.isNotEmpty
                              ? _vaccine.map((thislocation) {
                                  return DropdownMenuItem(
                                    child: Text(thislocation),
                                    value: thislocation,
                                  );
                                }).toList()
                              : ['Vaccine'].map((thislocation) {
                                  return DropdownMenuItem(
                                    child: Text(thislocation),
                                    value: thislocation,
                                  );
                                }).toList()),
                    ),
                  ),*/
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _width * .47,
                    child: const Text(
                      "Next vaccination date ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: _width * .47,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: .5, color: screenThemeColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: nextVaccinationDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (date == null) return;
                          setState(() {
                            nextVaccinationDate = date;
                          });
                        },
                        child: Center(
                          child: Text(
                            '${nextVaccinationDate.day}-${nextVaccinationDate.month}-${nextVaccinationDate.year}',
                            style: const TextStyle(
                                fontSize: 14, color: MyColors.color_black),
                          ),
                        )),
                  ),
                ],
              ),
              MyButton('Submit', screenThemeColor, _width * .8, () async {
                //upload data here recorde and update user profile
                for (int a = 0;
                    a < Constants.regular_kid!.list_of_vaccincs!.length;
                    a++) {
                  if (Constants.regular_kid!.list_of_vaccincs![a].vaccined) {
                    //todo: put all checked vaccines in record one by one
                    await FirebaseCalls.setVaccinationRecord(
                        record: VaccinationRecord(
                            dateTime_now.toString(),
                            Constants.regular_kid!.list_of_vaccincs![a]
                                .vaccination_name,
                            Constants.regular_kid!.key,
                            FirebaseCalls.user.uid));
                    //todo: remove the vaccines from list which has been deployed to kids
                    Constants.regular_kid!.list_of_vaccincs!
                        .remove(Constants.regular_kid!.list_of_vaccincs![a]);
                  }
                }
                //todo: add new vaccinations in kid's list which kid has to  get next time, also list carries previous ones which are pending
                for (int b = 0; b < list_of_vaccinations.length; b++) {
                  Constants.regular_kid!.list_of_vaccincs!
                      .add(list_of_vaccinations[b]);
                }

                var kid = Constants.regular_kid;

                kid?.nextVaccinationDate = nextVaccinationDate.toString();
                //kid?.list_of_vaccincs = list_of_vaccinations!;
                await FirebaseCalls.setNewRegistration(newReg: kid!)
                    .then((value) => {
                          if (value == null)
                            {
                              Navigator.of(context)
                                  .pushNamed(HomeScreen.routeName),
                            }
                        });
              }),
            ],
          ),
        ),
      ),
    );
  }

  _loadDoses() async {
    Map doseMap = await LocalDatabase.getDoseAndVaccines();
    print("dose  Map map ");
    print(doseMap.toString());
    _dose.clear();
    doseMap.forEach((key, value) {
      _dose.add(key);
    });
    setState(() {
      _dose;
    });
    _loadVaccines(_dose[0]);
  }

  _loadVaccines(String dose) async {
    Map vaccinesMap = await LocalDatabase.getDoseAndVaccines();
    list_of_vaccinations.clear();
    vaccinesMap.forEach((key, value) {
      if (key == dose) {
        Map vaccine_map = value;
        vaccine_map.forEach((key, value) {
          list_of_vaccinations.add(VaccinationDoseForRegular(
              dateTime_now.toString(), key, FirebaseCalls.user.uid, false));
        });
      }
    });
    setState(() {
      list_of_vaccinations;
    });
  }
}
