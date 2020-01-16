import 'package:beer_list/bloc/beer_bloc.dart';
import 'package:beer_list/bloc/beer_event.dart';
import 'package:beer_list/bloc/beer_state.dart';
import 'package:beer_list/bloc/repository.dart';
import 'package:beer_list/beer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'beer_description.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => BlocBeer(repository: RepositoryImp()),
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BlocBeer _blocBeer;

  @override
  void initState() {
    super.initState();
    _blocBeer = BlocProvider.of(context);
    _blocBeer.add(FetchBeersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BeersList'),
        ),
        body: BlocBuilder<BlocBeer, BeerState>(builder: (context, state) {
          if (state is BeerInitialState) {
            return buildLoading();
          } else if (state is BeerLoadingState) {
            return buildLoading();
          } else if (state is BeerLoadedState) {
            return buildBeerList(state.beers);
          } else if (state is BeerErrorState) {
            return buildErrorUi(state.message);
          }
          return null;
        }));
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget buildBeerList(List<Beer> beers) => ListView.builder(
        itemCount: beers.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
                tag: beers[index].name,
                child: GestureDetector(
                    child: CircleAvatar(
                  radius: 30.0,
                  child: Image.network(beers[index].imageUrl),
                ))),
            title: Text(
              '${beers[index].name}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${beers[index].tagline}',
                style: TextStyle(
                    color: Colors.black.withGreen(1),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BeerDescription(beer: beers[index]))),
          );
        },
      );

  Widget buildErrorUi(String message) => Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(color: Colors.red),
          )));
}
