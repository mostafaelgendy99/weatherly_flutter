import 'package:weatherly_flutter/features/weather_info/data/models/current_weather_model.dart';
import 'package:weatherly_flutter/features/weather_info/data/models/forecast_weather_model.dart' show WeatherForecastModel;

abstract class WeatherLocalDataSource {
  Future<void> cacheCurrentWeather(CurrentWeatherModel weather);
  Future<CurrentWeatherModel?> getCachedCurrentWeather();

  Future<void> cacheForecast(WeatherForecastModel forecast);
  Future<WeatherForecastModel?> getCachedForecast();
}
