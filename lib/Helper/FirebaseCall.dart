import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vaccination_app/Helper/ConstentStrings.dart';
import 'package:vaccination_app/Helper/LocalDatabase.dart';
import 'package:vaccination_app/Interfaces/ResponceInterface.dart';
import 'package:vaccination_app/Models/NewlyBorn.dart';
import 'package:vaccination_app/Models/VaccinationRecord.dart';
import 'package:vaccination_app/Models/VaccinatorUser.dart';

import '../Models/NewRegisteration.dart';

class FirebaseCalls {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static get user => _auth.currentUser;
  static DatabaseReference ref_user = FirebaseDatabase.instance.ref('Users');
  static DatabaseReference ref_cities =
      FirebaseDatabase.instance.ref('citiesAndSubAreas');
  static DatabaseReference ref_vaccines =
      FirebaseDatabase.instance.ref('vaccinations');
  static DatabaseReference ref_newly_born =
      FirebaseDatabase.instance.ref('NewlyBorn');
  static DatabaseReference ref_regis_kids =
      FirebaseDatabase.instance.ref('RegisteredKids');
  static DatabaseReference ref_vaccination_recored =
      FirebaseDatabase.instance.ref('VaccinationRecord');
  static final FirebaseStorage firebaseStorage_pics = FirebaseStorage.instance;

  // AUTH SIGN UP METHOD
  static Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // AUTH SIGN IN METHOD
  static Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //AUTH SIGN OUT METHOD
  static Future signOut() async {
    await _auth.signOut();
    print('signout');
  }

  static Future setUser({required VaccinatorUser vaccinatorUser}) async {
    try {
      vaccinatorUser.uid = user.uid;
      await ref_user.child(vaccinatorUser.uid).set(vaccinatorUser.getMapOf());
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future uploadPicture(
      String subFolder, String phone, String url) async {
    try {
      final path = '$subFolder/$phone.jpg';
      final file = File(url);
      UploadTask uploadTask = firebaseStorage_pics.ref(path).putFile(file);
      final snapchat = await uploadTask.whenComplete(() => {});
      String download_url = await snapchat.ref.getDownloadURL();
      print('download url   $download_url');
      return download_url;
    } catch (e) {
      print('exception is here while uploading picture........$e');
      return null;
    }
  }

  static Future setNewlyBorn({required NewlyBorn newlyBorn}) async {
    try {
      newlyBorn.key = ref_newly_born.push().key!;
      await ref_newly_born.child(newlyBorn.key).set(newlyBorn.getMapOf());
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future setNewRegistration(
      {required NewRegisterationModel newReg}) async {
    try {
      if (newReg.key == null) {
        newReg.key = ref_newly_born.push().key!;
      }
      await ref_regis_kids.child(newReg.key).set(newReg.getMapOf());
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future setVaccinationRecord(
      {required VaccinationRecord record}) async {
    try {
      record.key = ref_vaccination_recored.push().key!;
      await ref_vaccination_recored
          //.child(record.vaccinator_uid!)
          .child(record.kid_key!)
          .child(record.key)
          .set(record.getMapOf());
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future getCitiesAndRegions() async {
    //List<String>? list;
    await ref_cities.keepSynced(false);
    final snapshot = await ref_cities.once();
    ref_cities.onValue.listen((DatabaseEvent value) async {
      Map data = (value.snapshot.value as Map);
      print('city test $data');
      await LocalDatabase.saveCitiesAndRegons(data).then((result) => {
            if (result == null)
              {
                //error
                print('Cities cannot added in local database'),
              }
            else
              {
                print('cities added successfully'),
              }
          });
      // data.forEach((key, value2) {
      //   print('key is here, its city name');
      //   list?.add(key);
      //   print(key);
      //   //print(value2);
      // });
    });
    return null;
  }

  static Future getAllVaccines() async {
    //await ref_cities.keepSynced(false);
    final snapshot = await ref_vaccines.once();
    ref_vaccines.onValue.listen((DatabaseEvent value) async {
      Map data = (value.snapshot.value as Map);
      print('vaccines test $data');
      await LocalDatabase.saveDoseAndVaccines(data).then((result) => {
            if (result == null)
              {
                //error
                print('Vaccines cannot added in local database'),
              }
            else
              {
                print('Vaccines added successfully'),
              }
          });
    });
    return null;
  }

  static Future getAllUpcoming() async {
    ref_regis_kids.once();
    ref_regis_kids.onValue.listen((value) {
      Map data = (value.snapshot.value as Map);
      print('all kids');
      print(data.toString());
      LocalDatabase.saveAllKids(data);
    });
    //if (who == ConstentStrings.upcoming) {}
    return null;
  }
}
