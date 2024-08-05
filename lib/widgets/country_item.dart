import 'package:flutter/material.dart';
import 'package:flutter_vpn/utils/my_colors.dart';
import '../model/country_model.dart';

Widget buildCountryItem(CountryModel countryItem, int index) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(right: 26, left: 26),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 40,
              height: 40,
              child: Image.asset(
                countryItem.countryImage,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countryItem.countryName,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  countryItem.countryIp,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MyColors.grey,
                      fontSize: 12),
                )
              ],
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: index == 0 ? 0 : 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(124),
              color: index == 0 ? MyColors.green : Colors.grey),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Center(
              child: Text(
                index == 0 ? "Connected" : "Connect",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
