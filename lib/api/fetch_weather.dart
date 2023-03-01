import 'dart:convert';
import 'package:weather/model/weather_daily_data.dart';
import 'package:weather/model/weather_data.dart';
import 'package:http/http.dart' as http;
import '../model/weather_hourly_data.dart';
import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, long) async {
    var response = await http.get(Uri.parse(apiURL(lat, long)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );
    return weatherData!;
  }
}
