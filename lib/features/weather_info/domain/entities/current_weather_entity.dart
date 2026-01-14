import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final String cityName;
  final String country;

  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final int pressure;

  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  final double windSpeed;
  final int windDegree;

  final int visibility;
  final DateTime dateTime;

  CurrentWeather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.windDegree,
    required this.visibility,
    required this.dateTime,
  });

  
  @override
  List<Object?> get props => [
        cityName,
        country,
        temperature,
        feelsLike,
        minTemp,
        maxTemp,
        humidity,
        pressure,
        weatherMain,
        weatherDescription,
        weatherIcon,
        windSpeed,
        windDegree,
        visibility,
        dateTime,
      ];
}