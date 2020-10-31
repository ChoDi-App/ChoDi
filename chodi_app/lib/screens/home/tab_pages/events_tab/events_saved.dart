import 'package:chodiapp/models/events.dart';
import 'package:chodiapp/screens/home/tab_pages/events_tab/events_card.dart';
import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsSavedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHODI",
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            //INSERT CODE HERE//

            ////
          ],
        ),
      ),
    );
  }
}