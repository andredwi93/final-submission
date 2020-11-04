import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_resto/provider/search_provider.dart';
import 'package:my_resto/utils/result.dart';
import 'package:my_resto/widgets/card_resto.dart';
import 'package:provider/provider.dart';

class SearchRestaurant extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = Consumer<SearchProvider>(
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
          final list = query.isEmpty
              ? value.list.restaurants
              : value.list.restaurants
                  .where((val) =>
                      val.name.toLowerCase().contains(query) ||
                      val.city.toLowerCase().contains(query))
                  .toList();

          return list.isEmpty
              ? Center(
                  child: Text('NOt Found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
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
    return result;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = Consumer<SearchProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.Loading) {
          return Container();
        } else if (value.state == ResultState.HasData) {
          final list = query.isEmpty
              ? value.list.restaurants
              : value.list.restaurants
                  .where((val) =>
                      val.name.toLowerCase().contains(query) ||
                      val.city.toLowerCase().contains(query))
                  .toList();

          return list.isEmpty
              ? Center(
                  child: Text('NOt Found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
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
    return result;
  }
}
