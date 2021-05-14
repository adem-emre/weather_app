import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com";

  final http.Client httpClient = http.Client();

  Future<int> getLocationID(String sehirAdi) async {
    final sehirUrl = baseUrl + "/api/location/search/?query=" + sehirAdi;
    final gelenCevap= await http.get(Uri.parse(sehirUrl));

    if(gelenCevap.statusCode!=200){
      throw Exception("Veri Getirilemedi");
    }

    final gelenCevapJSON = (jsonDecode(gelenCevap.body)) as List;
    return gelenCevapJSON[0]["woeid"];


  }

  Future<Weather> getWeather(int sehirID) async{
    final havaDurumuURL = baseUrl+"/api/location/$sehirID";
    final havaDurumuGelenCevap = await http.get(Uri.parse(havaDurumuURL));

      if(havaDurumuGelenCevap.statusCode!=200){
      throw Exception("Hava Durumu Getirilemedi");
    }

    final havaDurumuCevapJSON = jsonDecode(havaDurumuGelenCevap.body);
    return Weather.fromJson(havaDurumuCevapJSON);
    

  }
}
