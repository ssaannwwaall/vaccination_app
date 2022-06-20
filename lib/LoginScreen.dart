import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_app/Helper/ConstentStrings.dart';
import 'package:vaccination_app/Helper/FirebaseCall.dart';
import 'package:vaccination_app/Helper/MyColors.dart';
import 'package:vaccination_app/Helper/SharefPrefsCurrentUser.dart';
import 'package:vaccination_app/Helper/custom_validator.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/Interfaces/ResponceInterface.dart';
import 'package:vaccination_app/Widget/CustomToast.dart';
import 'package:vaccination_app/Widget/MyButton.dart';
import 'package:vaccination_app/Widget/MyTextFiled.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vaccination_app/Models/VaccinatorUser.dart';
import 'package:vaccination_app/Helper/Helper.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller_email = new TextEditingController();
  TextEditingController controller_password = new TextEditingController();
  String _button_text = ConstentStrings.login;
  String _textRegister = ConstentStrings.havntAccount;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var _hight = mediaQueryData.size.height;
    var _width = mediaQueryData.size.width;
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage("assets/images/bgg.jpg"),
            colorFilter:
            ColorFilter.mode(Colors.black,
                BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        //color: MyColors.color_white,
        height: _hight,
        width: _width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: _hight * .15,
              width: _width * .5,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Login User',
                style: TextStyle(
                    color: MyColors.color_black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: MyTextFiled(_width, 'example@gmail.com',
                  TextInputType.emailAddress, controller_email),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: MyTextFiled(_width, 'Password',
                  TextInputType.visiblePassword, controller_password),
            ),
            MyButton(_button_text, MyColors.color_blue, _width * 0.7,
                _loginRegisBtnPressed
                //() async {
                //bool connected = await Helper.isInternetAvailble();
                //   if (connected) {
                //     _loginRegisBtnPressed;
                //   } else {
                //     Fluttertoast.showToast(
                //         msg: "Internet required to perform this operation",
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.BOTTOM,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor: MyColors.color_gray,
                //         textColor: MyColors.color_white,
                //         fontSize: 16.0);
                //   }
                // }
                ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _textRegister,
                  style: const TextStyle(
                      color: MyColors.color_black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              onTap: () {
                if (_button_text == ConstentStrings.login) {
                  setState(() {
                    _button_text = ConstentStrings.register;
                    _textRegister = ConstentStrings.haveAccount;
                  });
                } else {
                  setState(() {
                    _button_text = ConstentStrings.login;
                    _textRegister = ConstentStrings.havntAccount;
                  });
                }
              },
            ),
          ]),
        ),
      ),
    );
  }

  void _loginRegisBtnPressed() async {
    print('button pressed...');
    String? validateEmail =
        CustomValidator().validateEmail(controller_email.text.toString());
    String? validatePassword = CustomValidator()
        .validatePasswordLength(controller_password.text.toString());

    if (validateEmail != null) {
      Fluttertoast.showToast(
          msg: validateEmail.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: MyColors.color_red,
          textColor: MyColors.color_white,
          fontSize: 16.0);
    } else if (validatePassword != null) {
      Fluttertoast.showToast(
          msg: validatePassword.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: MyColors.color_red,
          textColor: MyColors.color_white,
          fontSize: 16.0);
    } else {
      bool connected = await Helper.isInternetAvailble();
      if (connected) {
        if (_button_text == ConstentStrings.login) {
          //login user
          FirebaseCalls.signIn(
                  email: controller_email.text.trim(),
                  password: controller_password.text.trim())
              .then((result) => {
                    if (result == null)
                      {
                        //signin successfull
                        print('login successful'),
                        Fluttertoast.showToast(
                            msg: "Login successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColors.color_gray,
                            textColor: MyColors.color_white,
                            fontSize: 16.0),
                        //get datafrom firebase and save in sharedpreference

                        Navigator.of(context).pushNamed(HomeScreen.routeName),
                      }
                    else
                      {
                        Fluttertoast.showToast(
                            msg: "Login failed : $result",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColors.color_red,
                            textColor: MyColors.color_white,
                            fontSize: 16.0),
                        print('login failed due to $result')
                      }
                  });
        } else {
          //register user
          FirebaseCalls.signUp(
                  email: controller_email.text.trim(),
                  password: controller_password.text.trim())
              .then((result) => {
                    if (result == null)
                      {
                        //sign-up successful
                        FirebaseCalls.setUser(
                                vaccinatorUser: VaccinatorUser(
                                    controller_email.text.toString(),
                                    controller_password.text.toString(),
                                    controller_email.text.toString()))
                            .then((result) => {
                                  if (result == null)
                                    {
                                      //uploaded successfully
                                      print("sign-up successful"),
                                      Fluttertoast.showToast(
                                          msg: "sign-up successful",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: MyColors.color_gray,
                                          textColor: MyColors.color_white,
                                          fontSize: 16.0),

                                      Navigator.of(context)
                                          .pushNamed(HomeScreen.routeName),
                                    }
                                  else
                                    {
                                      Fluttertoast.showToast(
                                          msg: "sign-up failed : $result",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: MyColors.color_red,
                                          textColor: MyColors.color_white,
                                          fontSize: 16.0),
                                      print("sign-up failed due to11 $result"),
                                    }
                                }),
                      }
                    else
                      {
                        print("sign-up failed due to $result"),
                        Fluttertoast.showToast(
                            msg: "sign-up failed : $result",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColors.color_red,
                            textColor: MyColors.color_white,
                            fontSize: 16.0),
                      }
                  });
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Check your internet connection',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyColors.color_red,
            textColor: MyColors.color_white,
            fontSize: 16.0);
      }
    }
  }
}
