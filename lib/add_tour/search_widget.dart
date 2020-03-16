import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/database.dart';

class MuseumSearch extends StatefulWidget {
  final Function funct;
  static TextEditingController ctrl = TextEditingController(text: "A");

  const MuseumSearch(this.funct, {Key key}) : super(key: key);

  _MuseumSearchState createState() => _MuseumSearchState();
}

class _MuseumSearchState extends State<MuseumSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: MuseumSearch.ctrl,
          onChanged: (s) => setState(() {}),
          decoration: InputDecoration(
            labelText: "Suche...",
            icon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        Expanded(
          child: Container(
            //color: Colors.red,
            child: StreamBuilder(
              stream: MuseumDatabase.get().stopSearch(MuseumSearch.ctrl.text),
              builder: (context, snap) {
                List<Stop> lst = snap?.data;
                if (lst == null) return Container();
                if (lst.isEmpty) {
                  var text = MuseumSearch.ctrl.text.isEmpty
                      ? "Gib einen Begriff oben ein, um die Suche zu starten."
                      : "Leider konnte kein passendes Objekt zu dieser Suchanfrage gefunden werden.";
                  return Center(child: Text(text, textAlign: TextAlign.center));
                }
                return Scrollbar(
                  child: ListView(
                    children: lst
                        .map((s) => ListTile(
                              onTap: () {
                                widget.funct(s);
                                Navigator.pop(context);
                              },
                              trailing: Icon(Icons.arrow_forward),
                              title: Text(s.name),
                              subtitle: Text("Abteilung " + s.devision),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
