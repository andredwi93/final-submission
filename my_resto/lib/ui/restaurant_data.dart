import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/utils/result.dart';
import 'package:my_resto/widgets/card_resto.dart';
import 'package:provider/provider.dart';

class RestaurantData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.Loading) {
          return Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/loading.json'),
            ),
          );
        } else if (value.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.list.restaurants.length,
            itemBuilder: (context, index) {
              final data = value.list.restaurants[index];
              return CardResto(data: data);
            },
          );
        } else if (value.state == ResultState.NoData) {
          return Center(
            child: Text(value.message),
          );
        } else if (value.state == ResultState.Error) {
          return Center(
            child: Text(value.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
