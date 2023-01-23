// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/utils/custom_colors.dart';
import 'package:weather/widgets/comfort_level.dart';
import 'package:weather/widgets/current_weather_widget.dart';
import 'package:weather/widgets/hourly_data_widget.dart';
import '../widgets/daily_data_forecast.dart';
import '../widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/clouds.png"),
                      SizedBox(height: 50),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SizedBox(height: 20),
                      HeaderWidget(),
                      // for our current temperature

                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      SizedBox(height: 20),

                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),

                      DailyDataForcast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      SizedBox(height: 10),
                      ComfortLevel(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
