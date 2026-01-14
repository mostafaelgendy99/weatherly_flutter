import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';


class CurrentWeatherModel extends CurrentWeather {
   CurrentWeatherModel({
    required String cityName,
    required String country,
    required double temperature,
    required double feelsLike,
    required double minTemp,
    required double maxTemp,
    required int humidity,
    required int pressure,
    required String weatherMain,
    required String weatherDescription,
    required String weatherIcon,
    required double windSpeed,
    required int windDegree,
    required int visibility,
    required DateTime dateTime,
  }) : super(
          cityName: cityName,
          country: country,
          temperature: temperature,
          feelsLike: feelsLike,
          minTemp: minTemp,
          maxTemp: maxTemp,
          humidity: humidity,
          pressure: pressure,
          weatherMain: weatherMain,
          weatherDescription: weatherDescription,
          weatherIcon: weatherIcon,
          windSpeed: windSpeed,
          windDegree: windDegree,
          visibility: visibility,
          dateTime: dateTime,
        );

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDegree: json['wind']['deg'],
      visibility: json['visibility'],
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'humidity': humidity,
      'pressure': pressure,
      'weatherMain': weatherMain,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'windSpeed': windSpeed,
      'windDegree': windDegree,
      'visibility': visibility,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}