import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/domain/entities/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/presentation/bloc/weather_bloc.dart';
import 'package:weather_forecast/presentation/bloc/weather_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is! WeatherLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final weather = state.result;

        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                currentWeather(weather),
                const SizedBox(height: 25),
                houseImage(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF9D52AC).withValues(alpha: 0.7),
                        Color(0xFF6B3E9D).withValues(alpha: 0.86),
                        Color(0xFF3E2D8F).withValues(alpha: 1),
                      ],
                      stops: [0.0, 0.47, 1.0],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 19, left: 40, bottom: 12),
                            child: Text(
                              "Today",
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.47,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 19, right: 40, bottom: 12),
                            child: Text(
                              DateFormat('MMMM d').format(DateTime.now()),
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.47,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: Color(0xFF8E78C8),
                      ),
                      const SizedBox(height: 29),
                      Container(
                        height: 150,
                        alignment: Alignment.center,
                        child: ListView.separated(
                          itemCount: weather.hourlyForecasts.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 18),
                          itemBuilder: (context, index) {
                            final hourly = weather.hourlyForecasts[index];
                            return Column(
                              children: [
                                Text(
                                  "${hourly.temp.round()}°",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.47,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Image.network(
                                  hourly.weatherIcon,
                                  height: 66,
                                  width: 66,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                                Text(
                                  DateFormat('HH:mm').format(hourly.time),
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.47,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Image houseImage() {
    return Image.asset(
      'lib/assets/images/house.png', // Local image
      height: 198,
      width: 336,
      fit: BoxFit.cover,
    );
  }

  Column currentWeather(WeatherEntity weather) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.network(
        weather.weatherIcon,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      ),
      Text(weather.cityName,
          style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 64,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.47,
              fontFamily: 'Poppins')),
      Text("${weather.currentTemp.round()}°",
          style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 54,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.47,
              fontFamily: 'Poppins')), //currentTemp from api
      Text(
        weather.description,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.47,
          fontFamily: 'Poppins',
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Max: ${weather.tempMax.round()}°",
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 24,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.47,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 20),
          Text("Min: ${weather.tempMin.round()}°",
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.47,
                  fontFamily: 'Poppins')), //tempMin from api
        ],
      )
    ]);
  }
}
