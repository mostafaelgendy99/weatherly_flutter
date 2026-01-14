import 'package:dartz/dartz.dart';
import 'package:weatherly_flutter/core/errors/failures.dart';
import 'package:weatherly_flutter/core/platform/network_info.dart';
import 'package:weatherly_flutter/features/weather_info/data/data_sources/weather_local_data_source.dart';
import 'package:weatherly_flutter/features/weather_info/data/data_sources/weather_remote_data_source.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      final weather = await remoteDataSource.getCurrentWeather(
        lat: lat,
        lon: lon,
      );
      return Right(weather);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherForecast(
    double lat,
    double lon,
  ) async {
    try {
      final forecast = await remoteDataSource.getWeatherForecast(
        lat: lat,
        lon: lon,
      );
      return Right(forecast);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

