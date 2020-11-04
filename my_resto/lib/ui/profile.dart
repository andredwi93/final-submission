import 'package:flutter/material.dart';
import 'package:my_resto/provider/preferences_provider.dart';
import 'package:my_resto/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 100,
                child: Icon(
                  Icons.account_circle,
                  size: 200,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Material(
                child: ListTile(
                  title: Text(
                    'Scheduling Restaurant',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        activeColor: Colors.amber,
                        value: provider.isDailyTrendingActive,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurants(value);
                          provider.enableDailyTrending(value);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
