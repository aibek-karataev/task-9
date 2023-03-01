import 'package:weather/model/weather_daily_data.dart';
import 'package:weather/model/weather_hourly_data.dart';

class WeatherData {
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  WeatherData([this.hourly, this.daily]);

  WeatherDataHourly getHourlyData() => hourly!;
  WeatherDataDaily getDailyData() => daily!;
}
