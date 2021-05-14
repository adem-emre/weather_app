part of 'tema_bloc.dart';

abstract class TemaState extends Equatable {
  const TemaState();

  @override
  List<Object> get props => [];
}

class UygulamaTemasi extends TemaState {
  final ThemeData tema;
  final MaterialColor renk;

  UygulamaTemasi({@required this.tema, @required this.renk});

  @override
  
  List<Object> get props => [tema,renk];
  
}
