import 'package:chodiapp/models/non_profits.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class NonProfitInfoPage extends StatelessWidget {
  NonProfitInfoPage({@required this.nonProfit});

  NonProfitsData nonProfit;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            nonProfit.orgName,
                            style: GoogleFonts.ubuntu(
                                fontSize: 22, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                          ),
                          width: deviceWidth / 1.3,
                        ),
                        Icon(
                          Icons.favorite_border,
                          size: 40,
                        )
                      ],
                    ),
                    Text(nonProfit.contactNumber),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.business,
                          size: 100,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Location: ${nonProfit.city}")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.category),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Category: ${nonProfit.category}")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Year Founded: ${nonProfit.founded}")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.people),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Size: ${nonProfit.orgSize}")
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text("DONATE"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("MESSAGE"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("EMAIL"),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            nonProfit.missionVision,
                            style:
                                GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Website",
                            style: GoogleFonts.ubuntu(
                                fontSize: 17, color: Colors.black),
                          ),
                          Linkify(
                            onOpen: (url) async {
                              if (await canLaunch(url.url)) {
                                await launch(url.url);
                              } else {
                                throw 'Could not luanch $url';
                              }
                            },
                            text: nonProfit.website,
                            style: GoogleFonts.ubuntu(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
