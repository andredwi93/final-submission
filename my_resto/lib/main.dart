import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_resto/api/api_service.dart';
import 'package:my_resto/db/db_helper.dart';
import 'package:my_resto/db/db_provider.dart';
import 'package:my_resto/preferences/preferences_helper.dart';
import 'package:my_resto/provider/preferences_provider.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/provider/scheduling_provider.dart';
import 'package:my_resto/provider/search_provider.dart';
import 'package:my_resto/ui/detail_resto.dart';
import 'package:my_resto/ui/favorite.dart';
import 'package:my_resto/ui/home.dart';
import 'package:my_resto/ui/list_restaurant.dart';
import 'package:my_resto/ui/profile.dart';
import 'package:my_resto/utils/background_service.dart';
import 'package:my_resto/utils/notification_helper.dart';
import 'package:my_resto/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: ListRestaurant(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<DbProvider>(
          create: (_) => DbProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'My Resto',
        theme: ThemeData(
          textTheme: myTextTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (context) => Home(),
          ListRestaurant.routeName: (context) => ListRestaurant(),
          DetailResto.routeName: (context) =>
              DetailResto(data: ModalRoute.of(context).settings.arguments),
          Favorite.routeName: (context) => Favorite(),
          Profile.routeName: (context) => Profile(),
        },
      ),
    );
  }
}
