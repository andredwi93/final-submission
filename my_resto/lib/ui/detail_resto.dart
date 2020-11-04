import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_resto/model/restaurants.dart';
import 'package:my_resto/db/db_provider.dart';
import 'package:my_resto/utils/style.dart';
import 'package:provider/provider.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detail-restaurant';
  const DetailResto({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigationColor,
        title: Text(data.name),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorite(data.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;
              return ListView(
                padding: EdgeInsets.only(top: 24, right: 16, left: 16),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    height: 200,
                    child: Center(
                      child: Text(
                        data.pictureId ?? 'Photo',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 0),
                          title: Text(data.name ?? ''),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: navigationColor,
                              ),
                              Text(
                                data.city ?? '',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      isFavorite
                          ? IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: activeNavigation,
                                size: 32,
                              ),
                              onPressed: () {
                                provider.removeFavorite(data.id);
                                Fluttertoast.showToast(
                                  msg: 'Berhasil Dihapus',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: navigationColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: activeNavigation,
                                size: 32,
                              ),
                              onPressed: () {
                                provider.addFavorite(data);
                                Fluttertoast.showToast(
                                  msg: 'Berhasil Ditambahkan',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: navigationColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: activeNavigation,
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${data.rating}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    data.description,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
