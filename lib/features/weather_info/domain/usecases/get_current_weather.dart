import 'package:dartz/dartz.dart';
import 'package:weatherly_flutter/core/errors/failures.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart.dart';
import 'package:weatherly_flutter/features/weather_info/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather({required this.repository});

  Future<Either<Failure, CurrentWeather>> call({
    required int long,
    required int lat,
  }) async {
    return await repository.getCurrentWeather(long, lat);
  }
}
