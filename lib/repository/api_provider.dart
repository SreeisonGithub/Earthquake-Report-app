import '../models/model.dart';

import 'package:http/http.dart' show Client;

class ProductApi {
  static Client client = Client();
  final String _root =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  fetchProducts() async {
    var response = await client.get(_root);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body;
      final quakes = quakesFromJson(jsonString);
      final List<Feature> features = quakes.features;
      return features;
      //json.decode(jsonString);
    } else {
      return throw Exception('Failed to load data');
    }
  }
}
