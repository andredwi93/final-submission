import 'package:flutter/foundation.dart';
import 'package:my_resto/model/restaurants.dart';
import 'package:my_resto/db/db_helper.dart';
import 'package:my_resto/utils/result.dart';

class DbProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DbProvider({@required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state;
  ResultState get state => _state;

  List<Restaurant> _list = [];
  List<Restaurant> get list => _list;

  void _getFavorite() async {
    _list = await databaseHelper.getFavorite();
    if (_list.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteResto = await databaseHelper.getFavoriteById(id);
    return favoriteResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
    }
  }
}
