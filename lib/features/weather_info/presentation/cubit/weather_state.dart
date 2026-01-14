import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final CurrentWeather currentWeather;
  final WeatherForecast forecast;

  WeatherLoaded({
    required this.currentWeather,
    required this.forecast,
  });
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
