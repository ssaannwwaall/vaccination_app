import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/Helper.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'Helper/LocalDatabase.dart';
import 'LoginScreen.dart';
import 'NavHomeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/SplashScreen";

  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller?.forward();
    animation?.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // todo: check Internet Package with Google to access User Data
        //Navigator.of(context).pushNamed(LoginScreen.routeName);
        if (FirebaseCalls.user != null) {
          Navigator.of(context).pushNamed(NavHomeScreen.routeName);
        } else {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        }
      }
    });
    controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadCitiesAndRegonsAndVaccines();
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return Container(
      color: MyColors.splash,
      //color: const Color(0xff1b5baa),

      height: _hight,
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            //height: _hight * .5,
            height: animation?.value * _hight * .5,
            width: _width * .5,
            child: Image.asset(
              'assets/images/risi.png',
            ),
          ),
          const Center(
            child: Text(
              "Routine immunization \n Strengthening initiative",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

_loadCitiesAndRegonsAndVaccines() async {
  print('internet checking');
  if (await Helper.isInternetAvailble()) {
    print('internet is available');
    await FirebaseCalls.getCitiesAndRegions();
    await FirebaseCalls.getAllVaccines();
    await FirebaseCalls.getAllUpcoming();
    await FirebaseCalls.getCustomVaccines();

    await FirebaseCalls.getAllRegularVaccinators();
    await FirebaseCalls.getAllNewBorns();

    await FirebaseCalls.getAllMyCustomvacc();
    await FirebaseCalls.getAllNewReg();
  } else {
    print('internet not available');
  }
}
