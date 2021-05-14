

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/tema/bloc/tema_bloc.dart';
import 'package:weather_app/blocs/weather/bloc/weather_bloc.dart';
import 'package:weather_app/locator.dart';
import 'widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<TemaBloc>(
    child: MyApp(),
    create: (context) => TemaBloc(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, TemaState state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: (state as UygulamaTemasi).tema,
        home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(), child: WeatherApp()),
      ),
    );
  }
}
