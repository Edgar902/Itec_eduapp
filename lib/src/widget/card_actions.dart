import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";

class CardActions extends StatelessWidget {
  final urlIcon;
  final String name;
  final String date;
  final String description;

  const CardActions(
      {Key? key,
      required this.urlIcon,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.network(
                    urlIcon,
                    width: 35,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(date),
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
                ],
              ),
              const Icon(Icons.arrow_right)
            ],
          )),
    );
  }
}
