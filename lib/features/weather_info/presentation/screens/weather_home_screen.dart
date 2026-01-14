import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly_flutter/features/weather_info/data/data_sources/weather_remote_data_source.dart';
import 'package:weatherly_flutter/features/weather_info/data/reposotories/weather_reposotiry_impl.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/current_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/entities/forecast_weather_entity.dart';
import 'package:weatherly_flutter/features/weather_info/domain/usecases/get_current_weather.dart';
import 'package:weatherly_flutter/features/weather_info/domain/usecases/get_forcast_weather.dart';
import 'package:weatherly_flutter/features/weather_info/presentation/cubit/weather_cubit.dart';
import 'package:weatherly_flutter/features/weather_info/presentation/cubit/weather_state.dart';
//import 'package:intl/intl.dart'; // For formatting date/time

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Create dependencies ONCE
      final httpClient = http.Client();

    final remoteDataSource = WeatherRemoteDataSourceImpl(httpClient);
    final repository = WeatherRepositoryImpl( remoteDataSource: remoteDataSource);
    final getCurrentWeather = GetCurrentWeather(repository);
    final getForecastWeather = GetForecastWeather( repository: repository);

    return BlocProvider(
      create: (_) => WeatherCubit(
        getCurrentWeather: getCurrentWeather,
        getForecastWeather: getForecastWeather,
      )..loadWeather(
          lat: 30.0444,
          lon: 31.2357,
        ),
      child: const _WeatherView(),
    );
  }
}

class _WeatherView extends StatelessWidget {
  const _WeatherView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return const Center(child: Text("Search for a city"));
            } else if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return WeatherContent(
                current: state.currentWeather,
                forecast: state.forecast,
              );
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}




class WeatherContent extends StatelessWidget {
  final CurrentWeather current;
  final WeatherForecast forecast;

  const WeatherContent({
    super.key,
    required this.current,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async =>  context.read<WeatherCubit>().loadWeather(
          lat: 30.0444,
          lon: 31.2357,
        ),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CurrentWeatherCard(weather: current),
            const SizedBox(height: 20),
            const AirQualityCard(), 
            const SizedBox(height: 20),
            ForecastHorizontalList(items: forecast.items),
          ],
        ),
      ),
    );
  }
}


class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 89, 87, 87),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Image.network(
              "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(height: 10),
            Text(
              "${weather.temperature.toStringAsFixed(1)}°",
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              weather.weatherDescription,
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AirQualityCard extends StatelessWidget {
  const AirQualityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        // Increase vertical padding to 40-50 to make the card taller
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Note: Increased icon size and spacing
            AirInfoItem(icon: Icons.air, label: "AQI", value: 42),
            AirInfoItem(icon: Icons.opacity, label: "PM2.5", value: 12),
            AirInfoItem(icon: Icons.wb_sunny_outlined, label: "UV", value: 4),
            AirInfoItem(icon: Icons.speed, label: "Pressure", value: 1012),
          ],
        ),
      ),
    );
  }
}

// Updated AirInfoItem for better scale
class AirInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const AirInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.cyanAccent,
          size: 40,
        ), // Increased from 28 to 40
        const SizedBox(height: 12), // More spacing
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ForecastHorizontalList extends StatelessWidget {
  final List<ForecastItem> items;

  const ForecastHorizontalList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ForecastItemCard(item: items[index]);
        },
      ),
    );
  }
}

class ForecastItemCard extends StatelessWidget {
  final ForecastItem item;

  const ForecastItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final date = item.dateTime;

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dayName(date), style: const TextStyle(color: Colors.white70)),
          Text(
            _formattedDate(date),
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
          Image.network(
            "https://openweathermap.org/img/wn/${item.weatherIcon}.png",
            width: 40,
          ),
          Text(
            "${item.temperature.toStringAsFixed(0)}°C",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _dayName(DateTime date) {
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

  String _formattedDate(DateTime date) {
    return "${date.day}/${date.month}";
  }
}
