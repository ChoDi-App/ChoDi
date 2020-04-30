import 'package:flutter/material.dart';

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const textInputDecoration = InputDecoration(
    filled: false,
    fillColor: Colors.transparent,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent,width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black,width: 2.0)
    )
);
