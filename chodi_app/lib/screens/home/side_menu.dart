import 'package:chodiapp/Services/auth.dart';
import 'package:chodiapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    final AuthService _auth = Provider.of<AuthService>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage("images/google-icon.png"),
                        backgroundColor: Colors.transparent,
                        maxRadius: 30.0,
                        minRadius: 25.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            userData.name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ubuntu(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/human-rights.png"),
                                backgroundColor: Colors.transparent,
                                radius: 16.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/animals.png"),
                                backgroundColor: Colors.transparent,
                                radius: 16.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/environment.png"),
                                backgroundColor: Colors.transparent,
                                radius: 16.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/policy.png"),
                                backgroundColor: Colors.transparent,
                                radius: 16.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    " \“Let your hopes, not your hurts, shape your future \” - Robert H. Schuller",
                    style: GoogleFonts.ubuntu(
                        fontSize: 13, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.black26,
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('My Events'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('My Community'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings and Privacy'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_auth.signOut()},
          ),
          Divider(
            thickness: 1.5,
            color: Colors.black26,
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(Icons.phone_forwarded),
            title: Text("+1 23 987 6554"),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text("info@chodi.today"),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.device_hub),
            title: Text("www.chodi.today"),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
