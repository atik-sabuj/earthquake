import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'earthquake_response.dart';

class EarthquakeProvider extends ChangeNotifier {
  EarthquakeResponse? earthquakeResponse;

  bool get hasDataLoaded => earthquakeResponse != null;

  Future<void> getData({
    String startDate = '2022-11-20',
    String endDate = '2022-11-23',
    double magnitude = 5.0,
  }) async {
    final url = 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startDate&endtime=$endDate&minmagnitude=$magnitude';
    try {
      final response = await get(Uri.parse(url));
      final map = json.decode(response.body);
      if(response.statusCode == 200) {
        earthquakeResponse = EarthquakeResponse.fromJson(map);
        notifyListeners();
      } else {
        print(response.statusCode.toString());
      }
    } catch(error) {
      print(error.toString());
    }
  }
}
