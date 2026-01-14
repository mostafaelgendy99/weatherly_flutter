import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';



class WeatherForecastModel extends WeatherForecast {
   WeatherForecastModel({
    required String cityName,
    required String country,
    required List<ForecastItem> items,
  }) : super(
          cityName: cityName,
          country: country,
          items: items,
        );

  /// FROM JSON (API → Model)
  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      cityName: json['city']['name'],
      country: json['city']['country'],
      items: (json['list'] as List)
          .map(
            (item) => ForecastItem(
              dateTime: DateTime.fromMillisecondsSinceEpoch(
                item['dt'] * 1000,
              ),
              temperature: (item['main']['temp'] as num).toDouble(),
              feelsLike: (item['main']['feels_like'] as num).toDouble(),
              minTemp: (item['main']['temp_min'] as num).toDouble(),
              maxTemp: (item['main']['temp_max'] as num).toDouble(),
              humidity: item['main']['humidity'],
              pressure: item['main']['pressure'],
              weatherMain: item['weather'][0]['main'],
              weatherDescription: item['weather'][0]['description'],
              weatherIcon: item['weather'][0]['icon'],
              windSpeed: (item['wind']['speed'] as num).toDouble(),
              windDegree: item['wind']['deg'],
              visibility: item['visibility'] ?? 0,
              precipitationProbability:
                  (item['pop'] as num?)?.toDouble() ?? 0.0,
            ),
          )
          .toList(),
    );
  }

  /// TO JSON (for local cache)
  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'items': items.map(_forecastItemToJson).toList(),
    };
  }

  Map<String, dynamic> _forecastItemToJson(ForecastItem item) {
    return {
      'dateTime': item.dateTime.toIso8601String(),
      'temperature': item.temperature,
      'feelsLike': item.feelsLike,
      'minTemp': item.minTemp,
      'maxTemp': item.maxTemp,
      'humidity': item.humidity,
      'pressure': item.pressure,
      'weatherMain': item.weatherMain,
      'weatherDescription': item.weatherDescription,
      'weatherIcon': item.weatherIcon,
      'windSpeed': item.windSpeed,
      'windDegree': item.windDegree,
      'visibility': item.visibility,
      'precipitationProbability': item.precipitationProbability,
    };
  }
}