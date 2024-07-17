import 'package:flutter/material.dart';

Widget buildAppBarWidget(String title, Color color, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 30),
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
  );
}
