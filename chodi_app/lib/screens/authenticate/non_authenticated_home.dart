import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/for_you_page.dart';
import 'package:flutter/material.dart';

class NonAuthenticatedHomeScreen extends StatefulWidget {
  @override
  _NonAuthenticatedHomeScreenState createState() => _NonAuthenticatedHomeScreenState();
}

class _NonAuthenticatedHomeScreenState extends State<NonAuthenticatedHomeScreen> {

  List<Color> selectedColors = [Colors.yellow, Colors.orange,Colors.red,Colors.blue,Colors.green];
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    Text("placeholder"),
    Text("placeholder"),
    ForYouPage(),
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pushNamed('signInScreen');
            },
          )
        ],
        centerTitle: true,
        title: RichText(
            text: new TextSpan(
                style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                children: <TextSpan>[
                  new TextSpan(text: "C", style: new TextStyle(color: Colors.yellow)),
                  new TextSpan(text: "H", style: new TextStyle(color: Colors.orange)),
                  new TextSpan(text: "O", style: new TextStyle(color: Colors.red)),
                  new TextSpan(text: "D", style: new TextStyle(color: Colors.blue)),
                  new TextSpan(text: "I", style: new TextStyle(color: Colors.green)),
                ]
            )
        ),
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
