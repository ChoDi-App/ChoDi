import 'package:flutter/material.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:chodiapp/screens/Home/TabPages/EventsPage.dart';
import 'package:chodiapp/screens/Home/TabPages/ForYouPage.dart';
import 'package:chodiapp/screens/Home/TabPages/ImpactPage.dart';
import 'package:chodiapp/screens/Home/TabPages/MessagesPage.dart';
import 'package:chodiapp/screens/Home/TabPages/NotificationsPage.dart';
import 'package:chodiapp/Services/Auth.dart';

class AuthenticatedHomeScreen extends StatefulWidget {
  @override
  _AuthenticatedHomeScreenState createState() => _AuthenticatedHomeScreenState();
}

class _AuthenticatedHomeScreenState extends State<AuthenticatedHomeScreen> {

  List<Color> selectedColors = [Colors.yellow, Colors.orange,Colors.red,Colors.blue,Colors.green];
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    ImpactPage(),
    EventsPage(),
    ForYouPage(),
    MessagesPage(),
    NotificationsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _auth.signOut
        ),

        title: Text('CHODI'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Impact',style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Events',style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('For You',style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages',style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications',style: TextStyle(fontSize: 12),),
          ),
        ],
        backgroundColor: primaryColor,
        iconSize:15.0,
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: selectedColors[_selectedIndex],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}