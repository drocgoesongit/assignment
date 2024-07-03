import 'package:assignment/components/individual_coupon.dart';
import 'package:assignment/constants/color_const.dart';
import 'package:assignment/viewmodel/authentication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softWhiteCustomColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Coupons'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              final authViewModel =
                  Provider.of<AuthenticationViewmodel>(context, listen: false);
              authViewModel.signOut(context);
            },
          )
        ],
      ),
      body: const Center(
          child: Column(
        children: [
          SizedBox(height: 20),
          Coupon(
            couponText: "Amazon ",
          ),
          Coupon(
            couponText: "AirBNB",
          ),
        ],
      )),
    );
  }
}
