import 'package:flutter/material.dart';
import 'package:iwa2/contacts.dart';
import 'package:iwa2/globals.dart' as globals;

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  String nam = "";
  String ph = "";
  int limit = 0;
  bool isEnabled = true;

  // List<Contact> contacts = [
  //   Contact(name: "Ma", number: "9830650100"),
  //   Contact(name: "Baba", number: "9836106501"),
  //   Contact(name: "Rishi", number: "7003515250"),
  //   Contact(name: "Radhika", number: "9836106501"),
  //   Contact(name: "Gayathri", number: "9836106501"),
  // ];
  _ContactsListState() {
    this.limit = globals.contacts.length;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildNam() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Name', prefixIcon: Icon(Icons.person_outline_rounded)),
      enabled: isEnabled,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      onSaved: (value) {
        nam = value!;
      },
    );
  }

  Widget buildPh() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number', prefixIcon: Icon(Icons.phone)),
      enabled: isEnabled,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required Field';
        }

        return null;
      },
      onSaved: (value) {
        ph = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    limit = globals.contacts.length;
    if (limit == 5)
      isEnabled = false;
    else
      isEnabled = true;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.cyan[900]),
          title: Text(
            'Numbers',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: Colors.cyan[50],
          elevation: 0.5,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            //if (limit < 5)
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                    //   child: Text(
                    //     'Placeholder',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    buildNam(),
                    buildPh(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            else if (states.contains(MaterialState.disabled))
                              return Color(0xFFD6D6D6);
                            return Color(0xFF80DEEA);
                          }),
                          //MaterialStateProperty.all(Color(0xFF80DEEA)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.black)))),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: (limit == 5)
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              _formKey.currentState!.save();
                              setState(() {
                                globals.contacts
                                    .add(Contact(name: nam, number: ph));
                                _formKey.currentState!.reset();
                              });

                              //Send to API
                            },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1.0,
              indent: 20,
              endIndent: 20,
              color: Colors.cyan[900],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                height: globals.contacts.length * 80,
                child: ListView.builder(
                    itemCount: globals.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = globals.contacts[index].name;
                      return Dismissible(
                        key: Key(contact),
                        onDismissed: (direction) {
                          setState(() {
                            globals.contacts.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('$contact\'s Number Deleted'),
                          ));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(globals.contacts[index].name),
                            subtitle: Text(globals.contacts[index].number),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
