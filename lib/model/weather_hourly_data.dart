class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
        hourly: List<Hourly>.from(
          json['hourly'].map((e) => Hourly.fromWeather(e)),
        ),
      );
}

class Hourly {
  int? dt;
  int? temp;
  int? clouds;
  double? uvi;
  int? humidity;
  double? feelsLike;
  double? windSpeed;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.uvi,
    this.temp,
    this.clouds,
    this.humidity,
    this.windSpeed,
    this.weather,
    this.feelsLike,
  });

  factory Hourly.fromWeather(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        clouds: json['clouds'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        uvi: (json['uvi'] as num?)?.toDouble(),
        temp: (json['temp'] as num?)?.round(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromWeather(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toWeather() => {
        'dt': dt,
        'temp': temp,
        'weather': weather?.map((e) => e.toWeather()).toList(),
      };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.description, this.icon, this.id, this.main});

  factory Weather.fromWeather(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toWeather() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
