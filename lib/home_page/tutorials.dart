import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/database/database.dart';
import 'package:museum_app/graphql/query.dart';

class Tutorials extends StatefulWidget {
  Tutorials({Key key}) : super(key: key);

  @override
  _TutorialsState createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  QueryBackend addQuery = QueryBackend();

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
              children: <Widget>[
                Text('Tutorials'),
              ]),
        ),
        body: FutureBuilder(
            future: MuseumDatabase().accessToken(),
            builder: (context, snap) {
              String accessToken = snap.data ?? "";
              return Column(children: [
                Query(
                  /*options: MutationOptions(
              documentNode:
                  gql(MutationBackend.createUser("asdf", "Maria123")),
              //variables: <String, dynamic>{"code": "AS"},
              update: (cache, result) => cache,
              onCompleted: (result) {
                if (result is LazyCacheMap)
                  print(result.data);
              },
              onError: (e) => print("ERROR"),
            ),*/
                  options: QueryOptions(
                    documentNode: gql(QueryBackend.allObjects(accessToken)),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    if (result.hasException) {
                      print(result.exception.toString());
                      return Text(result.exception.toString());
                    }
                    if (result.loading)
                      return Text("LOADING");
                    print(result.data);
                    return Text("ASDF");
                  },
                ),
              ]);
            }),
      ),
    );
  }
}

// class Tutorials1 extends StatelessWidget {
//   final QueryBackend addMutation = QueryBackend();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         title:
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
//           Text('Tutorials'),
//         ]),
//       ),
//       body: Query(
//         options: QueryOptions(
//             document: query,
//             variables: <String, dynamic>{"code": "AS"},
//             pollInterval: 1),
//         builder: (
//           QueryResult result, {
//           VoidCallback refetch,
//           FetchMore fetchMore,
//         }) {
//           if (result.loading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (result.data == null) {
//             return Text("No Data Found !");
//           }
//           return ListView.builder(
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title:
//                     Text(result.data['continent']['countries'][index]['name']),
//               );
//             },
//             itemCount: result.data['continent']['countries'].length,
//           );
//         },
//       ),
//     ));
//   }
// }
