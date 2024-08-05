import 'package:flutter/material.dart';

Widget buildCustomBtnWidget(String title, String imageAddress,
    bool hasRightIcon, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(159, 255, 87, 1),
            Color.fromRGBO(
              195,
              252,
              151,
              1,
            )
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 26, left: 26),
        child: Row(
          mainAxisAlignment: hasRightIcon
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Row(
              children: [
                if (imageAddress != "")
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: hasRightIcon ? 40 : 27,
                    height: hasRightIcon ? 40 : 27,
                    child: Image.asset(
                      imageAddress,
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    if (hasRightIcon)
                      Text(
                        "512.122.34.3",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12),
                      )
                  ],
                )
              ],
            ),
            if (hasRightIcon) const Icon(Icons.arrow_outward)
          ],
        ),
      ),
    ),
  );
}
