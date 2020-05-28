import 'package:chodiapp/models/non_profit.dart';
import 'package:chodiapp/models/user.dart';
import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/non_profit_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BasedOnInterest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NonProfit> nonProfitsData = Provider.of<List<NonProfit>>(context);
    User currentUser = Provider.of<User>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Based on your interests",
              style:
                  GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: <Widget>[
              GridView.builder(
                itemCount: nonProfitsData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return NonProfitCard(
                    nonProfit: nonProfitsData[index],
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
