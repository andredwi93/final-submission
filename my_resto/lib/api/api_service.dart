import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_resto/model/restaurants.dart';

class ApiService {
  Future<ListRestaurants> listResto() async {
    final response = await http.get('https://restaurant-api.dicoding.dev/list');
    if (response.statusCode == 200) {
      return ListRestaurants.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
