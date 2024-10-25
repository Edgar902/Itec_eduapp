import 'package:flutter/material.dart';

class CardActions extends StatelessWidget {
  final icon;
  final String name;
  final String date;
  final String description;

  const CardActions(
      {Key? key,
      required this.icon,
      required this.name,
      required this.date,
      required this.description})
      : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date),
              Row(
                children: [
                  Icon(Icons.file_upload),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: new EdgeInsets.only(right: 13.0),
                        child: Text(name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF17202A),
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xFF17202A),
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ],
                  ),
                  const Icon(Icons.arrow_left)
                ],
              ),
            ],
          )),
    );
  }
}
