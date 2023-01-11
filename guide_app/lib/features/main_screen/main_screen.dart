import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Main screen of the app with navigation bottom bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.search)),
        BottomNavigationBarItem(icon: Icon(Icons.bookmarks)),
        BottomNavigationBarItem(icon: Icon(Icons.person))
      ]),
    );
  }
}
