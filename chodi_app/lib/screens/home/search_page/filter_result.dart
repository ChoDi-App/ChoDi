import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';

class FilterResult extends StatefulWidget {
  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {

  RangeValues yearFoundedValues = RangeValues(1900, 2020);
  RangeLabels yearFoundedLabels = RangeLabels('1900', '2020');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Filter Results", style: TextStyle(color: Colors.white,),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Align
            (
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _titleContainer("Choose Categories"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Align
              (
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                    spacing: 15.0,
                    runSpacing: 0.0,
                    children: <Widget>[
                      filterChipWidget(chipName: 'Human Rights'),
                      filterChipWidget(chipName: 'Policy'),
                      filterChipWidget(chipName: 'Animals'),
                      filterChipWidget(chipName: 'Environment'),
                    ],
                  )
              ),
            ),
          ),
          Divider(color: appBarColor, height: 10.0,),
          Align
            (
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _titleContainer('Choose Year Founded Range'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _yearFoundedSlider()
            ),
          ),
          Divider(color: appBarColor, height: 10.0,),
        ],
      ),
    );
  }

  Widget _yearFoundedSlider() {
    return SliderTheme(
        data: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always
    ),
    child: RangeSlider(
      activeColor: Colors.blueAccent,
      values: yearFoundedValues,
      min: 1900,
      max: 2020,
      labels: yearFoundedLabels,
      onChanged: (v) {
        setState(() {
          yearFoundedValues = v;
          yearFoundedLabels = RangeLabels('${v.start.toInt().toString()}', '${v.end.toInt().toString()}');
        });
      },
    ));
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.black87, fontSize: 14.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: backgroundColor,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.black38,);
  }
}
