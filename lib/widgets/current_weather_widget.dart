// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather/utils/custom_colors.dart';
import '../model/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget({
    super.key,
    required this.weatherDataCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // temperature area
        temperatureAreaWidget(),

        SizedBox(height: 30),
        // more details - windspeed, humidity, clouds
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weatherDataCurrent.current.temp!.toInt()}°",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: CustomColors.textColorBlack,
                  fontSize: 68,
                ),
              ),
              TextSpan(
                text: "${weatherDataCurrent.current.weather![0].description}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(18),
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              padding: EdgeInsets.all(18),
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              padding: EdgeInsets.all(18),
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 80,
              child: Text(
                "${weatherDataCurrent.current.windSpeed}km/h",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 80,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 80,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
