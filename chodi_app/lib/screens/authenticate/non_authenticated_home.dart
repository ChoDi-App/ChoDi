import 'package:chodiapp/constants/constants.dart';
import 'package:flutter/material.dart';

class NonAuthenticatedHomeScreen extends StatefulWidget {
  @override
  _NonAuthenticatedHomeScreenState createState() => _NonAuthenticatedHomeScreenState();
}

class _NonAuthenticatedHomeScreenState extends State<NonAuthenticatedHomeScreen> {

  List<Color> selectedColors = [Colors.yellow, Colors.orange,Colors.red,Colors.blue,Colors.green];
  int _selectedIndex = 2;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Text("placeholder"),
    Text("placeholder"),
    Column(
      children: <Widget>[
        Text(
          'Index 2: For you page',
          style: optionStyle,
        ),
        Text("NOT SIGNED IN",
        style: optionStyle,)
      ],
    ),
    Text("placeholder"),
    Text("placeholder")
  ];

  void _onItemTapped(int index) {
    if (index == 2){
      setState(() {
        _selectedIndex = index;
      });
    }
    else{
      Navigator.of(context).pushNamed('signInScreen');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
