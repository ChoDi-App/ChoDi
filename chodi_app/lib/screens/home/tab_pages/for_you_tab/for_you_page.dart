
import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/carousel_explore_community.dart';
import 'package:flutter/material.dart';
import 'based_on_interests.dart';
import 'carousel_featured.dart';


class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //UserData userData = Provider.of<UserData>(context) ?? UserData();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselFeatured(),
          Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          CarouselExploreCommunity(),
          Container(
              child: BasedOnInterest(),
          ),

        ],
      ),
    );
  }
}
