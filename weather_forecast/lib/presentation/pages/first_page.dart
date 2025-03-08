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
  final PageController _pageController = PageController();
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extends content beneath the BottomNavigationBar
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // PageView for Smooth Transitions
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              // First Page Content
              _buildFirstPageContent(),

              // Main Page (Weather Details)
              const MainPage(),

              // Side Page (More Options)
              const SidePage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow effect
        selectedItemColor: Colors.white, // White selected labels
        unselectedItemColor:
            Colors.white.withOpacity(0.7), // Semi-transparent unselected labels
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }

  /// First Page UI Content
  Widget _buildFirstPageContent() {
    return Column(
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
            if (state is WeatherLoaded && _searchController.text.isNotEmpty) {
              _pageController.jumpToPage(1); // Navigate to the Weather page
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 304,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFDDB130),
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
                        color: const Color(0xFF362A84).withOpacity(0.7),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.47,
                        fontFamily: 'OpenSans',
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF362A84),
                        size: 30,
                      ),
                      suffixIcon: state is WeatherLoading
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              height: 10,
                              width: 10,
                              child: const CircularProgressIndicator(
                                color: Color(0xFF362A84),
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                    ),
                    textAlign: TextAlign.start,
                    onChanged: (query) {
                      if (query.isNotEmpty) {
                        context.read<WeatherBloc>().add(OnCityChanged(query));
                      }
                    },
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        context.read<WeatherBloc>().add(OnCityChanged(query));
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
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
