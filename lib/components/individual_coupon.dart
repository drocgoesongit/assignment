import 'package:assignment/components/half_circle.dart';
import 'package:assignment/constants/color_const.dart';
import 'package:assignment/constants/text_const.dart';
import 'package:flutter/material.dart';

class Coupon extends StatelessWidget {
  const Coupon({super.key, required this.couponText});

  final String couponText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: AspectRatio(
        aspectRatio: 4 / 1,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/coupon.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/offer.png', height: 20),
                    Text(
                      "50% OFF",
                      style: kButtonBigTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        couponText,
                        style: kSubHeadingTextStyle,
                      ),
                      Text(
                        '2.71 kms',
                        style: kSmallParaTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.blue,
                      padding: EdgeInsets.all(10),
                      child: Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
