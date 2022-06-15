import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vaccination_app/Models/NewRegisteration.dart';
import 'Helper/FirebaseCall.dart';
import 'Helper/Helper.dart';
import 'Helper/LocalDatabase.dart';
import 'Helper/MyColors.dart';
import 'Helper/custom_validator.dart';
import 'HomeScreen.dart';
import 'Models/NewlyBorn.dart';
import 'Models/VaccinationDoseForRegular.dart';
import 'Widget/MyButton.dart';
import 'Widget/MyTextFiled.dart';

class NewRegisterationScreen extends StatefulWidget {
  static const String routeName = '/NewRegisterationScreen';

  const NewRegisterationScreen({Key? key}) : super(key: key);

  @override
  State<NewRegisterationScreen> createState() => _NewRegisterationScreenState();
}

class _NewRegisterationScreenState extends State<NewRegisterationScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerFName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEpiCardNo = TextEditingController();
  final TextEditingController _controllerLatLong = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  String lat = '33.6163723';
  String long = '72.8059114';
  Position? currentPosition;
  int _radioGroupValue = 0;

  PlatformFile? _filePicPicked;
  String pic_url = '';

  final List<String> _cities = ['City'];
  final List<String> _tahsil = ['Tahsil'];
  final List<String> _councils = ['Council'];

  final List<String> _dose = ['Dose'];

  //final List<String> _vaccine = ['Vaccine'];

  String? _selectedCity;
  String? _selectedTahsil;
  String? _selectedConsil;

  String? _selectedDose;

  //String? _selectedVaccine;

  DateTime dob = DateTime.now();
  DateTime nextVaccinationDate = DateTime.now();
  Color screenThemeColor = MyColors.color_yellow_light;

  List<VaccinationDoseForRegular> list_of_vaccinations = [];

  @override
  void initState() {
    // TODO: implement initState
    _loadCities();
    _loadDoses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPosition = Helper.currentPositon;
    print('longitude on new birth    ');
    print(currentPosition?.latitude);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    String lt = Helper.currentPositon.latitude.toString();
    String lng = Helper.currentPositon.longitude.toString();
    _controllerLatLong.text = '$lt , $lng';
    _controllerAddress.text = Helper.currentAddress;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: MyColors.color_white,
          height: _hight,
          width: _width,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: MyColors.color_yellow_light,
                          height: _hight * .07,
                          width: _width,
                          child: const Center(
                            child: Text(
                              'New Registration',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MyColors.color_white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Feedback.forTap(context);
                            print('file picked       click...');
                            _filePicPicked = await Helper.getPictureFromPhone();
                            if (_filePicPicked != null) {
                              setState(() {
                                _filePicPicked;
                                print('file picked  $_filePicPicked');
                              });
                              if (await Helper.isInternetAvailble()) {
                                pic_url = await FirebaseCalls.uploadPicture(
                                    'newlyBorn',
                                    _controllerPhone.text.toString(),
                                    _filePicPicked!.path!);
                              } else {
                                pic_url = _filePicPicked!.path!;
                                pic_url = _filePicPicked!.path!;
                              }
                              print('download url in screen is $pic_url');
                            } else {
                              //something went wrong
                              Fluttertoast.showToast(
                                  msg: "something went wrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.color_gray,
                                  textColor: MyColors.color_white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Container(
                            width: _width * .9,
                            height: _hight * 0.13,
                            child: _filePicPicked != null
                                ? Image.file(
                                    File(_filePicPicked!.path!),
                                    //fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset('assets/images/camera.svg'),
                          ),
                          // Container(
                          //   height: _hight * 0.13,
                          //   width: _width,
                          //   child: SvgPicture.asset('assets/images/logo.svg'),
                          // ),
                        ),
                        Container(
                          height: _hight * 0.64,
                          width: _width,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyTextFiled(
                                                _width * .47,
                                                'Child name',
                                                TextInputType.name,
                                                _controllerName),
                                            MyTextFiled(
                                                _width * .47,
                                                'Father name',
                                                TextInputType.name,
                                                _controllerFName),
                                          ],
                                        ),
                                        MyTextFiled(
                                            _width * 0.95,
                                            'Phone number',
                                            TextInputType.name,
                                            _controllerPhone),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: _width * .47,
                                            ),
                                            Container(
                                              width: _width * .47,
                                              child: Text(
                                                'Date of Birth',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        MyColors.color_black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyTextFiled(
                                                _width * .47,
                                                'Epi card no',
                                                TextInputType.name,
                                                _controllerEpiCardNo),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              width: _width * .47,
                                              child: TextButton(
                                                  onPressed: () async {
                                                    DateTime? date =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate: dob,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100),
                                                    );
                                                    if (date == null) return;
                                                    setState(() {
                                                      dob = date;
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      '${dob.day}-${dob.month}-${dob.year}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: MyColors
                                                              .color_black),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // MyTextFiled(
                                            //     _width * .47,
                                            //     'District',
                                            //     TextInputType.name,
                                            //     _controllerCity),

                                            Container(
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Center(
                                                  child: DropdownButton(
                                                    underline: SizedBox(),
                                                    elevation: 5,
                                                    hint: Text('City'),
                                                    value: _selectedCity,
                                                    onChanged:
                                                        (newValue) async {
                                                      setState(() {
                                                        _selectedCity =
                                                            newValue.toString();
                                                      });
                                                      await _loadTahsil(
                                                          _selectedCity!);
                                                    },
                                                    items: _cities
                                                        .map((thislocation) {
                                                      return DropdownMenuItem(
                                                        child: new Text(
                                                            thislocation),
                                                        value: thislocation,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Center(
                                                  child: DropdownButton(
                                                      underline: SizedBox(),
                                                      hint: const Text(
                                                        'Tahsil',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      value: _selectedTahsil,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _selectedTahsil =
                                                              newValue
                                                                  .toString();
                                                        });
                                                        _loadCouncil(
                                                            _selectedCity!,
                                                            _selectedTahsil!);
                                                      },
                                                      items: _tahsil != null ||
                                                              _tahsil.isNotEmpty
                                                          ? _tahsil.map(
                                                              (thislocation) {
                                                              return DropdownMenuItem(
                                                                child: Text(
                                                                    thislocation),
                                                                value:
                                                                    thislocation,
                                                              );
                                                            }).toList()
                                                          : ['Tahsiil'].map(
                                                              (thislocation) {
                                                              return DropdownMenuItem(
                                                                child: Text(
                                                                    thislocation),
                                                                value:
                                                                    thislocation,
                                                              );
                                                            }).toList()),
                                                ),
                                              ),
                                            ),

                                            // MyTextFiled(
                                            //     _width * .47,
                                            //     'Tahsil',
                                            //     TextInputType.name,
                                            //     _controllerTahsil),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          width: _width * .7,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                width: .5, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: DropdownButton(
                                                underline: SizedBox(),
                                                hint: const Text(
                                                  'Union council',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                value: _selectedConsil,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedConsil =
                                                        newValue.toString();
                                                  });
                                                },
                                                items: _councils != null ||
                                                        _councils.isNotEmpty
                                                    ? _councils
                                                        .map((thislocation) {
                                                        return DropdownMenuItem(
                                                          child: Text(
                                                              thislocation),
                                                          value: thislocation,
                                                        );
                                                      }).toList()
                                                    : ['Councils']
                                                        .map((thislocation) {
                                                        return DropdownMenuItem(
                                                          child: Text(
                                                              thislocation),
                                                          value: thislocation,
                                                        );
                                                      }).toList()),
                                          ),
                                        ),

                                        //todo: vaccination details
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              width: _width * .9,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: DropdownButton(
                                                  underline: SizedBox(),
                                                  hint: const Text('Dose'),
                                                  value: _selectedDose,
                                                  onChanged: (newValue) async {
                                                    setState(() {
                                                      _selectedDose =
                                                          newValue.toString();
                                                    });
                                                    //print('selected dose is $_selectedDose');
                                                    await _loadVaccines(
                                                        _selectedDose!);
                                                  },
                                                  items:
                                                      _dose.map((thislocation) {
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                          thislocation),
                                                      value: thislocation,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            /* Container(
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: DropdownButton(
                                                    underline: SizedBox(),
                                                    hint: const Text(
                                                      'Vaccine',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    value: _selectedVaccine,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedVaccine =
                                                            newValue.toString();
                                                      });
                                                    },
                                                    items: _vaccine != null ||
                                                            _vaccine.isNotEmpty
                                                        ? _vaccine.map(
                                                            (thislocation) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                  thislocation),
                                                              value:
                                                                  thislocation,
                                                            );
                                                          }).toList()
                                                        : [
                                                            'Vaccine'
                                                          ].map((thislocation) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                  thislocation),
                                                              value:
                                                                  thislocation,
                                                            );
                                                          }).toList()),
                                              ),
                                            ),*/

                                            // MyTextFiled(
                                            //     _width * .47,
                                            //     'Tahsil',
                                            //     TextInputType.name,
                                            //     _controllerTahsil),
                                          ],
                                        ),
                                        //nextVaccinationDate
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: _width * .9,
                                            child: const Text(
                                              'Next vaccination date',
                                              style: TextStyle(
                                                  color: MyColors.color_black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          width: _width * .9,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                width: .5, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () async {
                                                  DateTime? date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        nextVaccinationDate,
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
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: MyColors
                                                            .color_black),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Container(
                                          width: _width * 9,
                                          child: Row(
                                            children: [
                                              // Checkbox(
                                              //     activeColor: screenThemeColor,
                                              //     value: checkboxVacciened,
                                              //     onChanged: (onChanged) {
                                              //       setState(() {
                                              //         checkboxVacciened =
                                              //             onChanged as bool;
                                              //         print(
                                              //             'value   $checkboxVacciened');
                                              //       });
                                              //     }),
                                              const Text(
                                                'Have done this vaccine',
                                                style: TextStyle(
                                                  color: MyColors.color_black,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        MyTextFiled(
                                            _width * 0.95,
                                            'Location coordinates',
                                            TextInputType.name,
                                            _controllerLatLong),
                                        MyTextFiled(
                                            _width * 0.95,
                                            'Address',
                                            TextInputType.streetAddress,
                                            _controllerAddress),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: _width * 0.33,
                                              height: _hight * 0.06,
                                              child: RadioListTile(
                                                value: 0,
                                                groupValue: _radioGroupValue,
                                                activeColor: screenThemeColor,
                                                selected: true,
                                                title: const Text(
                                                  'Male',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() =>
                                                      _radioGroupValue =
                                                          value as int);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.33,
                                              height: _hight * 0.06,
                                              child: RadioListTile(
                                                value: 1,
                                                groupValue: _radioGroupValue,
                                                activeColor: screenThemeColor,
                                                selected: false,
                                                title: const Text(
                                                  'Female',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() =>
                                                      _radioGroupValue =
                                                          value as int);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.33,
                                              height: _hight * 0.06,
                                              child: RadioListTile(
                                                value: 2,
                                                groupValue: _radioGroupValue,
                                                activeColor: screenThemeColor,
                                                selected: false,
                                                title: const Text(
                                                  'Trans',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() =>
                                                      _radioGroupValue =
                                                          value as int);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: _hight * .1,
                          width: _width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyButton('Back', screenThemeColor, _width * .48,
                                  () {
                                print('back pressed');
                                Navigator.of(context)
                                    .pushNamed(HomeScreen.routeName);
                              }),
                              MyButton(
                                  'Add child', screenThemeColor, _width * .48,
                                  () async {
                                print('add child');
                                String? name = CustomValidator().validateName(
                                    _controllerName.text.toString());
                                String? fname = CustomValidator().validateName(
                                    _controllerFName.text.toString());
                                String? phone = CustomValidator()
                                    .validateMobile(
                                        _controllerPhone.text.toString());
                                //String? dob = CustomValidator().validateName(
                                //   _controllerDateOfBirth.text.toString());
                                String? city = CustomValidator()
                                    .validateDescription(_selectedCity);
                                print('cityyyyyyyyyyyyyy');
                                print(city);
                                String? thsl = CustomValidator()
                                    .validateDescription(_selectedTahsil);
                                String? council = CustomValidator()
                                    .validateDescription(_selectedConsil);
                                String? coordinats = CustomValidator()
                                    .validateDescription(
                                        _controllerLatLong.text.toString());
                                String? address = CustomValidator()
                                    .validateAddress(
                                        _controllerAddress.text.toString());
                                String gender = 'Male';
                                if (_radioGroupValue == 0) {
                                  gender = 'Male';
                                } else if (_radioGroupValue == 1) {
                                  gender = 'Female';
                                } else if (_radioGroupValue == 2) {
                                  gender = 'Transgender';
                                }
                                if (name != null) {
                                  showtoas(name);
                                } else if (fname != null) {
                                  fname =
                                      fname.replaceAll('Name', 'Father name ');
                                  showtoas('$fname');
                                } else if (phone != null) {
                                  showtoas(phone);
                                } else if (city != null) {
                                  city = city.replaceAll('Field', 'City ');
                                  showtoas(' $city');
                                } else if (thsl != null) {
                                  thsl = thsl.replaceAll('Field', 'Tahsil ');
                                  showtoas(' $thsl');
                                } else if (council != null) {
                                  council =
                                      council.replaceAll('Field', 'Council ');
                                  showtoas(' $council');
                                } else if (coordinats != null) {
                                  coordinats = coordinats.replaceAll(
                                      'Name', 'Location coordinates ');
                                  showtoas(coordinats);
                                } else if (address != null) {
                                  showtoas(address);
                                } else if (pic_url == '') {
                                  showtoas('Picture required');
                                } else {
                                  //upload data
                                  print('list of vaccinations ');
                                  print(list_of_vaccinations[0].vaccination_name);
                                  var obj = NewRegisterationModel(
                                      _controllerName.text.toString(),
                                      _controllerFName.text.toString(),
                                      _controllerPhone.text.toString(),
                                      dob.toString(),
                                      _selectedCity!,
                                      _selectedTahsil!,
                                      (Helper.currentPositon.latitude
                                          .toString()),
                                      (Helper.currentPositon.longitude
                                          .toString()),
                                      _controllerAddress.text.toString(),
                                      pic_url,
                                      _selectedConsil!,
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(DateTime.now())
                                          .toString(),
                                      gender.toString(),
                                      nextVaccinationDate.toString(),
                                      //_selectedVaccine.toString(),
                                      list_of_vaccinations);

                                  print('button pressed');
                                  if (await Helper.isInternetAvailble()) {
                                    FirebaseCalls.setNewRegistration(
                                            newReg: obj)
                                        .then((value) => {
                                              if (value == null)
                                                {
                                                  showtoas(
                                                      'New reg. successfully'),
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          HomeScreen.routeName),
                                                }
                                              else
                                                {
                                                  showtoas(
                                                      'Something went wrong'),
                                                }
                                            });
                                  } else {
                                    showtoas('have not internet connection');
                                    // save in local data base
                                  }
                                }
                                //Navigator.of(context).pushNamed(HomeScreen.routeName);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadCities() async {
    Map cityMap = await LocalDatabase.getCitiesAndRegons();
    print("lcity map ");
    print(cityMap.toString());
    _cities.clear();
    cityMap.forEach((key, value) {
      print(key);
      _cities.add(key);
      print("list is above ");
    });
    setState(() {
      _cities;
    });
  }

  _loadTahsil(String city) async {
    Map cityMap = await LocalDatabase.getCitiesAndRegons();
    print("tahsil map ");
    //print(cityMap.toString());
    _tahsil.clear();
    cityMap.forEach((key, value) {
      print("tahsil loop ");
      //city loop
      if (key == city) {
        print(key);
        print("selected city is above ");
        print(value);
        Map tahsil_map = value;
        print("tahsil map is below ");
        print(tahsil_map.toString());
        tahsil_map.forEach((key, value) {
          print(key);
          print("list tahsil is above ");
          _tahsil.add(key);
        });
      }
    });
    print("final list tahsil is here ");
    print(_tahsil.toString());
    setState(() {
      _selectedTahsil = _tahsil[0];
      _tahsil;
    });
  }

  _loadCouncil(String city, String thsil) async {
    Map cityMap = await LocalDatabase.getCitiesAndRegons();
    _councils.clear();
    cityMap.forEach((key, value) {
      //city loop
      if (key == city) {
        Map tahsil_map = value;
        tahsil_map.forEach((key, value_c) {
          //tahsil loop
          if (key == thsil) {
            print("selected tahsil is here ");
            print(key);
            Map counsilMap = value_c;
            counsilMap.forEach((key, value) {
              print("list councils is above ");
              print(value.toString());
              _councils.add(key);
            });
          }
        });
      }
    });
    print("final list councils is here ");
    print(_councils.toString());
    setState(() {
      _selectedConsil = _councils[0];
      _councils;
    });
  }

  _loadDoses() async {
    Map doseMap = await LocalDatabase.getDoseAndVaccines();
    _dose.clear();
    doseMap.forEach((key, value) {
      _dose.add(key);
    });
    setState(() {
      _dose;
    });
  }

  _loadVaccines(String dose) async {
    Map vaccinesMap = await LocalDatabase.getDoseAndVaccines();
    //_vaccine.clear();
    list_of_vaccinations.clear();
    vaccinesMap.forEach((key, value) {
      if (key == dose) {
        Map vaccine_map = value;
        vaccine_map.forEach((key, value) {
          //_vaccine.add(key);
          list_of_vaccinations
              .add(VaccinationDoseForRegular(key, FirebaseCalls.user.uid, false));
        });
        setState(() {
          list_of_vaccinations;
        });
        print('selected dose...');
        print(list_of_vaccinations[0].vaccination_name);
        print(list_of_vaccinations[1].vaccination_name);
      }
    });
    /*setState(() {
      _vaccine;
      _selectedVaccine = _vaccine[0];
    });*/
  }
}

void showtoas(String s) {
  Fluttertoast.showToast(
      msg: s.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: MyColors.color_red,
      textColor: MyColors.color_white,
      fontSize: 16.0);
}
