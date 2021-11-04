import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool val = true;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 10),
          child: ListView(
            children: [
              SwitchListTile(
                activeTrackColor: Colors.blue[200],
                activeColor: Colors.blue,
                title: Text('Notification'),
                subtitle: Text('Allow message notification'),
                value: val,
                onChanged: (bool value) {
                  setState(() {
                    val = value;
                  });
                },
                secondary: const Icon(Icons.notifications_sharp, color: Colors.black, size: 30,),
              )
            ],
          ),
        ),
      );
}
