import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_app/CustomVaccinationScreen.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Helper/SharefPrefsCurrentUser.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/LoginScreen.dart';
import 'package:vaccination_app/Models/NewRegisteration.dart';
import 'package:vaccination_app/Models/NewlyBorn.dart';
import 'package:vaccination_app/NewBirthChildScreen.dart';
import 'package:vaccination_app/NewRegisterationScreen.dart';
import 'package:vaccination_app/ReportCasesScreen.dart';
import 'package:vaccination_app/VaccineToRegisKids.dart';

import 'Helper/Helper.dart';
import 'RefusalScreen.dart';
import 'UpcomingScreen.dart';

class NavHomeScreen extends StatefulWidget {
  static const routeName = "/NavHomeScreen";

  const NavHomeScreen({Key? key}) : super(key: key);

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  // final screens = [
  //   HomeScreen(),
  //   ReportCasesScreen(),
  //   CustomVaccinationScreen()
  // ];
  //int currentScreen = 0;
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
              child: HomeScreen(),
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
          UserAccountsDrawerHeader(
            accountEmail: Text(
              '${FirebaseCalls.user.email}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            accountName: const Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            currentAccountPicture: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: MyColors.splash,
            ),
          ),
          // const DrawerHeader(
          //   child: Text(FirebaseCalls.user.email , ),
          // ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavHomeScreen()));
            },
            child: const ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportCasesScreen()));
            },
            // onTap: () async {
            //   await Helper.determineCurrentPosition();
            //   setState(() {
            //     //currentScreen = 1;
            //     Navigator.of(context).pushNamed(ReportCasesScreen.routeName);
            //   });
            //   Navigator.pop(context, true);
            // },
            child: const ListTile(
              title: Text(
                'Repoet Cases',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.report,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomVaccinationScreen()));
            },
            // onTap: () async {
            //   //await Helper.determineCurrentPosition();
            //   setState(() {
            //     //currentScreen = 2;
            //   });
            //   Navigator.pop(context, true);
            // },
            child: const ListTile(
              title: Text(
                'Custom Vaccine Dose',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.vaccines,
                color: Colors.black,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewBirthChildScreen()));
            },
            child: const ListTile(
              title: Text(
                'Newly Born',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.baby_changing_station,
                color: Colors.black,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewRegisterationScreen()));
            },
            child: const ListTile(
              title: Text(
                'New Registration',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.app_registration,
                color: Colors.black,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpcomingScreen()));
            },
            child: const ListTile(
              title: Text(
                'Follow-Up Kids',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.follow_the_signs_sharp,
                color: Colors.black,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RefusalScreen()));
            },
            child: const ListTile(
              title: Text(
                'Refusals',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.radar,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 30,
            thickness: 0.5,
            color: Colors.black.withOpacity(0.3),
            indent: 35,
            endIndent: 35,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: InkWell(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => new Login()));
              // },
              child: ListTile(
                title: Text(
                  'All Right Reserved by RISI',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),

          // ListTile(
          //   title: const Text('Home'),
          //   onTap: () {
          //     setState(() {
          //       currentScreen = 0;
          //     });
          //     Navigator.pop(context, true);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Report cases'),
          //   onTap: () async {
          //     await Helper.determineCurrentPosition();
          //     setState(() {
          //       currentScreen = 1;
          //     });
          //     Navigator.pop(context, true);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Custom vaccine dose'),
          //   onTap: () async {
          //     await Helper.determineCurrentPosition();
          //     setState(() {
          //       currentScreen = 2;
          //     });
          //     Navigator.pop(context, true);
          //   },
          // ),

          // ListTile(
          //   title: const Text('Logout'),
          //   onTap: () {
          //     //FirebaseAuth.instance.signOut();
          //     //Navigator.of(context).pushNamed(LoginScreen.routeName);
          //     print('logout');
          //   },
          // ),
        ],
      )),
    );
  }
}
