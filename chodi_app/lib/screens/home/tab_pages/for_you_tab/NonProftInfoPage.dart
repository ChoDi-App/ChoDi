import 'package:chodiapp/models/non_profits.dart';
import 'package:chodiapp/constants/AppColors.dart';
import 'package:chodiapp/screens/Home/TabPages/for_you_tab/non_profit_info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NonProfitInfoPage extends StatelessWidget {
  NonProfitInfoPage({@required this.nonProfit});

  NonProfitsData nonProfit;

  @override
  Widget build(BuildContext context) {
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
            NonProfitInfoCard(
              nonProfit: nonProfit,
            ),
          ],
        ),
      ),
    );
  }
}
