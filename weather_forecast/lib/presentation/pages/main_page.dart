import 'package:flutter/material.dart';
import 'package:weather_forecast/domain/entities/weather.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late WeatherEntity weatherEntity;

  @override
  void initState() {
    super.initState();
    weatherEntity = WeatherEntity(
      currentTemp: 19.0,
      weatherIcon: 'lib/assets/images/weather_icon.png',
      tempMax: 24.0,
      tempMin: 18.0,
      hourlyForecasts: [
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            0, // 00:00
          ),
          temp: 19.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            3, // 03:00
          ),
          temp: 18.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            6, // 06:00
          ),
          temp: 17.5,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            9, // 09:00
          ),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            12, // 12:00
          ),
          temp: 22.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            15, // 15:00
          ),
          temp: 23.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            18, // 18:00
          ),
          temp: 21.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
        HourlyForecast(
          time: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            21, // 21:00
          ),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
        ),
      ],
      dailyForecasts: [
        DailyForecast(
          date: DateTime.now(),
          temp: 19.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: 'Mon',
        ),
        DailyForecast(
          date: DateTime.now().add(const Duration(days: 1)),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: 'Tue',
        ),
        DailyForecast(
          date: DateTime.now().add(const Duration(days: 1)),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: 'Wed',
        ),
        DailyForecast(
          date: DateTime.now().add(const Duration(days: 1)),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: 'Thr',
        ),
        DailyForecast(
          date: DateTime.now().add(const Duration(days: 1)),
          temp: 20.0,
          weatherIcon: 'lib/assets/images/weather_icon.png',
          dayOfWeek: 'Fri',
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          children: [
            currentWeather(),
            const SizedBox(
              height: 46,
            ),
            houseImage(),
            Expanded(
              // Ensures it takes all available space
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 19, left: 55, bottom: 12),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.47, //add space between letters
                                fontFamily: 'OpenSans'),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 19, right: 40, bottom: 12),
                          child: Text(
                            "July 21",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.47, //add space between letters
                                fontFamily: 'OpenSans'),
                          ),
                        ),
                      ],
                    ),
                    //drawing a Line
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Color(0xFF8E78C8),
                    ),
                    const SizedBox(height: 29),
                    Container(
                      height: 150,
                      alignment: Alignment
                          .center, // Ensures centering within the container
                      child: ListView.separated(
                        itemCount: weatherEntity.hourlyForecasts.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 18),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                weatherEntity.hourlyForecasts[index].temp
                                    .toString(),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500, //medium
                                    letterSpacing:
                                        0.47, //add space between letters
                                    fontFamily: 'Poppins'),
                              ),
                              Image.asset(
                                weatherEntity
                                    .hourlyForecasts[index].weatherIcon,
                                height: 66,
                                width: 66,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                DateFormat('HH:mm').format(
                                    weatherEntity.hourlyForecasts[index].time),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500, //medium
                                    letterSpacing:
                                        0.47, //add space between letters
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Image houseImage() {
    return Image.asset(
      'lib/assets/images/house.jpg', // Local image
      height: 198,
      width: 336,
      fit: BoxFit.cover,
    );
  }

  Column currentWeather() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.asset(
        'lib/assets/images/weather_icon.png', // Local image
        height: 244,
        width: 244,
        fit: BoxFit.cover,
      ),
      Text("19°",
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 64,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.47,
              fontFamily: 'Poppins')), //currentTemp from api
      Text("Precipitations",
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
    ]);
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      currentIndex: _selectedIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
            backgroundColor: Color(0xFFFFFFFF)),
        BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Search',
            backgroundColor: Color(0xFFFFFFFF)),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
            backgroundColor: Color(0xFFFFFFFF)),
      ],
    );
  }
}
