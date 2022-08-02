import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  bool? boolValue;
  List apiData = [];
  bool? oneTimeOnly;
  Future<List<dynamic>> getAllData() async {
    if (await getBoolFromPreferenceForFirstTime() == null) {
      onlyReadJson();
      await setBoolInPreferenceForOneTimeOnly();
      if (await checkInternet()) {
        return tryFunction();
      } else {
        return GetOfflineJson();
      }
    } else {
      if (await checkInternet()) {
        return tryFunction();
      } else {
        return getUpdatedData();
      }
    }
  }

  Future<bool> checkInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

  onlyReadJson() async {
    var box = Hive.box("dataFromJson");
    final String response = await rootBundle.loadString('assets/gts.json');
    var offlinedata = await json.decode(response);
    box.put('hardCodedJsonData', offlinedata);
  }

  Future<List<dynamic>> GetOfflineJson() async {
    var box = Hive.box("dataFromJson");
    var jsonData = box.get('hardCodedJsonData');
    return jsonData;
  }

  UpdateDataBase(var ApiData) async {
    var box = Hive.box("dataFromJson");
    await box.put('hardCodedJsonData', ApiData);
    // var jsonData = box.get('hardCodedJsonData');
    // return jsonData;
  }

  List<dynamic> getUpdatedData() {
    var box = Hive.box("dataFromJson");
    var jsonData = box.get('hardCodedJsonData');
    return jsonData;
  }

  void setBoolInPreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("jsonDb", false);
  }

  Future<bool?> getBoolFromPreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    boolValue = _prefs.getBool("jsonDb");
    
    return boolValue;
  }

  void UpdateBoolInPreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("jsonDb", true);
  }

  Future<void> setBoolInPreferenceForOneTimeOnly() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs
        .setBool("checkForOneTimeOnly", false)
        ;
  }

  Future<bool?> getBoolFromPreferenceForFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    oneTimeOnly = _prefs.getBool("checkForOneTimeOnly");
    return oneTimeOnly;
  }

  Future<List<dynamic>> tryFunction() async {
    try {
      const url =
          "https://s3.amazonaws.com/bb.english.applications/APP-SERVER-UPDATE-TRAINING/ASHISH/build_training/gts.json";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        apiData = json.decode(response.body);
        // SharedPreferences _prefs = await SharedPreferences.getInstance();
        // await _prefs.setBool("jsonDb", true);
        UpdateBoolInPreference();
        UpdateDataBase(apiData);
        return apiData;
      } else {
        print("Something Went Wrong");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
