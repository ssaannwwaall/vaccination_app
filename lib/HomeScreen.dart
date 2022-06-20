import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_app/NewBirthChildScreen.dart';
import 'package:vaccination_app/NewRegisterationScreen.dart';
import 'package:vaccination_app/RefusalScreen.dart';
import 'package:vaccination_app/UpcomingScreen.dart';
import 'package:vaccination_app/Widget/CardHome.dart';
import 'package:vaccination_app/Widget/MyButton.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/defaulterScreen.dart';
import 'Helper/Helper.dart';
import 'Helper/MyColors.dart';
import 'Helper/SharefPrefsCurrentUser.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: _width,
        height: _hight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //home title
            Container(
              color: MyColors.splash,
              height: _hight * .07,
              width: _width,
              child: const Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 20,
                      color: MyColors.color_white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: _hight * .7,
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //first row
                  Container(
                    height: _hight * 0.2,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          child: CardHome(
                              _hight * 0.1,
                              _width * 0.45,
                              'Vaccination status',
                              MyColors.Dashboard,
                              'assets/images/graph1.svg'),
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushNamed(NewBirthChildScreen.routeName);
                          },
                        ),
                        GestureDetector(
                          child: CardHome(
                              _hight * 0.1,
                              _width * 0.45,
                              'Newly born',
                              MyColors.Newly_Born,
                              'assets/images/baby1.svg'),
                          onTap: () async {
                            await Helper.determineCurrentPosition();
                            print('locaton is here... ');
                            print(Helper.currentPositon.latitude);
                            Navigator.of(context)
                                .pushNamed(NewBirthChildScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: _hight * 0.2,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          child: CardHome(
                              _hight * 0.1,
                              _width * 0.45,
                              'New Registration',
                              MyColors.New_Register,
                              'assets/images/injection1.svg'),
                          onTap: () async {
                            await Helper.determineCurrentPosition();
                            print('locaton is here... ');
                            print(Helper.currentPositon.latitude);
                            Navigator.of(context)
                                .pushNamed(NewRegisterationScreen.routeName);
                          },
                        ),
                        GestureDetector(
                          child: CardHome(
                              _hight * 0.1,
                              _width * 0.45,
                              'Follow-up kids',
                              MyColors.Fllow_up,
                              'assets/images/injections1.svg'),
                          onTap: () {
                            Navigator.pushNamed(
                                context, UpcomingScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: _hight * 0.2,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          child: CardHome(
                              _hight * 0.1,
                              _width * 0.45,
                              'Refusals',
                              MyColors.Refusals,
                              'assets/images/bulb_icon1.svg'),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RefusalScreen.routeName);
                          },
                        ),
                        GestureDetector(
                          child: CardHome(
                            _hight * 0.1,
                            _width * 0.45,
                            'Defaulters',
                            MyColors.Defaulters,
                            'assets/images/heart_broken1.svg',
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(DefaulterScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: _hight * 0.15,
              width: _width,
              child: GestureDetector(
                child: const Card(
                  color: MyColors.splash,
                  child: Center(
                    child: Text(
                      'Click to Upload Pendding Data',
                      style: TextStyle(
                          color: MyColors.color_white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                onTap: () {
                  Feedback.forTap(context);
                  print('pendding... data uploading');
                },
              ),
              // CardHome(_hight * 0.1, _width * 0.5, 'Newly born',
              //     MyColors.color_blue_light, ''),
            ),
            // MyButton('loutout', _width * 0.5, () {
            //   //FirebaseCalls.signOut();
            //   SharedPrefsCurrentUser.saveUserName("sanwal").then((result) => {
            //     if (result == null)
            //       {
            //         //error
            //         Fluttertoast.showToast(
            //             msg: "something went wrong",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.BOTTOM,
            //             timeInSecForIosWeb: 1,
            //             backgroundColor: MyColors.color_gray,
            //             textColor: MyColors.color_white,
            //             fontSize: 16.0),
            //       }
            //     else
            //       {
            //         if (result)
            //           {
            //             //saved successfully
            //             SharedPrefsCurrentUser.getUserName()
            //                 .then((result) => {
            //               Fluttertoast.showToast(
            //                   msg: "retrived successful $result",
            //                   toastLength: Toast.LENGTH_SHORT,
            //                   gravity: ToastGravity.BOTTOM,
            //                   timeInSecForIosWeb: 1,
            //                   backgroundColor:
            //                   MyColors.color_gray,
            //                   textColor: MyColors.color_white,
            //                   fontSize: 16.0),
            //             }),
            //           }
            //       }
            //   });
            // }),
          ],
        ),
      )),
    );
  }
}
