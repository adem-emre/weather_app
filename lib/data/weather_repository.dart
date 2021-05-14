import 'package:weather_app/data/weather_api_client.dart';
import 'package:weather_app/locator.dart';

import '../models/weather.dart';

class WeatherRepository{

  WeatherApiClient weatherApiClient =locator<WeatherApiClient>();
  Future<Weather> getWeather(String sehir) async{

    final int sehirID = await weatherApiClient.getLocationID(sehir);
    return  await weatherApiClient.getWeather(sehirID);



  }
}