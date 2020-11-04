import 'package:flutter/material.dart';
import 'package:my_resto/ui/restaurant_data.dart';
import 'package:my_resto/ui/search_resto.dart';

class ListRestaurant extends StatelessWidget {
  static const routeName = '/list-restaurant';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 32, left: 16, bottom: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restaurant List',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: SearchRestaurant());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Search Restaurant...',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RestaurantData(),
            ),
          ],
        ),
      ),
    );
  }
}
