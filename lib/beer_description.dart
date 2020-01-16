import 'package:beer_list/beer.dart';
import 'package:flutter/material.dart';

class BeerDescription extends StatelessWidget {
  final Beer beer;

  BeerDescription({Key key, @required this.beer}) : super(key: key);
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('BeerDescription'),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              SizedBox(
                height: height * 0.08,
              ),
              showImage(),
              SizedBox(
                height: height * 0.02,
              ),
              beerName(),
              SizedBox(
                height: height * 0.02,
              ),
              beerDescription(),
            ]))));
  }

  Widget showImage() => Hero(
        tag: beer.name,
        child: CircleAvatar(
          radius: 100.0,
          child: Image.network(beer.imageUrl),
        ),
      );

  Widget beerName() => Center(
          child: Text(
        beer.name,
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ));

  Widget beerDescription() => Container(
      width: width * 0.9,
      child: Text(
        beer.description,
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ));
}
