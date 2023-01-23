import 'dart:convert';
import 'package:weather/model/weather_data_current.dart';
import 'package:weather/model/weather_data_daily.dart';
import 'package:weather/model/weather_data_hourly.dart';
import '../model/weather_data.dart';
import 'package:http/http.dart' as http;

import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // processing the data from response -> to join
  Future<WeatherData> processData(lat, lon) async {
    http.Response response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );
    return weatherData!;
  }
}




// 34.14919022866615
// 74.82202263783843