import 'package:chodiapp/Models/non_profit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'NonProftInfoPage.dart';

class NonProfitTile extends StatelessWidget {
  NonProfit nonProfit;

  NonProfitTile({@required this.nonProfit});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute( builder: (context) => NonProfitInfoPage(nonProfit: nonProfit)),
        );
      },
      child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(nonProfit.name, style: GoogleFonts.ubuntu(
                    fontSize: 20, fontWeight: FontWeight.w200),),
              ],
            ),
          )
      ),
    );
  }
}
