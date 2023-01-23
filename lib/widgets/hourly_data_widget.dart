// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/model/weather_data_hourly.dart';
import 'package:weather/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({
    super.key,
    required this.weatherDataHourly,
  });

  //card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  hourlyList() {
    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length < 12
            ? weatherDataHourly.hourly.length
            : 12,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: cardIndex.value == index
                        ? LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              CustomColors.dividerLine.withAlpha(150),
                              CustomColors.dividerLine.withAlpha(150),
                            ],
                          ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0),
                        blurRadius: 20,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withAlpha(150),
                      ),
                    ],
                  ),
                  child: HourlyDetails(
                    index: index,
                    cardIndex: cardIndex.value,
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    temp: weatherDataHourly.hourly[index].temp!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.index,
    required this.cardIndex,
    required this.weatherIcon,
  });

  int temp, timeStamp, index, cardIndex;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
              color: cardIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°C",
            style: TextStyle(
              color: cardIndex == index ? Colors.white : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
