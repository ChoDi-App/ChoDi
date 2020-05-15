import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/non_profit_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:chodiapp/models/non_profit.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarouselExploreCommunity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselExploreCommunityState();
  }
}

class _CarouselExploreCommunityState extends State<CarouselExploreCommunity> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List<NonProfit> nonProfitsData = Provider.of<List<NonProfit>>(context);

    final List<Widget> imageSliders = nonProfitsData
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Card(
                  child: Text("Hi"),
                ),
              ),
            ))
        .toList();

//    ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        child: Stack(
//          children: <Widget>[
//            FadeInImage(
//              fit: BoxFit.cover,
//              placeholder: AssetImage('images/loadingImage.gif'),
//              image: FirebaseImage(item.imageURI ??
//                  "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
//            ),
//          ],
//        )),
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Explore Your Community",
                style: GoogleFonts.ubuntu(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Support and empower nonprofits around your local area. Be the change in your community!",
                style: GoogleFonts.ubuntu(),
              ),
            ],
          ),
        ),
        Container(
          height: 200.0,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: nonProfitsData.length,
              itemBuilder: (BuildContext context, int index) {
                return NonProfitCard(nonProfit: nonProfitsData[index],);
              }),
        )
      ],
    );
  }
}
