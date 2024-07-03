import 'package:assignment/constants/text_const.dart';
import 'package:flutter/material.dart';

class Coupon extends StatelessWidget {
  const Coupon({super.key, required this.couponText});

  final String couponText;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/offer.png', height: 40),
                Text(
                  "50% OFF",
                  style: kButtonBigTextStyle,
                ),
              ],
            ),

            const SizedBox(width: 32),
            // dotted divider
            Container(
              height: 40,
              width: 1,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    couponText,
                    style: kSubHeadingTextStyle,
                  ),
                  Text(
                    'Scan to get 50% off, 2.71 kms',
                    style: kSmallParaTextStyle.copyWith(fontSize: 12),
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
