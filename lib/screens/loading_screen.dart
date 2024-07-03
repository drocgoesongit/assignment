import 'package:assignment/constants/text_const.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/viewmodel/appstate_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _initialize(appState);
  }

  Future<void> _initialize(AppState appState) async {
    await appState.checkInternetConnection();
    if (appState.isInternetConnected) {
      await appState.checkLocationPermission();
      if (!appState.isLocationPermissionGranted) {
        await appState.requestLocationPermission();
      }
    }
    if (appState.isInternetConnected && appState.isLocationPermissionGranted) {
      // deliberately delayed to show the loading screen for a while...
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Deliva",
                    style: kButtonBigTextStyle.copyWith(
                        fontSize: 32, color: Colors.white)),
                SizedBox(height: 48),
                appState.isInternetConnected
                    ? appState.isLocationPermissionGranted
                        ? const Column(
                            children: [
                              Text(
                                "Checking your connection...",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              const Text(
                                "Location permission is required.",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  appState.requestLocationPermission();
                                },
                                child: const Text("Grant Permission"),
                              ),
                            ],
                          )
                    : const Text(
                        "Checking internet connection...",
                        style: TextStyle(color: Colors.white),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
