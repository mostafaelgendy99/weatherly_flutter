import 'package:dartz/dartz.dart';
import 'package:weatherly_flutter/core/errors/failures.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/repositories/weather_repository.dart';

class GetForecastWeather {
  final WeatherRepository repository;

  GetForecastWeather({required this.repository});

  Future<Either<Failure, WeatherForecast>> call({
    required double lat,
    required double lon,
  }) async{
    return repository.getWeatherForecast(lat, lon);
  }

}