import 'package:flutter/material.dart';

class LocationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text('Locations Screen')),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text('Messages Screen')),
    );
  }
}

class PanicButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panic Button',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text('Panic Button Screen')),
    );
  }
}
