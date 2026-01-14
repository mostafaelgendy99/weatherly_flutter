import 'package:weatherly_flutter/core/errors/failures.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import'package:dartz/dartz.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';

abstract class WeatherRepository  {
  Future<Either<Failure, CurrentWeather>> getCurrentWeather (double long , double lat);
  Future<Either<Failure , WeatherForecast>> getWeatherForecast(double long , double lat);
  
}