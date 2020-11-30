import 'package:chodiapp/constants/constants.dart';
import 'package:flutter/material.dart';

class ExpandingText extends StatefulWidget {
  final String text;
  final TextStyle ts;

  ExpandingText(this.text, @optionStyle this.ts);

  @override
  _ExpandingTextState createState() => new _ExpandingTextState();
}

class _ExpandingTextState extends State<ExpandingText> {
  String beginningText;
  String restOfText;
  bool seeMore = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      beginningText = widget.text.substring(0, 200);
      restOfText = widget.text.substring(200, widget.text.length);
    } else {
      beginningText = widget.text;
      restOfText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return restOfText.isEmpty
        ? Text(beginningText)
        : Column(
            children: <Widget>[
              Text(
                seeMore
                    ? (beginningText + "...")
                    : (beginningText + restOfText),
                style: widget.ts,
              ),
              SizedBox(height: 10),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text(
                      seeMore ? "show more" : "show less",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    seeMore = !seeMore;
                  });
                },
              ),
            ],
          );
  }
}
