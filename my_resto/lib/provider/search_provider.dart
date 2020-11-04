import 'package:flutter/foundation.dart';
import 'package:my_resto/api/api_service.dart';
import 'package:my_resto/model/restaurants.dart';
import 'package:my_resto/utils/result.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({@required this.apiService}) {
    _fetchRestaurants();
  }

  ListRestaurants _listRestaurants;
  ListRestaurants get list => _listRestaurants;

  ResultState _state;
  ResultState get state => _state;

  String _message;
  String get message => _message;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resto = await apiService.listResto();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data Not Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurants = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
