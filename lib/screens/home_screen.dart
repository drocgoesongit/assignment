import 'package:assignment/components/bottombar_destinations.dart';
import 'package:assignment/screens/coupons_fragment.dart';
import 'package:assignment/screens/other_fragments.dart';
import 'package:assignment/viewmodel/bottombar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _screens = [
    CouponsScreen(),
    LocationsScreen(),
    MessagesScreen(),
    PanicButtonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarState>(
      builder: (context, appState, child) {
        return Scaffold(
          body: _screens[appState.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appState.selectedIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.red,
            showUnselectedLabels: true,
            onTap: appState.onTabTapped,
            items: <BottomNavigationBarItem>[
              couponDestinaton,
              locationDestinaton,
              messageDestinaton,
              panicButtonDestinaton,
            ],
          ),
        );
      },
    );
  }
}
