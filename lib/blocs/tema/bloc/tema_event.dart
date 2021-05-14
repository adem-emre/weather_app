part of 'tema_bloc.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent();

  @override
  List<Object> get props => [];
}

class TemaDegistirEvent extends TemaEvent{
  final String havaDurumuKisaltmasi;
  TemaDegistirEvent({@required this.havaDurumuKisaltmasi});

  @override

  List<Object> get props => [havaDurumuKisaltmasi];

}