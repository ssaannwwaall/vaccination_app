import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static const String _citiesAndRegions = 'citiesandregions';
  static const String _vaccinesAndDoes = 'vaccinesAndDoes';
  static const String _allKidsData = 'allKidsData';

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
}
