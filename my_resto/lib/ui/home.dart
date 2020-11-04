import 'package:flutter/material.dart';
import 'package:my_resto/provider/scheduling_provider.dart';
import 'package:my_resto/ui/detail_resto.dart';
import 'package:my_resto/ui/favorite.dart';
import 'package:my_resto/ui/list_restaurant.dart';
import 'package:my_resto/ui/profile.dart';
import 'package:my_resto/utils/background_service.dart';
import 'package:my_resto/utils/notification_helper.dart';
import 'package:my_resto/utils/style.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  int _selectedPage = 0;

  void _onTab(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
        context, DetailResto.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      ListRestaurant(),
      Favorite(),
      ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider(),
        child: Profile(),
      ),
    ];

    final _bottomNabarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.food_bank),
        label: 'Restaurant',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorite',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profile',
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNabarItems,
      currentIndex: _selectedPage,
      onTap: _onTab,
      selectedItemColor: activeNavigation,
      unselectedItemColor: navigationColor,
      backgroundColor: navigationBackground,
      elevation: 5.0,
      iconSize: 32,
    );
    return Scaffold(
      body: _listPage[_selectedPage],
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
