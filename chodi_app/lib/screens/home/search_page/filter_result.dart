import 'package:flutter/material.dart';
import 'package:chodiapp/constants/constants.dart';

class FilterResult extends StatefulWidget {
  final Function passOptionsCallBack;

  FilterResult({this.passOptionsCallBack});

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {

  static const double start = 1900;
  static const double end = 2020;

  RangeValues yearFoundedValues = RangeValues(start, end);
  RangeLabels yearFoundedLabels = RangeLabels(start.round().toString(), end.round().toString());
  List<String> categoriesSelected = [];

  List<String> categoriesOptions = [
    'human rights',
    'policy',
    'animals',
    'environment'
  ];

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
                RangeValues resultRange;
                if ((yearFoundedValues.start != start) | (yearFoundedValues.end != end)) {
                  resultRange = yearFoundedValues;
                }
                widget.passOptionsCallBack({
                  "yearsRange": resultRange,
                  "categories": categoriesSelected
                });
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 15.0,
                runSpacing: 0.0,
                children: <Widget>[
                  filterChipWidget(chipName: 'Human Rights',
                    value: "human rights",
                    isSelected: categoriesSelected.contains("human rights"),
                    returnSelectedChipName: addToCategoriesCallBack,),
                  filterChipWidget(chipName: 'Policy',
                    value: "policy",
                    isSelected: categoriesSelected.contains("policy"),
                    returnSelectedChipName: addToCategoriesCallBack,),
                  filterChipWidget(chipName: 'Animals',
                    value: "animals",
                    isSelected: categoriesSelected.contains("animals"),
                    returnSelectedChipName: addToCategoriesCallBack,),
                  filterChipWidget(chipName: 'Environment',
                    value: "environment",
                    isSelected: categoriesSelected.contains("environment"),
                    returnSelectedChipName: addToCategoriesCallBack,),
                ],
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

  addToCategoriesCallBack(chipName) {
    if (categoriesSelected.contains(chipName)) {
      setState(() {
        categoriesSelected.remove(chipName);
      });
    }
    else if (!categoriesSelected.contains(chipName)) {
      setState(() {
        categoriesSelected.add(chipName);
      });
    }
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
              yearFoundedLabels = RangeLabels('${v.start.toInt().toString()}',
                  '${v.end.toInt().toString()}');
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
  final String value;
  bool isSelected;
  final returnSelectedChipName;

  filterChipWidget(
      {Key key, this.chipName, this.value, this.isSelected, this.returnSelectedChipName})
      : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Colors.black87, fontSize: 14.0, fontWeight: FontWeight.bold),
      selected: widget.isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: backgroundColor,
      onSelected: (selected) {
        setState(() {
          widget.isSelected = selected;
          widget.returnSelectedChipName(widget.value);
        });
      },
      selectedColor: Colors.black38,);
  }
}
