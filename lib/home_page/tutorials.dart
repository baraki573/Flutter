import 'package:flutter/material.dart';

class Tutorials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              leading: Padding(
                padding: EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Text('Tutorials'),
                ]
              ),
              
            ),
            body: Container(
              decoration: BoxDecoration(color: Colors.white),
            )));
  }
}