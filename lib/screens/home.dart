import 'package:flutter/material.dart';
import 'package:iwa2/contacts.dart';
import 'show_contacts.dart';
import 'package:iwa2/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<String> extractNames(List<Contact> contacts) {
  List<String> names = [];
  for (int i = 0; i < contacts.length; i++) {
    names.add(contacts[i].name);
  }
  return names;
}

Map convertToMap(List<Contact> contacts) {
  Map res = {};
  for (int i = 0; i < contacts.length; i++) {
    res[contacts[i].name] = contacts[i].number;
  }
  return res;
}

class _HomeState extends State<Home> {
  List<String> names = [];
  String initialString = "";
  Map thestuff = {};
  List<Contact> contacts = globals.contacts;
  // List<Contact> contacts = [
  //   Contact(name: "Ma", number: "9830650100"),
  //   Contact(name: "Baba", number: "9836106501"),
  //   Contact(name: "Rishi", number: "7003515250"),
  //   Contact(name: "Radhika", number: "9836106501"),
  //   Contact(name: "Gayathri", number: "9836106501"),
  // ];
  _HomeState() {
    if (contacts.isEmpty) {
      contacts = globals.emptycontacts;
    }
    this.names = extractNames(contacts);
    this.initialString = names[0];
    this.thestuff = convertToMap(contacts);
    print(thestuff);
    print(thestuff[names[0]]);
  }

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      contacts = globals.emptycontacts;
    }
    this.names = extractNames(contacts);
    this.initialString = names[0];
    this.thestuff = convertToMap(contacts);
    print(thestuff);
    print(thestuff[names[0]]);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/contacts');
                  if (globals.contacts.isNotEmpty) {
                    setState(() {
                      contacts = globals.contacts;
                    });
                  } else
                    setState(() {
                      contacts = globals.emptycontacts;
                    });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.cyan[900],
                ))
          ],
          centerTitle: false,
          title: Text(
            'I Need Attention',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Container(
          color: Colors.cyan[50],
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: initialString,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 12.0,
                      onChanged: (String? newValue) {
                        setState(() {
                          initialString = newValue!;
                          print(thestuff[newValue]);
                        });
                      },
                      items:
                          names.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
