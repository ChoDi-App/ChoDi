import 'package:chodiapp/models/non_profits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'info_page_button.dart';
import 'non_profit_info_row.dart';
import 'package:google_fonts/google_fonts.dart';

class NonProfitInfoCard extends StatelessWidget {
  NonProfitInfoCard({@required this.nonProfit});

  NonProfitsData nonProfit;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Card(
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
                      InfoRow(
                        icon: Icon(Icons.location_on),
                        textWidget: Text("Location: ${nonProfit.city}"),
                      ),
                      InfoRow(
                        icon: Icon(Icons.category),
                        textWidget: Text("Category: ${nonProfit.category}"),
                      ),
                      InfoRow(
                        icon: Icon(Icons.calendar_today),
                        textWidget: Text("Year Founded: ${nonProfit.founded}"),
                      ),
                      InfoRow(
                        icon: Icon(Icons.people),
                        textWidget: Text("Size: ${nonProfit.orgSize}"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoPageButton(
                  onPressed: () {},
                  title: "DONATE",
                  color: Colors.grey,
                ),
                InfoPageButton(
                  onPressed: () {},
                  title: "MESSAGE",
                  color: Colors.grey,
                ),
                InfoPageButton(
                  onPressed: () {},
                  title: "EMAIL",
                  color: Colors.grey,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    nonProfit.missionVision,
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Website",
                    style:
                        GoogleFonts.ubuntu(fontSize: 17, color: Colors.black),
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
    );
  }
}
