part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent{
  final String sehirAdi;

  FetchWeatherEvent({@required this.sehirAdi});

  @override
 
  List<Object> get props => [sehirAdi];
  
}

class RefreshWeatherEvent extends WeatherEvent{
  final String sehirAdi;

  RefreshWeatherEvent({@required this.sehirAdi});

  @override
 
  List<Object> get props => [sehirAdi];
  
}

