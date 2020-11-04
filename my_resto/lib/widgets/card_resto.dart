import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_resto/model/restaurants.dart';
import 'package:my_resto/utils/style.dart';

import '../ui/detail_resto.dart';

class CardResto extends StatelessWidget {
  const CardResto({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailResto.routeName, arguments: data);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: navigationColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  data.pictureId ?? '',
                  style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: activeNavigation,
                        ),
                        Text('${data.rating}' ?? '0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
