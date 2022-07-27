import 'dart:convert';

import 'package:http/http.dart' as http;



class ApiServices {
  Future<void> getAllData() async {
    const url =
        "https://s3.amazonaws.com/bb.english.applications/APP-SERVER-UPDATE-TRAINING/ASHISH/build_training/gts.json";
    var ApiData;
    try {
       final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        ApiData = json.decode(response.body);

        return ApiData;
      } else {
        print("Something Went Wrong");
      }
    } catch (e) {
      print(e);
    }
  }
}
