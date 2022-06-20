import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Helper/custom_validator.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/Models/NewlyBorn.dart';
import 'package:vaccination_app/Widget/MyButton.dart';
import 'package:vaccination_app/Widget/MyTextFiled.dart';
import 'package:vaccination_app/main.dart';
import 'package:file_picker/file_picker.dart';
import 'Helper/Helper.dart';
import 'Helper/MyColors.dart';
import 'package:geolocator/geolocator.dart';

import 'NavHomeScreen.dart';

class NewBirthChildScreen extends StatefulWidget {
  static const String routeName = '/NewBirthChildScreen';

  const NewBirthChildScreen({Key? key}) : super(key: key);

  @override
  State<NewBirthChildScreen> createState() => _NewBirthChildScreenState();
}

class _NewBirthChildScreenState extends State<NewBirthChildScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerFName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEpiCardNo = TextEditingController();

  //gender
  //final TextEditingController _controllerDateOfBirth = TextEditingController();

  //final TextEditingController _controllerCity = TextEditingController();
  //final TextEditingController _controllerTahsil = TextEditingController();
  //final TextEditingController _controllerUnionCouncil = TextEditingController();

  //final TextEditingController _controllerCurrentDate = TextEditingController();
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

  String? _selectedCity;
  String? _selectedTahsil;
  String? _selectedConsil;

  DateTime dob = DateTime.now();
  Color screeThemeColor = MyColors.Newly_Born;

  @override
  void initState() {
    // TODO: implement initState
    _loadCities();
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
        appBar: AppBar(
          actions: [],
          backgroundColor: screeThemeColor,
          title: const Text(
            'Add Newly Born Child',
            style: TextStyle(
                fontSize: 20,
                color: MyColors.color_white,
                fontWeight: FontWeight.w500),
          ),
        ),
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
                        // Container(
                        //   color: screeThemeColor,
                        //   height: _hight * .07,
                        //   width: _width,
                        //   child: const Center(
                        //     child: Text(
                        //       'Add Newly Born Child',
                        //       style: TextStyle(
                        //           fontSize: 20,
                        //           color: MyColors.color_white,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ),
                        // ),
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
                                : Image.asset("assets/images/add-photo.png"),
                            //SvgPicture.asset('assets/images/camera.svg')
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                                                '   Child Name',
                                                TextInputType.name,
                                                _controllerName),
                                            MyTextFiled(
                                                _width * .47,
                                                '   Father Name',
                                                TextInputType.name,
                                                _controllerFName),
                                          ],
                                        ),
                                        MyTextFiled(
                                            _width * 0.95,
                                            '   Phone Number',
                                            TextInputType.name,
                                            _controllerPhone),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyTextFiled(
                                                _width * .47,
                                                '   Epi Card No',
                                                TextInputType.name,
                                                _controllerEpiCardNo),
                                            Container(
                                              width: _width * .47,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Card(
                                                color: Colors.blue,
                                                elevation: 2,
                                                child: TextButton(
                                                    onPressed: () async {
                                                      DateTime? date =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate: dob,
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(2100),
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
                                                            color: MyColors
                                                                .color_white,
                                                            fontSize: 14),
                                                      ),
                                                    )),
                                              ),
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
                                                    color:
                                                        MyColors.color_black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Center(
                                                  child: DropdownButton(
                                                    underline: const SizedBox(),
                                                    hint: const Text('   City'),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 205, 173, 171),
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
                                                        child:
                                                            Text(thislocation),
                                                        value: thislocation,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color:
                                                        MyColors.color_black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Center(
                                                  child: DropdownButton(
                                                      underline:
                                                          const SizedBox(),
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                width: .5,
                                                color: MyColors.color_black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: _width * .7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: DropdownButton(
                                                underline: const SizedBox(),
                                                hint: const Text(
                                                  'Union Council',
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
                                        // MyTextFiled(
                                        //     _width * 0.95,
                                        //     'Union council',
                                        //     TextInputType.name,
                                        //     _controllerUnionCouncil),

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
                                                activeColor: screeThemeColor,
                                                selected: true,
                                                title: const Text(
                                                  'Male',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 12,
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
                                                activeColor: screeThemeColor,
                                                selected: false,
                                                title: const Text(
                                                  'Female',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 12,
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
                                                activeColor: screeThemeColor,
                                                selected: false,
                                                title: const Text(
                                                  'Trans',
                                                  style: TextStyle(
                                                    color: MyColors.color_black,
                                                    fontSize: 12,
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
                              MyButton('Back', screeThemeColor, _width * .48,
                                  () {
                                print('back pressed');
                                Navigator.of(context)
                                    .pushNamed(NavHomeScreen.routeName);
                              }),
                              MyButton(
                                  'Add Child', screeThemeColor, _width * .48,
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
                                  var obj = NewlyBorn(
                                      gender,
                                      _controllerName.text.toString(),
                                      _controllerFName.text.toString(),
                                      //_controllerCity.text.toString(),
                                      _selectedCity!,
                                      dob.toString(),
                                      //_controllerTahsil.text.toString(),
                                      _selectedTahsil!,
                                      //_controllerUnionCouncil.text.toString(),
                                      _selectedConsil!,
                                      _controllerPhone.text.toString(),
                                      (Helper.currentPositon.latitude
                                          .toString()),
                                      (Helper.currentPositon.longitude
                                          .toString()),
                                      _controllerAddress.text.toString(),
                                      pic_url,
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(DateTime.now()));

                                  if (await Helper.isInternetAvailble()) {
                                    FirebaseCalls.setNewlyBorn(newlyBorn: obj)
                                        .then((value) => {
                                              if (value == null)
                                                {
                                                  showtoas(
                                                      'Added successfully'),
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
