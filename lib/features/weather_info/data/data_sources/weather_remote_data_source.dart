import 'dart:convert';

import 'package:weatherly_flutter/features/weather_info/data/models/current_weather_model.dart';
import 'package:weatherly_flutter/features/weather_info/data/models/forecast_weather_model.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/usecases/get_current_weather.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly_flutter/core/config/api_config.dart';

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  });

  Future<WeatherForecastModel> getWeatherForecast({
    required double lat,
    required double lon,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<CurrentWeatherModel> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/weather'
      '?lat=$lat&lon=$lon'
      '&appid=${ApiConfig.apiKey}'
      '&units=metric',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<WeatherForecastModel> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/forecast'
      '?lat=$lat&lon=$lon'
      '&appid=${ApiConfig.apiKey}'
      '&units=metric',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Server error');
    }
  }
}
