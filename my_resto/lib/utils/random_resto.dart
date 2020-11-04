import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:my_resto/api/api_service.dart';
import 'package:my_resto/model/restaurants.dart';

class RandomResto {
  ApiService service;
  ListRestaurants restaurants;

  RandomResto({@required this.service, @required this.restaurants});

  int _index = 0;

  int number() {
    return _index += Random().nextInt(restaurants.restaurants.length);
  }
}
