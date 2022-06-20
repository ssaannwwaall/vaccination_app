import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static const String _citiesAndRegions = 'citiesandregions';
  static const String _vaccinesAndDoes = 'vaccinesAndDoes';
  static const String _allKidsData = 'allKidsData';
  static const String _customVaccines = 'customVaccines';
  static const String _myReportingCases = 'myReportingCases';
  static const String _myNewBorn = 'myNewBorn';

  static Future saveCitiesAndRegons(Map regons) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_citiesAndRegions, json.encode(regons));
      return true;
    } catch (e) {
      print("cities and regions saving error $e.toString()");
      return null;
    }
  }

  static Future getCitiesAndRegons() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_citiesAndRegions);
      print(value);
      return json.decode(value!); // sending back as a map
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future saveDoseAndVaccines(Map vaccineMap) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_vaccinesAndDoes, json.encode(vaccineMap));
      return true;
    } catch (e) {
      print("Vaccines and does saving error $e.toString()");
      return null;
    }
  }

  static Future getDoseAndVaccines() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_vaccinesAndDoes);
      print(value);
      return json.decode(value!); // sending back as a map
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future saveAllKids(Map regons) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_allKidsData, json.encode(regons));
      return true;
    } catch (e) {
      print("all kids saving error $e.toString()");
      return null;
    }
  }

  static Future getAllKids() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_allKidsData);
      print(value);
      return json.decode(value!); // sending back as a map
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future saveCustomVaccines(Map customVaccines) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_customVaccines, json.encode(customVaccines));
      return true;
    } catch (e) {
      print("custom vaccines error $e.toString()");
      return null;
    }
  }

  static Future getCustomVaccines() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_customVaccines);
      return json.decode(value!); // sending back as a map
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future setMYReportingCases(String regons) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_myReportingCases, regons);
      return true;
    } catch (e) {
      print("all kids saving error $e.toString()");
      return null;
    }
  }

  static Future getMyReportingCases() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_myReportingCases);
      print('case from local    ');
      print(value);
      return value!; // sending back as a map
    } catch (e) {
      print('case from local  error   ');
      print(e.toString());
      return null;
    }
  }

  static Future setMYNewBorns(String regons) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_myNewBorn, regons);
      return true;
    } catch (e) {
      print("all kids saving error $e.toString()");
      return null;
    }
  }

  static Future getMyNewBorns() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_myNewBorn);
      print(value);
      return value!; // sending back as a map
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
