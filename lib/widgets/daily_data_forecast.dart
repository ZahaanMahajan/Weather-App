// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/custom_colors.dart';
import '../model/weather_data_daily.dart';

class DailyDataForcast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForcast({
    super.key,
    required this.weatherDataDaily,
  });

  // String manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat("EEE").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Next Days",
              style: TextStyle(
                color: CustomColors.textColorBlack,
                fontSize: 18,
              ),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: TextStyle(
                          color: CustomColors.textColorBlack,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                          "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                    ),
                    Text("${weatherDataDaily.daily[index].temp!.max}° "
                        "/ ${weatherDataDaily.daily[index].temp!.min}°"),
                  ],
                ),
              ),
              Container(
                color: CustomColors.dividerLine,
                height: 1,
              )
            ],
          );
        },
      ),
    );
  }
}
