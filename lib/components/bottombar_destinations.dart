import 'package:flutter/material.dart';

BottomNavigationBarItem couponDestinaton = const BottomNavigationBarItem(
  icon: Icon(Icons.local_offer_outlined),
  activeIcon: Icon(
    Icons.local_offer_rounded,
    color: Colors.red,
  ),
  label: 'Coupons',
);

BottomNavigationBarItem locationDestinaton = const BottomNavigationBarItem(
  icon: Icon(Icons.location_on_outlined),
  activeIcon: Icon(
    Icons.location_on,
    color: Colors.red,
  ),
  label: 'Locations',
);

BottomNavigationBarItem messageDestinaton = const BottomNavigationBarItem(
  icon: Icon(Icons.message_outlined),
  activeIcon: Icon(
    Icons.message,
    color: Colors.red,
  ),
  label: 'Messages',
);

BottomNavigationBarItem panicButtonDestinaton = const BottomNavigationBarItem(
  icon: Icon(Icons.warning_amber_outlined),
  activeIcon: Icon(
    Icons.warning,
    color: Colors.red,
  ),
  label: 'Panic',
);
