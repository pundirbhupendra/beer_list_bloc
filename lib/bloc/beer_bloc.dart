import 'package:beer_list/beer.dart';
import 'package:beer_list/bloc/beer_event.dart';
import 'package:beer_list/bloc/beer_state.dart';
import 'package:beer_list/bloc/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBeer extends Bloc<BeerEvent, BeerState> {
  Repository repository;

  BlocBeer({@required this.repository});

  @override
  BeerState get initialState => BeerInitialState();

  @override
  Stream<BeerState> mapEventToState(BeerEvent event) async* {
    if (event is FetchBeersEvent) {
      yield BeerLoadingState();
      try {
        List<Beer> beersList = await repository.getBeers();
        yield BeerLoadedState(beers: beersList);
      } catch (e) {
        yield BeerErrorState(message: e.toString());
      }
    }
  }
}
