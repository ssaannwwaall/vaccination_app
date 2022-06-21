import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vaccination_app/Models/VaccinationRecord.dart';
import 'dart:io';
import 'Helper/FirebaseCall.dart';
import 'Helper/Helper.dart';
import 'Helper/LocalDatabase.dart';
import 'Helper/MyColors.dart';
import 'Helper/custom_validator.dart';
import 'HomeScreen.dart';
import 'Models/NewRegisteration.dart';
import 'NewRegisterationScreen.dart';
import 'Widget/MyButton.dart';
import 'Widget/MyTextFiled.dart';
import 'package:intl/intl.dart';

//String? _imgFilePicPath = null;
//String pic_url = '';

class CustomVaccinationScreen extends StatefulWidget {
  static const routeName = "/CustomVaccinationScreen";

  const CustomVaccinationScreen({Key? key}) : super(key: key);

  @override
  State<CustomVaccinationScreen> createState() =>
      _CustomVaccinationScreenState();
}

class _CustomVaccinationScreenState extends State<CustomVaccinationScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerFName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerLatLong = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  String lat = '33.6163723';
  String long = '72.8059114';
  Position? currentPosition;
  int _radioGroupValueGender = 0;

  PlatformFile? _filePicPicked;
  String pic_url = '';
  final List<String> _cities = ['City'];
  final List<String> _tahsil = ['Tahsil'];
  final List<String> _councils = ['Council'];

  List<String> _vaccine = [];
  String? _selectedCity;
  String? _selectedTahsil;
  String? _selectedConsil;

  //String? _selectedDose;

  String? _selectedVaccine;

  DateTime dob = DateTime.now();
  DateTime nextVaccinationDate = DateTime.now();
  Color screenThemeColor = MyColors.color_yellow_light;

  @override
  void initState() {
    // TODO: implement initState
    _loadCities();
    _loadCustomVaccines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPosition = Helper.currentPositon;
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
                              'Custom Vaccination',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MyColors.color_white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            /*final cameras = await availableCameras();
                            final firstCamera = cameras.first;
                            Feedback.forTap(context);
                            print('going to take camera...');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    TakePictureScreen(camera: firstCamera)));*/

                            _filePicPicked = await Helper.getPictureFromPhone();
                            //if (_filePicPicked != null) {
                            if (_filePicPicked != null) {
                              setState(() {
                                _filePicPicked;
                                print('file picked  $_filePicPicked');
                              });
                              if (await Helper.isInternetAvailble()) {
                                pic_url = await FirebaseCalls.uploadPicture(
                                    'newReg',
                                    _controllerPhone.text.toString(),
                                    _filePicPicked!.path!);
                              } else {
                                pic_url = _filePicPicked!.path!;
                              }
                              print('download url in screen is $pic_url');
                            } else {
                              //something went wrong
                              Fluttertoast.showToast(
                                  msg: "Image not found",
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
                                                'Patient name',
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
                                            'Mobile',
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
                                              child: const Text(
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
                                            // MyTextFiled(
                                            //     _width * .47,
                                            //     'Epi card no',
                                            //     TextInputType.name,
                                            //     _controllerEpiCardNo),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: screenThemeColor),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              width: _width * .9,
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
                                            Container(
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: screenThemeColor),
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
                                                        child:
                                                            Text(thislocation),
                                                        value: thislocation,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              width: _width * .47,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: screenThemeColor),
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
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          width: _width * .7,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                                width: .5,
                                                color: screenThemeColor),
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
                                            SizedBox(
                                              width: _width * .45,
                                              child: const Center(
                                                  child: Text(
                                                'Select vaccine',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              )),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              width: _width * .45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: .5,
                                                    color: screenThemeColor),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: DropdownButton(
                                                  underline: const SizedBox(),
                                                  //hint: const Text('Dose'),
                                                  value: _selectedVaccine,
                                                  onChanged: (newValue) async {
                                                    setState(() {
                                                      _selectedVaccine =
                                                          newValue.toString();
                                                    });
                                                  },
                                                  items: _vaccine
                                                      .map((thislocation) {
                                                    return DropdownMenuItem(
                                                      child: Text(thislocation),
                                                      value: thislocation,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                groupValue:
                                                    _radioGroupValueGender,
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
                                                      _radioGroupValueGender =
                                                          value as int);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.33,
                                              height: _hight * 0.06,
                                              child: RadioListTile(
                                                value: 1,
                                                groupValue:
                                                    _radioGroupValueGender,
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
                                                      _radioGroupValueGender =
                                                          value as int);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.33,
                                              height: _hight * 0.06,
                                              child: RadioListTile(
                                                value: 2,
                                                groupValue:
                                                    _radioGroupValueGender,
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
                                                      _radioGroupValueGender =
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
                        SizedBox(
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
                                  'Add Record', screenThemeColor, _width * .48,
                                  () async {
                                String? name = CustomValidator()
                                    .validateDescription(
                                        _controllerName.text.toString());
                                String? fname = CustomValidator()
                                    .validateDescription(
                                        _controllerFName.text.toString());
                                String? phone = CustomValidator()
                                    .validateMobile(
                                        _controllerPhone.text.toString());
                                String? city = CustomValidator()
                                    .validateDescription(_selectedCity);
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
                                if (_radioGroupValueGender == 0) {
                                  gender = 'Male';
                                } else if (_radioGroupValueGender == 1) {
                                  gender = 'Female';
                                } else if (_radioGroupValueGender == 2) {
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
                                      //
                                      _selectedConsil!,
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(DateTime.now())
                                          .toString(),
                                      gender.toString(),
                                      '',
                                      //nextvaccinationDate
                                      [],
                                      //list of vaccinations
                                      false,
                                      FirebaseCalls.user.uid);
                                  obj.vaccinaor_uid = FirebaseCalls.user.uid;
                                  obj.epi_card_no = _selectedVaccine!;

                                  if (await Helper.isInternetAvailble()) {
                                    FirebaseCalls.setCustomVaccinationRecord(
                                            newReg: obj)
                                        .then((value) => {
                                              if (value == null)
                                                {
                                                  showtoas(
                                                      'Custom vaccination record added successfully'),
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
    _cities.clear();
    cityMap.forEach((key, value) {
      _cities.add(key);
    });
    setState(() {
      _cities;
    });
  }

  _loadTahsil(String city) async {
    Map cityMap = await LocalDatabase.getCitiesAndRegons();
    _tahsil.clear();
    cityMap.forEach((key, value) {
      //city loop
      if (key == city) {
        Map tahsil_map = value;
        tahsil_map.forEach((key, value) {
          _tahsil.add(key);
        });
      }
    });
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
            Map counsilMap = value_c;
            counsilMap.forEach((key, value) {
              _councils.add(key);
            });
          }
        });
      }
    });
    setState(() {
      _selectedConsil = _councils[0];
      _councils;
    });
  }

  _loadCustomVaccines() async {
    Map doseMap = await LocalDatabase.getCustomVaccines();
    _vaccine.clear();
    doseMap.forEach((key, value) {
      _vaccine.add(key);
    });
    setState(() {
      _vaccine;
      _selectedVaccine = _vaccine[0];
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

/*class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return Container(
      width: _width,
      height: _hight,
      child: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                width: _width,
                child: Center(
                  child: FloatingActionButton(
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();
                        setState(() {
                          _imgFilePicPath = image.path;
                        });
                        if (_imgFilePicPath != null) {
                          if (await Helper.isInternetAvailble()) {
                            Random r = Random(0);
                            pic_url = await FirebaseCalls.uploadPicture(
                                'CustomVaccination',
                                r.nextInt(1000000).toString(),
                                _imgFilePicPath!);
                          } else {
                            pic_url = _imgFilePicPath!;
                          }
                          print('download url in screen is $pic_url');
                        } else {
                          Fluttertoast.showToast(
                              msg: "Image not found",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: MyColors.color_gray,
                              textColor: MyColors.color_white,
                              fontSize: 16.0);
                        }
                        Navigator.pop(context, true);
                        Navigator.of(context)
                            .pushNamed(CustomVaccinationScreen.routeName);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}*/
