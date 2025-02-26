import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/core/constants/constans.dart';
import 'package:weather_forecast/core/error/exception.dart';
import 'package:weather_forecast/data/data_sources/remote_data_source.dart';
import 'package:weather_forecast/data/models/weather_model.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'London';

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy_data/dummy_weather_response.json'),
                200,
              ));

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response('Not found', 404));

      // act
      final call = weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
