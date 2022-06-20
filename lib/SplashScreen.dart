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
      color: MyColors.color_ref_lightttt,
      height: _hight,
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _hight * .7,
            width: _width * .7,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
            ),
          ),
        ],
      ),
    );
  }
}



_loadCitiesAndRegonsAndVaccines() async {
  if (await Helper.isInternetAvailble()) {
    print('internet is available');
    await FirebaseCalls.getCitiesAndRegions();
    await FirebaseCalls.getAllVaccines();
    await FirebaseCalls.getAllUpcoming();
    await FirebaseCalls.getCustomVaccines();
  } else {
    print('internet not available');
  }
}
