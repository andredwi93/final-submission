import 'package:flutter/material.dart';
import 'package:my_resto/db/db_provider.dart';
import 'package:my_resto/utils/result.dart';
import 'package:my_resto/widgets/card_resto.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  static const routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorite',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.HasData) {
            return ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (context, index) {
                return CardResto(data: provider.list[index]);
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/favorite.png'),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Empty Favorite Food',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
