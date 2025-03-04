import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/domain/entities/weather.dart';

class SidePage extends StatefulWidget {
  const SidePage({super.key});

  @override
  State<SidePage> createState() => SidePageState();
}

class SidePageState extends State<SidePage> {
  late final WeatherEntity weatherEntity;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    weatherEntity = _initializeWeatherEntity();
  }

  @override
  void dispose() {
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity, // Ensures the container takes full width
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2B2B54), // Dark blue/purple
                Color(0xFF6B2B8C), // Purple
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //place an arrow on the top left
            children: [
              const SizedBox(height: 50),
              cityAndMaxMinTemps(),
              const SizedBox(height: 20),
              fiveDaysForecastsTextAndList(),
              const SizedBox(height: 20),
              airInfos(),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sunriseAndSunset(),
                    const SizedBox(width: 5),
                    todayWeather()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container todayWeather() {
    return Container(
                    width: 161,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFF9D52AC), // Dark blue/purple
                          Color(0xFF3E2D8F), // Purple
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
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cloud,
                                color: Color(0xFFFFFFFF),
                                size: 18,
                              ),
                              Text("Today",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.47,
                                      fontFamily: 'Open Sans')),
                            ],
                          ),
                        ),
                        Text(weatherEntity.main,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 28,
                                fontWeight: FontWeight.w600, //semiBold
                                letterSpacing: 0.47,
                                fontFamily: 'Open Sans')),
                        Image.asset(
                          weatherEntity.weatherIcon,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        Text(weatherEntity.description,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w600, //semiBold
                                letterSpacing: 0.47,
                                fontFamily: 'Open Sans'))
                      ],
                    ),
                  );
  }

  Container sunriseAndSunset() {
    return Container(
      width: 161,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF9D52AC), // Dark blue/purple
            Color(0xFF3E2D8F), // Purple
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
                Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFFFFF),
                  size: 18,
                ),
                Text("SUNRISE",
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.47,
                        fontFamily: 'Open Sans')),
              ],
            ),
          ),
          Text("${DateFormat('HH:mm').format(weatherEntity.sunrise)} A.M.",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 28,
                  fontWeight: FontWeight.w600, //semiBold
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans')),
          Text(
              "Sunset: ${DateFormat('HH:mm').format(weatherEntity.sunset)} A.M.",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600, //semiBold
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans'))
        ],
      ),
    );
  }

  Padding windInfosHumidityAndFeelsLike() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Wind Speed: ${weatherEntity.windSpeed}",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.47,
                      fontFamily: 'Open Sans')),
              Text("Wind Degree: ${weatherEntity.windDegree}",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.47,
                      fontFamily: 'Open Sans')),
              Text("Wind Gust: ${weatherEntity.windGust}",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.47,
                      fontFamily: 'Open Sans'))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Humidity: ${weatherEntity.humidity}",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.47,
                      fontFamily: 'Open Sans')),
              Text("Feels like: ${weatherEntity.feelsLike}",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.47,
                      fontFamily: 'Open Sans')),
            ],
          )
        ],
      ),
    );
  }

  Padding iconAndAirText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12),
      child: Row(
        children: [
          Icon(
            Icons.gps_fixed,
            color: Color(0xFFFFFFFF),
            size: 18,
          ),
          const SizedBox(width: 5),
          Text("Air",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400, // Regular weight
                  letterSpacing: 0.47,
                  fontFamily: 'Open Sans')),
        ],
      ),
    );
  }

  Column fiveDaysForecastsTextAndList() {
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
                  fontFamily: 'OpenSans'),
            ),
          ),
        ),
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Row(
            children: [
              // Left Arrow
              IconButton(
                icon: const Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _scrollLeft,
              ),
              // ListView
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: weatherEntity.dailyForecasts.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (context, index) => SizedBox(width: 18),
                  itemBuilder: (context, index) {
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
                            weatherEntity.dailyForecasts[index].temp.toString(),
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.47,
                                fontFamily: 'Poppins'),
                          ),
                          Image.asset(
                            weatherEntity.dailyForecasts[index].weatherIcon,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            weatherEntity.dailyForecasts[index].dayOfWeek,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.47,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Right Arrow
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

  Column cityAndMaxMinTemps() {
    return Column(
      children: [
        Text("North America",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.47,
                fontFamily: 'Poppins')), //main from api
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Max: 24°",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.47,
                    fontFamily: 'Poppins')), //tempMax from api
            const SizedBox(width: 20),
            Text("Min: 18°",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.47,
                    fontFamily: 'Poppins')), //tempMin from api
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

  WeatherEntity _initializeWeatherEntity() {
    return WeatherEntity(
      currentTemp: 19.0,
      weatherIcon: 'lib/assets/images/weather_icon.png',
      tempMax: 24.0,
      tempMin: 18.0,
      hourlyForecasts: _createHourlyForecasts(),
      dailyForecasts: _createDailyForecasts(),
      cityName: 'London',
      sunrise: DateTime.now(),
      sunset: DateTime.now().add(const Duration(hours: 12)),
      windSpeed: 5.0,
      windDegree: 180,
      windGust: 8.0,
      humidity: 75,
      feelsLike: 18.5,
      main: 'Cloudy',
      description: 'Partly cloudy',
    );
  }

  List<HourlyForecast> _createHourlyForecasts() {
    return [
      for (int hour in [0, 3, 6, 9, 12, 15, 18, 21])
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            hour,
          ),
          temp: 19.0 + (hour / 3), // Simulated temperature variation
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
    ];
  }

  List<DailyForecast> _createDailyForecasts() {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri'];
    return [
      for (int i = 0; i < 5; i++)
        DailyForecast(
          date: DateTime.now().add(Duration(days: i)),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: daysOfWeek[i],
        ),
    ];
  }

  Padding airInfos() {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 35, right: 35, bottom: 44),
      child: Container(
          //includes wind, humidity feelslike
          width: 352,
          height: 174,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF9D52AC), // Dark blue/purple
                Color(0xFF3E2D8F), // Purple
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
              windInfosHumidityAndFeelsLike()
            ],
          )),
    );
  }
}
