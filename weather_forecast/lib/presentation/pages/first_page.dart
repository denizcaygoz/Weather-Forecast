import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/presentation/bloc/weather_bloc.dart';
import 'package:weather_forecast/presentation/bloc/weather_event.dart';
import 'package:weather_forecast/presentation/bloc/weather_state.dart';
import 'package:weather_forecast/presentation/pages/main_page.dart';
import 'package:weather_forecast/presentation/pages/side_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch weather for Ankara when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(const OnCityChanged('Ankara'));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/images/background.png"),
              fit: BoxFit.cover // Centers the image
              ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/images/weather_icon.png',
              height: 428,
              width: 428,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 51),
            Image.asset(
              'lib/assets/images/weather_forecasts_text.png',
              height: 154,
              width: 428,
            ),
            const SizedBox(height: 53),
            BlocListener<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoaded &&
                    _searchController.text.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 304,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDB130),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      return TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Color(0xFF362A84),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.47,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search a city',
                          hintStyle: TextStyle(
                            color: Color(0xFF362A84).withOpacity(0.7),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.47,
                            fontFamily: 'OpenSans',
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF362A84),
                            size: 30,
                          ),
                          suffixIcon: state is WeatherLoading
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF362A84),
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                        ),
                        textAlign: TextAlign.start,
                        onChanged: (query) {
                          if (query.isNotEmpty) {
                            context
                                .read<WeatherBloc>()
                                .add(OnCityChanged(query));
                          }
                        },
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            context
                                .read<WeatherBloc>()
                                .add(OnCityChanged(query));
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadFailue) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SidePage()),
              );
            }
          });
        },
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color(0xFFFFFFFF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
            backgroundColor: Color(0xFFFFFFFF),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
            backgroundColor: Color(0xFFFFFFFF),
          ),
        ],
      ),
    );
  }
}
