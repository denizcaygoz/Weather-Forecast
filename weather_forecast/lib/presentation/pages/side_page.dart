import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/domain/entities/weather.dart';
import 'package:weather_forecast/presentation/bloc/weather_bloc.dart';
import 'package:weather_forecast/presentation/bloc/weather_state.dart';
import 'package:weather_forecast/presentation/pages/first_page.dart';
import 'package:weather_forecast/presentation/pages/main_page.dart';

class SidePage extends StatefulWidget {
  const SidePage({super.key});

  @override
  State<SidePage> createState() => SidePageState();
}

class SidePageState extends State<SidePage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 2;

  @override
  void dispose() {
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is! WeatherLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final weather = state.result;

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
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
                  const SizedBox(height: 50),
                  cityAndMaxMinTemps(weather),
                  const SizedBox(height: 20),
                  fiveDaysForecastsTextAndList(weather),
                  const SizedBox(height: 20),
                  airInfos(weather),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        sunriseAndSunset(weather),
                        const SizedBox(width: 5),
                        todayWeather(weather)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container todayWeather(WeatherEntity weather) {
    return Container(
      width: 161,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF9D52AC),
            Color(0xFF3E2D8F),
          ],
        ),
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: Row(
              children: [
                Icon(Icons.cloud, color: Color(0xFFFFFFFF), size: 18),
                Text(
                  "Today",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.47,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ],
            ),
          ),
          Text(
            weather.main,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 28,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.47,
              fontFamily: 'Open Sans',
            ),
          ),
          Image.network(
            weather.weatherIcon,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Text(
            weather.description,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.47,
              fontFamily: 'Open Sans',
            ),
          )
        ],
      ),
    );
  }

  Container sunriseAndSunset(WeatherEntity weather) {
    return Container(
      width: 161,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF9D52AC),
            Color(0xFF3E2D8F),
          ],
        ),
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: Row(
              children: [
                Icon(Icons.wb_sunny, color: Color(0xFFFFFFFF), size: 18),
                Text(
                  "SUNRISE",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.47,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${DateFormat('HH:mm').format(weather.sunrise)} A.M.",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 28,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.47,
              fontFamily: 'Open Sans',
            ),
          ),
          Text(
            "Sunset: ${DateFormat('HH:mm').format(weather.sunset)} P.M.",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.47,
              fontFamily: 'Open Sans',
            ),
          )
        ],
      ),
    );
  }

  Column fiveDaysForecastsTextAndList(WeatherEntity weather) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 22, bottom: 12),
            child: Text(
              "5-Days Forecasts",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.47,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _scrollLeft,
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: weather.dailyForecasts.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (context, index) => SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final daily = weather.dailyForecasts[index];
                    return Container(
                      width: 60,
                      height: 172,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF3E2D8F),
                            Color(0xFF8E78C8),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${daily.temp.round()}°",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.47,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Image.network(
                            daily.weatherIcon,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          Text(
                            daily.dayOfWeek,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.47,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _scrollRight,
              ),
            ],
          ),
        )
      ],
    );
  }

  Column cityAndMaxMinTemps(WeatherEntity weather) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(
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
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.47,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "Min: ${weather.tempMin.round()}°",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.47,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        )
      ],
    );
  }

  void _scrollLeft() {
    if (_scrollController.hasClients && _scrollController.position.pixels > 0) {
      final currentPosition = _scrollController.offset;
      final newPosition = currentPosition - 100.0;
      _scrollController.animateTo(
        newPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent) {
      final currentPosition = _scrollController.offset;
      final newPosition = currentPosition + 100.0;
      _scrollController.animateTo(
        newPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Padding airInfos(WeatherEntity weather) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 35, right: 35, bottom: 44),
      child: Container(
        width: 352,
        height: 174,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF9D52AC),
              Color(0xFF3E2D8F),
            ],
          ),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            iconAndAirText(),
            SizedBox(height: 10),
            windInfosHumidityAndFeelsLike(weather)
          ],
        ),
      ),
    );
  }

  Padding iconAndAirText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12),
      child: Row(
        children: [
          Icon(Icons.gps_fixed, color: Color(0xFFFFFFFF), size: 18),
          const SizedBox(width: 5),
          Text(
            "Air",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.47,
              fontFamily: 'Open Sans',
            ),
          ),
        ],
      ),
    );
  }

  Padding windInfosHumidityAndFeelsLike(WeatherEntity weather) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wind Speed: ${weather.windSpeed}",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "Wind Degree: ${weather.windDegree}",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "Wind Gust: ${weather.windGust}",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans',
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Humidity: ${weather.humidity}",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans',
                ),
              ),
              Text(
                "Feels like: ${weather.feelsLike}°",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
