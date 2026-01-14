import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';
import 'weather_state.dart';
import 'package:weatherly_flutter/features/weather_info/domain/usecases/get_current_weather.dart';
import 'package:weatherly_flutter/features/weather_info/domain/usecases/get_forcast_weather.dart';
import 'package:weatherly_flutter/core/errors/failures.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetForecastWeather getForecastWeather;

  WeatherCubit({
    required this.getCurrentWeather,
    required this.getForecastWeather,
  }) : super( WeatherInitial());

  Future<void> loadWeather({
    required double lat,
    required double lon,
  }) async {
    emit( WeatherLoading());

    try {
      // Call usecases
      final currentResult =
          await getCurrentWeather(lat: lat, lon: lon);
      final  forecastResult =
          await getForecastWeather(lat: lat, lon: lon);

      // Handle Either result
      currentResult.fold(
        (failure) => emit(WeatherError('Failed to load current weather: ${failure.toString()}')),
        (current) {
          forecastResult.fold(
            (failure) => emit(WeatherError('Failed to load forecast: ${failure.toString()}')),
            (forecast) => emit(
              WeatherLoaded(
                currentWeather: current,
                forecast: forecast,
              ),
            ),
          );
        },
      );
    } catch (e) {
      emit(WeatherError('Unexpected error: ${e.toString()}'));
    }
  }
}


