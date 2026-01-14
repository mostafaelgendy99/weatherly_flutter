import 'package:dartz/dartz.dart';
import 'package:weatherly_flutter/core/errors/failures.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, CurrentWeather>> call({
    required double lat,
    required double lon,
  }) async{
    return repository.getCurrentWeather(lat, lon);
  }
}
