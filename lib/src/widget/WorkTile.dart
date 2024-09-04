import 'package:flutter/material.dart';

class WorkTile extends StatelessWidget {
  final icon;
  final String name;
  final String number;
  const WorkTile({
    Key? key,
    required this.icon,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: Icon(icon, color: Colors.white),
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.more_horiz)
            ],
          )),
    );
  }
}