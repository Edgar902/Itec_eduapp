// Suggested code may be subject to a license. Learn more: ~LicenseLog:1071664275.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1208319279.
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text('Detail Screen'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.favorite)),
                  Tab(icon: Icon(Icons.ad_units))
                ],
              )),
          body: TabBarView(
            children: [
              ListView(
                children: <Widget>[classCard(), classCard(), classCard()],
              ),
              Container(child: Text("asda")),
            ],
          ),
        ));
  }
}

Widget classCard() {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.orange,
                      child: Icon(Icons.add, color: Colors.white),
                    )),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Desarrollo de Software",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
  );
}
