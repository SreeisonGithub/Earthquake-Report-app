import 'package:earthquake/models/model.dart';
import 'package:earthquake/repository/api_provider.dart';
import 'package:rxdart/rxdart.dart';



class QuakeBloc {
  QuakeBloc() {
    fetchProducts();
  }

  final _quake = PublishSubject<List<Feature>>();

  //getters to stream.
  Stream<List<Feature>> get quakes => _quake.stream;

  fetchProducts() async {
    final products = await ProductApi().fetchProducts();
    _quake.sink.add(products);
  }

  dispose() {
    _quake.close();
  }
}
