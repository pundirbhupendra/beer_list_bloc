import 'package:beer_list/beer.dart';
import 'package:beer_list/bloc/beer_state.dart';
import 'package:http/http.dart' as http;

abstract class Repository {
  Future<List<Beer>> getBeers();
}

class RepositoryImp implements Repository {
  @override
  Future<List<Beer>> getBeers() async {
    try {
      String url = 'https://api.punkapi.com/v2/beers';
      var resp = await http.get(url);
      return beerFromJson(resp.body);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
