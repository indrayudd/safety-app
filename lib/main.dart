import 'package:flutter/material.dart';
import 'package:iwa2/screens/add_contact.dart';
import 'package:iwa2/screens/show_contacts.dart';
import 'package:iwa2/screens/home.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/contacts': (context) => ContactsList(),
        '/add': (context) => Add(),
      },
    ));
