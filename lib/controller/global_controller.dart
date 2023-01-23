import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/api/fetch_weather.dart';
import '../model/weather_data.dart';

class GlobalController extends GetxController {
  // create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  // instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // return if services is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    // getting the current postion
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then(
      (value) {
        // update our latitude and longitude
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;

        // calling our weather api
        return FetchWeatherAPI()
            .processData(value.latitude, value.longitude)
            .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
        });

        // print(_latitude.value);
        // print(_longitude.value);
      },
    );
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
