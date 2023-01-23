// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";

  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    // print(placemark);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(
              fontSize: 35,
              height: 2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
