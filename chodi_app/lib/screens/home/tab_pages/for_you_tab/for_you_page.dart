
import 'package:chodiapp/constants/constants.dart';
import 'package:chodiapp/screens/Home/tab_pages/for_you_tab/carousel_explore_community.dart';
import 'package:flutter/material.dart';
import 'carousel_featured.dart';


class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    //UserData userData = Provider.of<UserData>(context) ?? UserData();

    return Column(
      children: <Widget>[
        CarouselFeatured(),
        Divider(
          thickness: 0.5,
          color: Colors.black12,
        ),
        CarouselExploreCommunity(),

      ],
    );
  }
}
