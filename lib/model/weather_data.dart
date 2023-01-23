// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather/model/weather_data_current.dart';
import 'package:weather/model/weather_data_daily.dart';
import 'package:weather/model/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([
    this.current,
    this.hourly,
    this.daily,
  ]);

  // funtion to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
