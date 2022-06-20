import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_app/CustomVaccinationScreen.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/SharefPrefsCurrentUser.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/LoginScreen.dart';
import 'package:vaccination_app/ReportCasesScreen.dart';
import 'Helper/Helper.dart';

class NavHomeScreen extends StatefulWidget {
  static const routeName = "/NavHomeScreen";

  const NavHomeScreen({Key? key}) : super(key: key);

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final screens = [
    HomeScreen(),
    ReportCasesScreen(),
    CustomVaccinationScreen()
  ];
  int currentScreen = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Container(
              width: _width,
              height: _hight,
              child: screens[currentScreen],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.menu),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    print('open drawerer click');
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ],
            ),
          ],
        )),
      ),
      //screens[currentScreen],
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          // const DrawerHeader(
          //   child: Text(FirebaseCalls.user.email , ),
          // ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              setState(() {
                currentScreen = 0;
              });
              //Navigator.pop(context, true);
              _scaffoldKey.currentState!.closeDrawer();
            },
          ),
          ListTile(
            title: const Text('Report cases'),
            onTap: () async {
              await Helper.determineCurrentPosition();
              setState(() {
                currentScreen = 1;
              });
              //Navigator.pop(context, true);
              _scaffoldKey.currentState!.closeDrawer();
            },
          ),
          ListTile(
            title: const Text('Custom vaccine dose'),
            onTap: () async {
              await Helper.determineCurrentPosition();
              setState(() {
                currentScreen = 2;
              });
              //Navigator.pop(context, true);
              _scaffoldKey.currentState!.closeDrawer();
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context, true);
              Navigator.of(context).pushNamed(LoginScreen.routeName);
              print('logout');
            },
          ),
        ],
      )),
    );
  }
}
