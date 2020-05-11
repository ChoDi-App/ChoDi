import 'package:flutter/material.dart';
import 'package:chodiapp/constants/TextStyles.dart';

class ImpactPage extends StatefulWidget {
  @override
  _ImpactPageState createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 0: Impact page SIGNED IN',
        style: optionStyle,
      ),
    );
  }
}
