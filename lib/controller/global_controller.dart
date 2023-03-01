import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/api/fetch_weather.dart';
import 'package:weather/model/weather_data.dart';
import 'package:weather/screens/location_denied_screen.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _latitude;
  RxDouble getLongtitude() => _longitude;

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

    // return if service is not enabled
    if (!isServiceEnabled) {
      Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.requestPermission();

    // status of permisson
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        return Get.off(const LocationDenied());
      }
      return Get.off(const LocationDenied());
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    ).then(
      (value) => {
        // update values when called getCurrentPosition
        _latitude.value = value.latitude,
        _longitude.value = value.longitude,

        // call our api
        FetchWeatherAPI()
            .processData(
              value.latitude,
              value.longitude,
            )
            .then(
              (value) => {
                weatherData.value = value,
                _isLoading.value = false,
              },
            ),
      },
    );
  }

  RxInt getIndex() => currentIndex;
}
