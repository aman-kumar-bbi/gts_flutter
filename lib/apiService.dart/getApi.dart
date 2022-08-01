import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;



class ApiServices {
  
  Future<List> getAllData() async {
    const url =
        "https://s3.amazonaws.com/bb.english.applications/APP-SERVER-UPDATE-TRAINING/ASHISH/build_training/gts.json";
    List ApiData=[];
    try {
       final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        ApiData = json.decode(response.body);

        return ApiData;
      } else {
        print("Something Went Wrong");
        return ApiData;
      }
    } catch (e) {
      print(e);
      return ApiData;
    }
  }
}
