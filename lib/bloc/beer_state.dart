import 'package:beer_list/beer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BeerState extends Equatable {}

class BeerInitialState extends BeerState {
  @override
  List<Object> get props => [];
}

class BeerLoadingState extends BeerState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class BeerLoadedState extends BeerState {
  List<Beer> beers;

  BeerLoadedState({@required this.beers});

  @override
  List<Object> get props => [beers];
}

// ignore: must_be_immutable
class BeerErrorState extends BeerState {
  String message;

  BeerErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
