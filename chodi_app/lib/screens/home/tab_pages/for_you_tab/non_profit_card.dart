import 'package:chodiapp/Services/auth.dart';
import 'package:chodiapp/models/non_profit.dart';
import 'package:chodiapp/models/user.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'non_profit_info_page.dart';

class NonProfitCard extends StatelessWidget {
  NonProfit nonProfit;

  NonProfitCard({@required this.nonProfit});


  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return GestureDetector(
      onTap: () {
        if (currentUser == null){
          Navigator.of(context).pushNamed('signInScreen');
        }else{
          Navigator.push(
            context,
            MaterialPageRoute( builder: (context) => NonProfitInfoPage(nonProfit: nonProfit)),
          );
        }

      },
      child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('images/loadingImage.gif'),
                      image: FirebaseImage(nonProfit.imageURI ??
                          "gs://chodi-663f2.appspot.com/nonprofitlogos/loadingImage.gif"),
                    ),
                  ),
                ),
                Divider(),
                Text(nonProfit.name,style: GoogleFonts.ubuntu(fontSize: 12),),
              ],
            ),
          )
      ),
    );
  }
}
