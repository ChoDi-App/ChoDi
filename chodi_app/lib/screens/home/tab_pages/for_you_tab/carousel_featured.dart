
import 'package:chodiapp/models/non_profit.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarouselFeatured extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselFeaturedState();
  }
}

class _CarouselFeaturedState extends State<CarouselFeatured> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List<NonProfit> nonProfitsData = Provider.of<List<NonProfit>>(context) ?? [NonProfit(),NonProfit(),NonProfit()];

    List<NonProfit> featuredList = [
      nonProfitsData[0],
      nonProfitsData[1],
      nonProfitsData[2]
    ];

    final List<Widget> imageSliders = featuredList
        .map((item) =>
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('images/loadingImage.gif'),
                      image: FirebaseImage(item.imageURI ??
                          "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                    ),
                  ],
                )),
          ),
        ))
        .toList();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Featured",
              style: GoogleFonts.ubuntu(
                  fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: featuredList.map((url) {
              int index = featuredList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ]);
  }
}
