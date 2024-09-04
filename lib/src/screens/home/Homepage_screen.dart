import 'package:flutter/material.dart';
import 'package:myapp/src/screens/class/detail_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Find Your',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Inspiration',
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Promo Today', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        promoCard(context,
                            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-course-banner-design-template-482c03456adb483453cac335a7d4ec68_screen.jpg?ts=1640681910'),
                        promoCard(context,
                            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-course-banner-design-template-482c03456adb483453cac335a7d4ec68_screen.jpg?ts=1640681910'),
                        promoCard(context,
                            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-course-banner-design-template-482c03456adb483453cac335a7d4ec68_screen.jpg?ts=1640681910'),
                        promoCard(context,
                            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-course-banner-design-template-482c03456adb483453cac335a7d4ec68_screen.jpg?ts=1640681910'),
                        promoCard(context,
                            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-course-banner-design-template-482c03456adb483453cac335a7d4ec68_screen.jpg?ts=1640681910'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Promo Today', style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  WorkTile(
                    icon: Icons.favorite,
                    name: 'Taera 1 ',
                    number: '16 excerecies',
                  ),
                  WorkTile(
                    icon: Icons.favorite,
                    name: 'Taera 1 ',
                    number: '16 excerecies',
                  ),
                  WorkTile(
                    icon: Icons.favorite,
                    name: 'Taera 1 ',
                    number: '16 excerecies',
                  ),
                  WorkTile(
                    icon: Icons.favorite,
                    name: 'Taera 1 ',
                    number: '16 excerecies',
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

Widget promoCard(context, image) {
  return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen()),
        );
      },
      child: AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Center(
          child: Container(
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: const [
                          0.2,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.1),
                        ])),
              )),
        ),
      ));
}
