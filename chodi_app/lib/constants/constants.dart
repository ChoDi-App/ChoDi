import 'package:flutter/material.dart';

// Temporary solution -> Change to Theme Data

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

const primaryColor = Color.fromRGBO(186, 185, 185, 100.0);