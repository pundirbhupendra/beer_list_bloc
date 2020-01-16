import 'package:equatable/equatable.dart';

abstract class BeerEvent extends Equatable {}

class FetchBeersEvent extends BeerEvent {
  @override
  List<Object> get props => [];
}
