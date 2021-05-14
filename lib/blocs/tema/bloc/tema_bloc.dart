import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'tema_event.dart';
part 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc() : super(UygulamaTemasi(tema: ThemeData.light(), renk: Colors.blue));

  @override
  Stream<TemaState> mapEventToState(
    TemaEvent event,
  ) async* {

    UygulamaTemasi uygulamaTemasi;

    if(event is TemaDegistirEvent){
      switch(event.havaDurumuKisaltmasi){
        case "sn":
        case "sl":
        case "h":
        case "t":
        case "hc":
          uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor: Colors.blueGrey), renk: Colors.grey);
          break;

        case "hr":
        case "lr":
        case "s":
          uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor: Colors.indigoAccent), renk: Colors.indigo);
          break;
        
        case "lc":
        case "c":
         uygulamaTemasi = UygulamaTemasi(tema: ThemeData(primaryColor: Colors.orangeAccent), renk: Colors.yellow);
          break;

      }
      yield uygulamaTemasi;
    }
  }
}
