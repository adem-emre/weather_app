import 'dart:async';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/tema/bloc/tema_bloc.dart';
import 'package:weather_app/blocs/weather/bloc/weather_bloc.dart';
import 'package:weather_app/widget/gecisli_arkaplan_renk.dart';
import 'sehir_sec.dart';

import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininGirdigiSehir = "";
  Completer<void> _refreshCompleter=Completer<void>();
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              onPressed: () async {
                kullanicininGirdigiSehir = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SehirSecWidget(),
                  ),
                );
                if (kullanicininGirdigiSehir != null) {
                  _weatherBloc.add(
                      FetchWeatherEvent(sehirAdi: kullanicininGirdigiSehir));
                }
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (context, WeatherState state) {
            if (state is InitialWeatherState) {
              return Center(
                child: Text("Sehir Seçiniz"),
              );
            }

            if (state is WeatherLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is WeatherLoadedState) {
              final getirilenWeather=state.weather;
              final _havaDurumuKisaltma=getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
              kullanicininGirdigiSehir=getirilenWeather.title;
              BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(havaDurumuKisaltmasi: _havaDurumuKisaltma));




              _refreshCompleter.complete();
              _refreshCompleter=Completer();
              
              return BlocBuilder(
                bloc:BlocProvider.of<TemaBloc>(context),
                builder: (context,TemaState temaState)=>
                 GecisliRenkContainer(
                  renk: (temaState as UygulamaTemasi).renk,
                  child: RefreshIndicator(
                    onRefresh: (){
                      _weatherBloc.add(RefreshWeatherEvent(sehirAdi: kullanicininGirdigiSehir));
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: LocationWidget(
                            secilenSehir: getirilenWeather.title,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: SonGuncellemeWidget()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: HavaDurumuResimWidget()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: MaxveMinSicaklikWidget()),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            
            if(state is WeatherErrorState){
              return Center(child: Text("Hata oluştu"),);
            }

            return null; 
          },
        ),
      ),
    );
  }
}
